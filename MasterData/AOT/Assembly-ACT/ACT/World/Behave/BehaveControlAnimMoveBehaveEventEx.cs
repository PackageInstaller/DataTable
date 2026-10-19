using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Event;
using ACT.UI;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using Unity.VisualScripting.Community;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/BehaveControlAnimMoveBehaveEventEx")]
public class BehaveControlAnimMoveBehaveEventEx : BehaveControlBaseBehaveEvent
{
	public BetterAnimation test;

	public InteractBehaveAnimControlEx interactBehaveAnimControl;

	protected AnimMoveControlDataEx data;

	public const string StateObjectEvent_DroneDanger = "DroneDanger";

	public const string StateObjectEvent_DroneZeroSignal = "DroneZeroSignal";

	public const string StateObjectEvent_DroneFailRange = "DroneFailRange";

	public const string StateObjectEvent_DroneEndRoute = "DroneEndRoute";

	private bool m_InRange;

	public Action<bool> onValueChange;

	public float currCaptureVal;

	[NonSerialized]
	public bool fail;

	[NonSerialized]
	public bool toEnd;

	private bool currSpeedChanging;

	private bool currSpeedDown;

	private List<bool> toChangSpeed = new List<bool>();

	private float currSpeedTime;

	private AnimationBuilder play;

	public bool InRange
	{
		get
		{
			return m_InRange;
		}
		set
		{
			if (value != m_InRange)
			{
				onValueChange(value);
				m_InRange = value;
			}
		}
	}

