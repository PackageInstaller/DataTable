using System.Collections.Generic;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Event;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using Unity.VisualScripting.Community;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/BehaveControlHandleBehaveEvent")]
public class BehaveControlHandleBehaveEvent : InteractControlBaseBehaveEvent
{
	private List<Entity> m_EntityBehaves = new List<Entity>();

	private PointMoveBehaveConfig m_BehaveBehaveConfig;

	private float curSanValue;

	private bool _isHaveCharacter;

	public bool isHaveMonster;

	public bool isHaveCharacter
	{
		get
		{
			return _isHaveCharacter;
		}
		set
		{
			if (_isHaveCharacter != value)
			{
				_isHaveCharacter = value;
				if (_isHaveCharacter)
				{
					m_BehaveBehaveConfig.inProgress.Handle(this);
				}
				else
				{
					m_BehaveBehaveConfig.outProgress.Handle(this);
				}
			}
		}
	}

	public override void Init(int state)
	{
		base.Init(state);
		m_BehaveBehaveConfig = data.behaveConfig as PointMoveBehaveConfig;
		m_EntityBehaves.Clear();
		curSanValue = 1f;
	}

	public override void RefreshRunEventIndex(int state)
	{
		base.RefreshRunEventIndex(state);
		CurrEventIndex++;
	}

	public override void RefreshRunState(int state)
	{
		base.RefreshRunState(state);
		if (state == 0)
		{
			curSanValue = 1f;
			m_BehaveBehaveConfig.resetProgress?.Handle(this);
		}
	}

	public override void RefreshTarPos()
	{
		if (CurrEventIndex <= behavePosInfos.Count - 1)
		{
			SetTarPos(behavePosInfos[CurrEventIndex].pos.value);
			RefreshAgent();
		}
	}

	private void RefreshAgent()
	{
		if (UseAgent)
		{
			CompNav? compNav = Entity.GetCompNav();
			compNav.destination = endPos;
			compNav.navPosition = Entity.GetCompTransform().physicsPosition;
		}
	}

	public void OnDrawGizmos()
	{
		for (int i = 0; i < behavePosInfos.Count; i++)
		{
			Gizmos.DrawSphere(behavePosInfos[i].pos.value, 1f);
		}
		Gizmos.DrawCube(endPos, new Vector3(1f, 1f, 1f));
	}

	public override bool AwaitHandleStopEvent()
	{
		if (CurrEventIndex > behavePosInfos.Count - 1)
		{
			FinishRun();
			return false;
		}
		BehaveEventType behaveEventType = behavePosInfos[CurrEventIndex].behaveEventType;
		if (behaveEventType != BehaveEventType.Pos && behaveEventType == BehaveEventType.Event && !behavePosInfos[CurrEventIndex].tarEvent.Handle(this))
		{
			return false;
		}
		if (CurrEventIndex == behavePosInfos.Count - 1)
		{
			FinishRun();
			return false;
		}
		ChangeState(CurrEventIndex + 1000);
		RefreshTarPos();
		return true;
	}

	private void HandleSanValueChange()
	{
		if (MonoECS.instance.running)
		{
			ChaseMissionProgressChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ChaseMissionProgressChangeEvt>();
			evt.preProgress = curSanValue;
			if (!isHaveCharacter)
			{
				curSanValue -= m_BehaveBehaveConfig.sanDownRate * Time.deltaTime * GameManager.timeSystem.LogicSpeed;
			}
			if (isHaveCharacter && !isHaveMonster)
			{
				curSanValue += m_BehaveBehaveConfig.sanUpRate * Time.deltaTime * GameManager.timeSystem.LogicSpeed;
			}
			curSanValue = Mathf.Clamp(curSanValue, 0f, 1f);
			evt.curProgress = curSanValue;
			evt.isDanger = curSanValue < m_BehaveBehaveConfig.dangerRange;
			if (evt.preProgress > 0f && curSanValue == 0f)
			{
				GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent("ZeroSan"));
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseMission_ProgressChange, evt);
		}
	}

	public override bool HandleBehaveEvent()
	{
		isHaveCharacter = HaveCharacter(m_BehaveBehaveConfig.characterCheckRadius);
		isHaveMonster = HaveMonster(m_BehaveBehaveConfig.monsterCheckRadius);
		Entity.SetBool("StartPanic", !isHaveCharacter || isHaveMonster);
		HandleSanValueChange();
		if (isHaveCharacter && !isHaveMonster)
		{
			m_BehaveBehaveConfig.monsterExitAndCharacterEnter?.Handle(this);
			RefreshTarPos();
			return true;
		}
		m_BehaveBehaveConfig.monsterEnterOrCharacterExit?.Handle(this);
		StopMove();
		return false;
	}

	private bool HaveCharacter(float radius)
	{
		Entity? entity = MonoECS.instance?.mainEntity;
		if (entity.HasValue)
		{
			Entity valueOrDefault = entity.GetValueOrDefault();
			if (valueOrDefault.IsValid && valueOrDefault.TryGetCompTransform(out CompTransform component))
			{
				return Vector2.Distance(component.physicsPosition, Entity.GetCompTransform().physicsPosition) < radius;
			}
		}
		return false;
	}

	private bool HaveMonster(float radius)
	{
		CompTransform compTransform = Entity.GetCompTransform();
		foreach (Entity entityBehafe in m_EntityBehaves)
		{
			if (entityBehafe.IsMonster() && entityBehafe.IsAlive() && Vector3.Distance(entityBehafe.GetCompTransform().physicsPosition, compTransform.physicsPosition) < radius)
			{
				return true;
			}
		}
		return false;
	}

	public override void OnTriggerEnter(Collider collision)
	{
		base.OnTriggerEnter(collision);
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if ((object)component != null && component.entity.IsMonster())
		{
			m_EntityBehaves.Add(component.entity);
		}
	}

	public override void OnTriggerExit(Collider collision)
	{
		base.OnTriggerExit(collision);
		MonoEntity component = collision.GetComponent<MonoEntity>();
		if ((object)component != null && component.entity.IsMonster())
		{
			m_EntityBehaves.Remove(component.entity);
		}
	}
}
