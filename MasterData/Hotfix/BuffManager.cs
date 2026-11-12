using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

public class BuffManager : Singleton<BuffManager>
{
	public struct InheritBuffInfo
	{
		public int id;

		public int num;

		public FP leftTime;
	}

	public enum BuffAddType
	{
		Normal,
		BuffNum,
		GroupIdBySort,
		BuffInstanceLimit
	}

	public enum BuffAddFailType
	{
		PrimeState,
		GroupIdBySort,
		BuffInstanceLimit
	}

	public enum BuffRemoveType
	{
		Normal,
		ReycleClear,
		BuffNum,
		TimeFinish,
		PrimeState,
		GroupIdBySort,
		BuffInstanceLimit
	}

	public enum ImmunityBuffType
	{
		Add_Imm,
		Remove_Imm
	}

	private int buffUid;

	public AdventureActorReceiveDamageEvent _evt;

	public readonly List<InheritBuffInfo> _inheritBuffs = new List<InheritBuffInfo>(5);

	protected readonly Stack<BuffEntity> _buffPoolDatas = new Stack<BuffEntity>(30);

	public int _reduceCount;

	public readonly List<BuffCom> reduceTimeList = new List<BuffCom>();

	public bool CanReduceBuffTime
	{
		get
		{
			if (reduceTimeList == null)
			{
				return false;
			}
			return reduceTimeList.Count > 0;
		}
	}

	public BuffEntity GetBuffEntity(Buff buffConfig, BuffValue buffValueConfig, BuffCom buffc, AdventureActor fromActor)
	{
		BuffEntity buffEntity = ((_buffPoolDatas.Count > 0) ? _buffPoolDatas.Pop() : new BuffEntity());
		buffEntity.InitBuff(buffConfig, buffValueConfig, buffc, fromActor);
		return buffEntity;
	}

	public void EnterBuffPool(BuffEntity buffEn)
	{
		if (buffEn != null && !buffEn.InPool)
		{
			buffEn.OnClear();
			_buffPoolDatas.Push(buffEn);
		}
	}

	public void ClearBuffDatas()
	{
		Singleton<BuffEffectManager>.Instance.Clear();
		_buffPoolDatas?.Clear();
	}

	public int CreateBuffUid()
	{
		buffUid++;
		return buffUid;
	}

	public void AddBuffReduceTime(BuffCom bfc)
	{
		reduceTimeList.Add(bfc);
	}

	public void RemoveBuffReduceTime(BuffCom bfc)
	{
		reduceTimeList.Remove(bfc);
	}

	public void SetInhertBuff(BuffEntity _entity)
	{
		InheritBuffInfo item = new InheritBuffInfo
		{
			id = _entity.buffConfig.Id,
			num = _entity.GetBuffNum(),
			leftTime = _entity.GetBuffLeftTime()
		};
		_inheritBuffs.Add(item);
	}

	public void InhertBuff(BuffCom _buffC)
	{
		if (_inheritBuffs != null && _inheritBuffs.Count >= 1)
		{
			for (int i = 0; i < _inheritBuffs.Count; i++)
			{
				_buffC.ResetBuff(_inheritBuffs.get_Item(i).id, _inheritBuffs.get_Item(i).num, _inheritBuffs.get_Item(i).leftTime);
			}
			_inheritBuffs.Clear();
		}
	}

	public void AddBufftoGroup(int buffID, AdventureActor fromActor, int num = 1)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuffNum(buffID, num, fromActor);
		}
	}

	public void RemoveBufftoGroup(int buffID)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.RemoveBuffByBuffId(buffID);
		}
	}

	public void SetBuffNumtoGroup(int buffID, int num, AdventureActor fromActor = null)
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (num > 0 && fromActor != null)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuffNum(buffID, num, fromActor);
			}
			else if (num < 0)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.RemoveBuffByBuffId(buffID, num);
			}
		}
	}

	public void AddBuffToTarget(int id = 0, int groupID = 0)
	{
		if (id > 0)
		{
			AddBuffAction addBuffAction = Singleton<HotfixDataController>.Instance.GetAddBuffAction(id);
			AddbuffByTarget(addBuffAction);
		}
		if (groupID <= 0)
		{
			return;
		}
		foreach (AddBuffAction value in Singleton<HotfixDataController>.Instance.AddBuffActionData.Values)
		{
			if (value.Id != id && value.GroupId == groupID)
			{
				AddbuffByTarget(value);
			}
		}
	}

	private void AddbuffByTarget(AddBuffAction _data)
	{
		if (_data == null)
		{
			return;
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		switch (_data.TargetType)
		{
		case 1:
		{
			if (monsterActors != null)
			{
				for (int l = 0; l < monsterActors.Count; l++)
				{
					MonsterAdventureActor monsterAdventureActor3 = monsterActors.get_Item(l) as MonsterAdventureActor;
					if (monsterAdventureActor3 != null && !monsterAdventureActor3.isDead && monsterAdventureActor3.buffComponent != null)
					{
						monsterAdventureActor3.buffComponent.AddBuff(_data.BuffId, monsterAdventureActor3);
					}
				}
			}
			if (playerActors == null)
			{
				break;
			}
			for (int m = 0; m < playerActors.Count; m++)
			{
				PlayerAdventureActor playerAdventureActor = playerActors.get_Item(m) as PlayerAdventureActor;
				if (playerAdventureActor != null && !playerAdventureActor.isDead && playerAdventureActor.buffComponent != null)
				{
					playerAdventureActor.buffComponent.AddBuff(_data.BuffId, playerAdventureActor);
				}
			}
			break;
		}
		case 4:
		{
			if (monsterActors == null)
			{
				break;
			}
			for (int k = 0; k < monsterActors.Count; k++)
			{
				MonsterAdventureActor monsterAdventureActor2 = monsterActors.get_Item(k) as MonsterAdventureActor;
				if (monsterAdventureActor2 != null && !monsterAdventureActor2.isDead && monsterAdventureActor2.monsterInfo.subType != HotfixEnum.monsterSubType.Trap && monsterAdventureActor2.buffComponent != null)
				{
					monsterAdventureActor2.buffComponent.AddBuff(_data.BuffId, monsterAdventureActor2);
				}
			}
			break;
		}
		case 5:
		{
			if (monsterActors == null)
			{
				break;
			}
			for (int j = 0; j < monsterActors.Count; j++)
			{
				MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(j) as MonsterAdventureActor;
				if (monsterAdventureActor != null && !monsterAdventureActor.isDead && monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Trap && monsterAdventureActor.buffComponent != null)
				{
					monsterAdventureActor.buffComponent.AddBuff(_data.BuffId, monsterAdventureActor);
				}
			}
			break;
		}
		case 2:
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null && !activedPlayerActor.isDead)
			{
				activedPlayerActor.buffComponent.AddBuff(_data.BuffId, activedPlayerActor);
			}
			break;
		}
		case 3:
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuff(_data.BuffId, SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i));
			}
			break;
		}
		}
	}
}
