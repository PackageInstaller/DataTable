using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/AI与技能/添加、移除BUFF", 0)]
public class Task_OperateEntityBuffs : TaskCellBase
{
	public enum TargetType
	{
		Faction
	}

	public bool isAddOrRemove = true;

	public TargetType targetType;

	public List<int> factionTypes;

	public List<int> buffs;

	protected override void OnExecute()
	{
		if (buffs == null || buffs.Count == 0)
		{
			return;
		}
		if (targetType == TargetType.Faction)
		{
			if (factionTypes == null || factionTypes.Count == 0)
			{
				return;
			}
			List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
			if (playerActors != null)
			{
				for (int i = 0; i < playerActors.Count; i++)
				{
					AdventureActor adventureActor = playerActors.get_Item(i) as AdventureActor;
					if (!adventureActor.isDead && IsFactionSatis(adventureActor.actorInfo.factionID))
					{
						if (isAddOrRemove)
						{
							adventureActor.buffComponent.AddBuffs(buffs, GetOwnerFakeActor());
						}
						else
						{
							adventureActor.buffComponent.RemoveBuffs(buffs);
						}
					}
				}
			}
			playerActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
			if (playerActors != null)
			{
				for (int j = 0; j < playerActors.Count; j++)
				{
					AdventureActor adventureActor2 = playerActors.get_Item(j) as AdventureActor;
					if (!adventureActor2.isDead && IsFactionSatis(adventureActor2.actorInfo.factionID))
					{
						if (isAddOrRemove)
						{
							adventureActor2.buffComponent.AddBuffs(buffs, GetOwnerFakeActor());
						}
						else
						{
							adventureActor2.buffComponent.RemoveBuffs(buffs);
						}
					}
				}
			}
			playerActors = ModuleController<AdventureModuleController>.Instance.traps;
			if (playerActors != null)
			{
				for (int k = 0; k < playerActors.Count; k++)
				{
					AdventureActor adventureActor3 = playerActors.get_Item(k) as AdventureActor;
					if (!adventureActor3.isDead && IsFactionSatis(adventureActor3.actorInfo.factionID))
					{
						if (isAddOrRemove)
						{
							adventureActor3.buffComponent.AddBuffs(buffs, GetOwnerFakeActor());
						}
						else
						{
							adventureActor3.buffComponent.RemoveBuffs(buffs);
						}
					}
				}
			}
		}
		EndAction();
		bool IsFactionSatis(int factionID)
		{
			return factionTypes.Contains(factionID);
		}
	}
}