	public override void Init(int state)
	{
		Anim = GetComponentInChildren<Animator>();
		data = interactBehaveAnimControl.entity.GetCompStateObject().StateWorldAssetData as AnimMoveControlDataEx;
		onValueChange = OnInRangeValueChange;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PushPause, OnGamePauseChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PopPause, OnGamePauseChanged);
	}

	private void OnGamePauseChanged(BaseEventContent evt)
	{
		if (Running)
		{
			if (!MonoECS.instance.running)
			{
				play.Pause();
			}
			else
			{
				play.Continue();
			}
		}
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PushPause, OnGamePauseChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PopPause, OnGamePauseChanged);
	}

	public override void RefreshRunState(int state)
	{
		Running = true;
		switch (state)
		{
		case -1:
		case 0:
		{
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
			if (!StopFlag)
			{
				play.Pause();
			}
			break;
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
		currCaptureVal = 1f;
		fail = false;
		play = test.GetSequence(data.behavePosInfo.routeName);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("Chase：开始进行路线：" + play.Name);
		}
		play.Play();
		data.behaveConfig.startRunning.Handle(this);
		foreach (ProgressAction progressAction in data.behaveConfig.progressActions)
		{
			progressAction.doAction.currState = EventState.WaitStart;
		}
		toEnd = false;
	}

	public override void ChangeState(int state)
	{
		RefreshRunState(state);
		interactBehaveAnimControl.ChangeState(state);
	}

	public override bool AwaitHandleStopEvent()
	{
		data.behavePosInfo.tarEvent.Handle(this);
		return false;
	}

	private void Finish()
	{
		ChangeState(2);
	}

	private void FailComplete()
	{
		ChangeState(-1);
	}

	public override bool HandleBehaveEvent()
	{
		if (fail || toEnd)
		{
			return true;
		}
		ChaseMissionProgressChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ChaseMissionProgressChangeEvt>();
		evt.preProgress = currCaptureVal;
		InRange = CheckCharacter(data.behaveConfig.captureCheckRadius);
		if (InRange)
		{
			currCaptureVal += data.behaveConfig.captureUpRate * Time.deltaTime * GameManager.timeSystem.LogicSpeed;
		}
		else
		{
			currCaptureVal -= data.behaveConfig.captureDownRate * Time.deltaTime * GameManager.timeSystem.LogicSpeed;
		}
		currCaptureVal = Mathf.Clamp(currCaptureVal, 0f, 1f);
		evt.curProgress = currCaptureVal;
		evt.isDanger = currCaptureVal < data.behaveConfig.dangerRange;
		if (evt.isDanger && evt.preProgress >= data.behaveConfig.dangerRange)
		{
			GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent("DroneDanger"));
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseMission_ProgressChange, evt);
		if (currCaptureVal < data.behaveConfig.speedChangeRange && evt.preProgress >= data.behaveConfig.speedChangeRange)
		{
			ChangeRouteAnimSpeed(flag: true);
		}
		if (currCaptureVal > data.behaveConfig.speedChangeRange && evt.preProgress <= data.behaveConfig.speedChangeRange)
		{
			ChangeRouteAnimSpeed(flag: false);
		}
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		if (currCaptureVal == 0f && !fail)
		{
			fail = true;
			GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent("DroneZeroSignal"));
		}
		if (CheckCharacterFailRange())
		{
			GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent("DroneFailRange"));
		}
		return true;
	}

	private void ChangeRouteAnimSpeed(bool flag)
	{
		if (currSpeedChanging && flag != currSpeedDown)
		{
			toChangSpeed.Add(flag);
			return;
		}
		currSpeedDown = flag;
		currSpeedChanging = true;
		currSpeedTime = 0f;
	}

	private void SmoothChangeSpeed()
	{
		if (currSpeedChanging)
		{
			currSpeedTime += Time.deltaTime * GameManager.timeSystem.LogicSpeed;
			float t = currSpeedTime / data.behaveConfig.speedChangeDuration;
			if (currSpeedDown)
			{
				play.SetSpeed(Mathf.Lerp(1f, data.behaveConfig.routeAnimSpeed, t));
				currSpeedChanging = play.GetSpeed() != data.behaveConfig.routeAnimSpeed;
			}
			else
			{
				play.SetSpeed(Mathf.Lerp(data.behaveConfig.routeAnimSpeed, 1f, t));
				currSpeedChanging = play.GetSpeed() != 1f;
			}
		}
		else if (toChangSpeed.Count > 0)
		{
			bool flag = toChangSpeed[toChangSpeed.Count - 1];
			toChangSpeed.RemoveAt(toChangSpeed.Count - 1);
			currSpeedDown = flag;
			currSpeedChanging = true;
			currSpeedTime = 0f;
		}
	}

	private bool CheckCharacterFailRange()
	{
		Entity? entity = MonoECS.instance?.mainEntity;
		if (entity.HasValue)
		{
			Entity valueOrDefault = entity.GetValueOrDefault();
			if (valueOrDefault.IsValid)
			{
				Vector3 physicsPosition = valueOrDefault.GetCompTransform().physicsPosition;
				for (int i = 0; i < data.behaveConfig.failCheckBounds.Length; i++)
				{
					if (data.behaveConfig.failCheckBounds[i].Contains(physicsPosition))
					{
						return false;
					}
				}
				return true;
			}
		}
		return true;
	}

	private void OnInRangeValueChange(bool newValue)
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

	private bool CheckCharacter(float radius)
	{
		Entity? entity = MonoECS.instance?.mainEntity;
		if (entity.HasValue)
		{
			Entity valueOrDefault = entity.GetValueOrDefault();
			if (valueOrDefault.IsValid)
			{
				return Vector2.Distance(valueOrDefault.GetCompTransform().physicsPosition, transform.position) < radius;
			}
		}
		return true;
	}

	public override void StopMove()
	{
	}

	public override void SetTarPos(Vector3 tarPos)
	{
	}

	public override void RefreshRunEventIndex(int state = -100)
	{
	}

	public int RemainTime()
	{
		if (play.Name.ToLower().Equals(data.behavePosInfo.routeName.ToLower()))
		{
			return play.RemainSeconds();
		}
		return 0;
	}

	public override bool RefreshMove()
	{
		if (play.Name.ToLower().Equals(data.behavePosInfo.routeName.ToLower()))
		{
			SmoothChangeSpeed();
			if (play.IsComplete())
			{
				GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent("DroneEndRoute"));
				toEnd = true;
				play = test.GetSequence(fail ? data.behavePosInfo.endEscapeName : data.behavePosInfo.endFallName);
				if (play != null)
				{
					play.Play();
				}
				if (!fail)
				{
					data.behaveConfig.success.Handle(this);
				}
			}
			return false;
		}
		if (play.IsComplete())
		{
			if (fail)
			{
				FailComplete();
			}
			else
			{
				Finish();
			}
		}
		return play.IsComplete();
	}
}
