using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompHatred : EcsComponent
{
	public Entity hatredTarget;

	public bool isTemp;

	private Entity m_LastAttacker;

	public List<HatredData> hatredDateList = new List<HatredData>();

	public long battleStartTimeStamp;

	public int hatredLevel;

	public Entity lastAttacker
	{
		get
		{
			return m_LastAttacker;
		}
		set
		{
			if (m_LastAttacker == value)
			{
				return;
			}
			if (battleStartTimeStamp == 0L)
			{
				battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
			}
			m_LastAttacker = value;
			if (MonoECS.instance.mainEntity.IsValid)
			{
				MPPlayer localPlayer = MonoECS.instance.localPlayer;
				if (m_LastAttacker == MonoECS.instance.mainEntity && localPlayer.battleStartTimeStamp <= 0)
				{
					localPlayer.battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
				}
			}
		}
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		if (Model<WildBossModel>.HasInstance())
		{
			Model<WildBossModel>.Interface.EndWildBossBattle(owner);
		}
		Entity entity = hatredTarget;
		if (entity.IsValid)
		{
			hatredTarget = Entity.Invalid;
			HatredEntity evt = Singleton<EventManager>.instance.GetEvt<HatredEntity>();
			evt.entity = owner;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RemoveHatred, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		hatredTarget = Entity.Invalid;
		lastAttacker = Entity.Invalid;
		hatredDateList.Clear();
		battleStartTimeStamp = 0L;
		hatredLevel = 0;
	}

	public void SetHatred(Entity eb)
	{
		if (eb.InTag(EntityTag.UnHatable))
		{
			return;
		}
		if (battleStartTimeStamp == 0L)
		{
			battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
		}
		MonoECS instance = MonoECS.instance;
		if (eb == instance.mainEntity)
		{
			hatredTarget = instance.localPlayer.battleEntity;
			if (instance.localPlayer.battleStartTimeStamp <= 0)
			{
				instance.localPlayer.battleStartTimeStamp = TimeManager.LocalTime.NowTimestamp;
			}
			if (owner.GetEntityType() == EntityType.Boss)
			{
				instance.audioBattleMusic = owner.GetConfig().audioBattleMusic;
			}
			CompStateObject component = owner.GetComponent<CompStateObject>();
			if (component != null && component.StateWorldAssetData is MonsterPointData { serviceSaveTag: ServiceSaveTag.WildBoss } monsterPointData)
			{
				if (Model<WildBossModel>.HasInstance())
				{
					Model<WildBossModel>.Interface.StartWildBossBattle(owner);
				}
				Model<MonsterHandModel>.Interface.SendUnLockWildBoss(monsterPointData.monsterPointId);
			}
			HatredEntity evt = Singleton<EventManager>.instance.GetEvt<HatredEntity>();
			evt.entity = owner;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.AddHatred, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		else
		{
			hatredTarget = eb;
		}
	}

	public void ClearHatred()
	{
		if (Model<WildBossModel>.HasInstance())
		{
			Model<WildBossModel>.Interface.EndWildBossBattle(owner);
		}
		Entity entity = hatredTarget;
		if (entity.IsValid)
		{
			hatredTarget = default;
			HatredEntity evt = Singleton<EventManager>.instance.GetEvt<HatredEntity>();
			evt.entity = owner;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RemoveHatred, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		hatredTarget = default;
		battleStartTimeStamp = 0L;
		_ = owner.IsValid;
	}

	public Entity GetHatred()
	{
		if (hatredTarget.IsValid)
		{
			return hatredTarget;
		}
		ClearHatred();
		return default;
	}

	public bool HasHatredTarget()
	{
		return hatredTarget.IsValid;
	}

	public bool GetHatredTargetPos(out Vector3 pos)
	{
		if (hatredTarget.TryGetCompTransform(out CompTransform component))
		{
			pos = component.physicsPosition;
			return true;
		}
		pos = Vector3.zero;
		return false;
	}

	public Vector2 GetHatredTargetColliderSize()
	{
		Vector2 result = Vector2.zero;
		if (hatredTarget.IsValid && owner.TryGetCompTransform(out CompTransform component))
		{
			result = component.size;
		}
		return result;
	}

	public float GetDistanceBetweenMeAndHatredTarget(DistanceType distanceType)
	{
		if (hatredTarget.HasCompTransform() && owner.HasCompTransform())
		{
			return AbilityUtility.GetTwoPointDistance(owner, hatredTarget, distanceType);
		}
		return float.MaxValue;
	}

	public bool HatredIsInFront()
	{
		if (hatredTarget.HasCompTransform() && owner.HasCompTransform())
		{
			return BoolUtility.IsInFront(owner.IsFaceLeft(), owner.GetCompTransform().physicsPosition.x, hatredTarget.GetCompTransform().physicsPosition.x);
		}
		return false;
	}
}
