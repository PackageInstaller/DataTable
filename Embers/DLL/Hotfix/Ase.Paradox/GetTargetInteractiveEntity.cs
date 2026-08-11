using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取目标交互物实体", 0)]
[Description("获取目标交互物实体")]
[Category("✫ DragonLost/Entity")]
public class GetTargetInteractiveEntity : ActionTaskBase
{
	[Name("交互物类型", 0)]
	public BBParameter<int> EntityType;

	[ParadoxNotion.Design.Space(10)]
	[Name("是否可使用", 0)]
	public BBParameter<bool> IsUsable;

	[Name("可使用交互物的位置", 0)]
	public BBParameter<Vector3> UsableInteractiveEntityPosition;

	protected override void OnExecute()
	{
		base.OnExecute();
		IsUsable.value = false;
		UsableInteractiveEntityPosition.value = Vector3.zero;
		BattleSystem battleSystem = ownerEntity?.GetSystem<BattleSystem>();
		if (battleSystem == null || battleSystem.BattleMode == BattleWorldMode.LevelBattle)
		{
			EndAction();
			return;
		}
		EntitySystem entitySystem = ownerEntity?.GetSystem<EntitySystem>();
		if (entitySystem == null)
		{
			EndAction();
			return;
		}
		List<BaseEntity> allEntity = entitySystem.GetAllEntity();
		if (allEntity.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		List<BaseEntity> list = new List<BaseEntity>();
		bool flag = false;
		foreach (BaseEntity item in allEntity)
		{
			if (item is InteractiveEntity interactiveEntity)
			{
				if (interactiveEntity.GetData<int>(Constant.InteractiveConstant.MAPITEMTYPE) != EntityType.value)
				{
					continue;
				}
				InteractiveStateComponent component = interactiveEntity.GetComponent<InteractiveStateComponent>();
				if (component != null)
				{
					if (component.IsCanInteractive)
					{
						list.Add(item);
					}
					else if (component.IsInteractiving)
					{
						list.Add(item);
						flag = true;
					}
				}
			}
			else if (item is BattleInteractiveEntity battleInteractiveEntity)
			{
				if (battleInteractiveEntity.GetData<int>(Constant.InteractiveConstant.MAPITEMTYPE) != EntityType.value)
				{
					continue;
				}
				InteractiveStateComponent component2 = battleInteractiveEntity.GetComponent<InteractiveStateComponent>();
				if (component2 != null)
				{
					if (component2.IsCanInteractive)
					{
						list.Add(item);
					}
					else if (component2.IsInteractiving)
					{
						list.Add(item);
						flag = true;
					}
				}
			}
			else
			{
				if (!(item is SyncBattleInteractiveEntity syncBattleInteractiveEntity) || syncBattleInteractiveEntity.GetData<int>(Constant.InteractiveConstant.MAPITEMTYPE) != EntityType.value)
				{
					continue;
				}
				BattleInteractiveStateComponent component3 = syncBattleInteractiveEntity.GetComponent<BattleInteractiveStateComponent>();
				if (component3 != null && component3.CanInteractive)
				{
					list.Add(item);
					if (component3.InteractivintCount > 0)
					{
						flag = true;
					}
				}
			}
		}
		if ((EntityType.value == 7001 && list.Count == 1) & flag)
		{
			EndAction();
			return;
		}
		float num = float.MaxValue;
		BaseEntity baseEntity = null;
		foreach (BaseEntity item2 in list)
		{
			float num2 = TSUtil.Vector3DistanceSqr(ownerEntity.transform.position, item2.transform.position);
			if (num2 < num)
			{
				baseEntity = item2;
				num = num2;
			}
		}
		if (baseEntity != null)
		{
			IsUsable.value = true;
			UsableInteractiveEntityPosition.value = baseEntity.transform.position;
		}
		EndAction();
	}
}
