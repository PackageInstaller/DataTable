using System;
using ACT.Battle;
using ACT.Event;
using ACT.UI;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/BehaveControlAnimMoveBehaveEvent")]
public class BehaveControlAnimMoveBehaveEvent : BehaveControlBaseBehaveEvent
{
	public BetterAnimation test;

	public InteractBehaveAnimControl interactBehaveAnimControl;

	protected AnimMoveControlData data;

	private bool m_InProgress;

	public Action<bool> onValueChange;

	public float currProgressRate;

	[NonSerialized]
	public bool fail;

	public bool failComplete;

	private AnimationBuilder play;

	public bool InProgress
	{
		get
		{
			return m_InProgress;
		}
		set
		{
			if (value != m_InProgress)
			{
				onValueChange(value);
				m_InProgress = value;
			}
		}
	}

	public override void Init(int state)
	{
		Anim = GetComponentInChildren<Animator>();
		data = interactBehaveAnimControl.entity.GetCompStateObject().StateWorldAssetData as AnimMoveControlData;
		onValueChange = OnProgressValueChange;
		play = null;
	}

	public override void RefreshRunState(int state)
	{
		Running = true;
		switch (state)
		{
		case -1:
		case 0:
		{
			fail = false;
			InProgress = false;
			Running = false;
			StopFlag = !Running;
			test.StopAnimation();
			data.behaveConfig.resetAciton.Handle(this);
			ChaseMissionProgressChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ChaseMissionProgressChangeEvt>();
			evt.preProgress = 0f;
			evt.curProgress = 0f;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseMission_ProgressChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		case 2:
			Running = false;
			StopFlag = !Running;
			break;
		case 3:
		{
			if (!StopFlag)
			{
				play.Pause();
			}
			bool inProgress = (Running = false);
			InProgress = inProgress;
			break;
		}
		case 4:
			if (!StopFlag)
			{
				play.Continue();
			}
			Running = true;
			break;
		case 1:
			ResetData();
			StopFlag = !Running;
			break;
		}
	}

	private void ResetData()
	{
		CurrEventIndex = -1;
		RefreshRunEventIndex();
		fail = (failComplete = false);
		data.behaveConfig.startRunning.Handle(this);
		foreach (ProgressAction progressAction in data.behaveConfig.progressActions)
		{
			progressAction.doAction.currState = EventState.WaitStart;
		}
		InProgress = false;
		currProgressRate = 0f;
	}

	public override void ChangeState(int state)
	{
		RefreshRunState(state);
		interactBehaveAnimControl.ChangeState(state);
	}

	public override bool AwaitHandleStopEvent()
	{
		if (failComplete)
		{
			FailComplete();
			return false;
		}
		if (CurrEventIndex < data.behavePosInfos.Count && !data.behavePosInfos[CurrEventIndex].tarEvent.Handle(this))
		{
			return false;
		}
		if (CurrEventIndex >= data.behavePosInfos.Count - 1)
		{
			if (fail)
			{
				FailComplete();
			}
			else
			{
				Finish();
			}
			return false;
		}
		RefreshRunEventIndex();
		return true;
	}

	private void Finish()
	{
		data.behaveConfig.finish.Handle(this);
		ChangeState(2);
	}

	private void FailComplete()
	{
		failComplete = true;
		ChangeState(-1);
	}

	public override bool HandleBehaveEvent()
	{
		if (fail || Mathf.Approximately(currProgressRate, 1f))
		{
			return true;
		}
		fail = !CheckCharacter(data.behaveConfig.failCheckRadius);
		InProgress = !fail && CheckCharacter(data.behaveConfig.progressCheckRadius);
		if (!InProgress)
		{
			return true;
		}
		float preProgress = currProgressRate;
		currProgressRate += data.behaveConfig.progressRate * Time.deltaTime;
		currProgressRate = Mathf.Clamp(currProgressRate, 0f, 1f);
		ChaseMissionProgressChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ChaseMissionProgressChangeEvt>();
		evt.preProgress = preProgress;
		evt.curProgress = currProgressRate;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseMission_ProgressChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		foreach (ProgressAction progressAction in data.behaveConfig.progressActions)
		{
			if (currProgressRate >= progressAction.progress && progressAction.doAction.currState != EventState.Finish)
			{
				progressAction.doAction.Handle(this);
			}
		}
		return true;
	}

	private void OnProgressValueChange(bool newValue)
	{
		if (newValue)
		{
			data.behaveConfig.inProgress.Handle(this);
		}
		else
		{
			data.behaveConfig.pauseProgress.Handle(this);
		}
	}

	public void Fail()
	{
		fail = true;
		InProgress = false;
	}

	private bool CheckCharacter(float radius)
	{
		if (MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid)
		{
			return false;
		}
		return Vector2.Distance(MonoECS.instance.mainEntity.GetCompTransform().physicsPosition, transform.position) < radius;
	}

	public override void StopMove()
	{
	}

	public override void SetTarPos(Vector3 tarPos)
	{
	}

	public override void RefreshRunEventIndex(int state = -100)
	{
		CurrEventIndex++;
	}

	public override bool RefreshMove()
	{
		if (play != null)
		{
			if (play.IsComplete())
			{
				failComplete = play.Name == data.behavePosInfos[CurrEventIndex].failName.ToLower();
				play = null;
				return true;
			}
			return false;
		}
		string animationName = (fail ? data.behavePosInfos[CurrEventIndex].failName : data.behavePosInfos[CurrEventIndex].normalName);
		play = test.GetSequence(animationName);
		if (play != null)
		{
			play.Play();
		}
		return false;
	}
}
