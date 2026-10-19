using System.Collections.Generic;
using ACT.Battle;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/InteractControlBaseBehaveEvent")]
public class InteractControlBaseBehaveEvent : BehaveControlBaseBehaveEvent
{
	public InteractBehaveControl interactBehaveControl;

	protected Vector3 endPos;

	protected InteractBehaveControlData data;

	protected List<EventInfo> behavePosInfos;

	protected bool stop;

	public bool UseAgent => data.behaveConfig.useAgent;

	public virtual float StopDistance => data.behaveConfig.stopDistance;

	public override bool StopFlag
	{
		get
		{
			if (!UseAgent)
			{
				return stop;
			}
			return Entity.GetCompNav().isStopped;
		}
		protected set
		{
			if (UseAgent)
			{
				Entity.GetCompNav().isStopped = value;
			}
			else
			{
				stop = value;
			}
		}
	}

	public override void Init(int state)
	{
		Entity = interactBehaveControl.ControlEb;
		data = Entity.GetCompStateObject().StateWorldAssetData as InteractBehaveControlData;
		behavePosInfos = GameUtility.DeepCloneByOdin(data?.behavePosInfos) ?? new List<EventInfo>();
		TriggerBox = GetComponentInChildren<SphereCollider>();
		if (data.behaveConfig.triggerBoxRadius <= 0f)
		{
			TriggerBox.enabled = false;
		}
		else
		{
			TriggerBox.enabled = true;
			TriggerBox.radius = data.behaveConfig.triggerBoxRadius;
		}
		Entity.GetBTree().Stop();
		if (state >= 1000)
		{
			RefreshRunEventIndex(state);
		}
	}

	public override void RefreshRunState(int state)
	{
		Running = true;
		switch (state)
		{
		case -1:
		case 0:
		case 2:
			Running = false;
			break;
		case 1:
			foreach (EventInfo behavePosInfo in behavePosInfos)
			{
				if (behavePosInfo.behaveEventType == BehaveEventType.Event)
				{
					behavePosInfo.tarEvent.ReSet(this);
				}
			}
			RefreshRunEventIndex(state);
			break;
		}
		StopFlag = !Running;
	}

	public virtual void FinishRun()
	{
		ChangeState(2);
	}

	public override void RefreshRunEventIndex(int state = -100)
	{
		if (state < 1000)
		{
			if (state == 1)
			{
				CurrEventIndex = -1;
			}
		}
		else
		{
			CurrEventIndex = state - 1000;
		}
	}

	public override bool AwaitHandleStopEvent()
	{
		return true;
	}

	public override bool HandleBehaveEvent()
	{
		return true;
	}

	public override void ChangeState(int state)
	{
		RefreshRunState(state);
		RefreshRunEventIndex(state);
		interactBehaveControl.ChangeState(state);
	}

	public virtual void RefreshTarPos()
	{
	}

	public override void StopMove()
	{
		SetTarPos(Entity.GetCompTransform().physicsPosition);
		RefreshMove();
	}

	public override void SetTarPos(Vector3 tarPos)
	{
		endPos = tarPos;
	}

	public override bool RefreshMove()
	{
		bool flag = Mathf.Abs(Entity.GetCompTransform().physicsPosition.x - endPos.x) < StopDistance;
		if (UseAgent)
		{
			Entity.GetCompNav().destination = endPos;
		}
		else
		{
			ManualMove(flag);
		}
		return flag;
	}

	private void ManualMove(bool isArrived)
	{
		if (isArrived)
		{
			Entity.SetBool("Move", value: false);
			if (Entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
			{
				Entity.SetBool("DirRight", value: false);
				Entity.SetBool("DirLeft", value: false);
			}
			Entity.SetBool("turn", value: false);
			return;
		}
		Entity.SetBool("Move", value: true);
		Vector3 vector = endPos;
		Vector3 physicsPosition = Entity.GetCompTransform().physicsPosition;
		bool flag = vector.x < physicsPosition.x;
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		if (flag)
		{
			Entity.SetBool("turn_to_left", value: true);
			Entity.SetBool("turn_to_right", value: false);
		}
		else
		{
			Entity.SetBool("turn_to_left", value: false);
			Entity.SetBool("turn_to_right", value: true);
		}
		Entity.SetBool("turn", Entity.GetFaceDir() != faceDir);
	}
}
