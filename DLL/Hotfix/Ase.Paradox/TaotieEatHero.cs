using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("饕餮吞人UI", 0)]
[Category("✫ DragonLost/Entity")]
[Description("显示或隐藏饕餮吞人UI。")]
public class TaotieEatHero : ActionTaskBase
{
	[RequiredField]
	[Name("骨骼名称", 0)]
	[Description("指定饕餮吞人UI所要附着的骨骼名称。")]
	public BBParameter<string> boneName;

	[RequiredField]
	[Name("英雄实体ID列表", 0)]
	[Description("被吞的英雄实体的ID列表。")]
	public BBParameter<List<int>> HeroEntityIdList;

	[RequiredField]
	[Name("是否显示", 0)]
	[Description("指示是否显示饕餮吞人UI。")]
	public bool IsShow;

	[Name("是否跟随行为树结束重置", 0)]
	[Description("指示是否在行为树结束时重置。")]
	public bool followTreeRecovery = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (HeroEntityIdList == null || HeroEntityIdList.value.Count == 0 || !IsShow)
		{
			ownerEntity.GetSystem<BattleSystem>().HideTaotieEatUI();
			EndAction();
			return;
		}
		if (ownerEntity is MonsterEntity { IsBoss: not false } monsterEntity)
		{
			List<HeroEntity> list = new List<HeroEntity>();
			foreach (int item in HeroEntityIdList.value)
			{
				if (ownerEntity.GetSystem<EntitySystem>().GetEntity(item) is HeroEntity { LogicType: not EntityLogicType.Display } heroEntity)
				{
					list.Add(heroEntity);
				}
			}
			Transform transform = monsterEntity.GetComponent<EntityBoneComponent>()?.GetBoneRoot(boneName.value);
			if (transform == null)
			{
				Toast.ShowError("饕餮，找不到绑点" + boneName.value + "，请检查！");
			}
			ownerEntity.GetSystem<BattleSystem>().ShowTaotieEatUI(list, transform);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null)
		{
			ownerEntity.GetSystem<BattleSystem>()?.HideTaotieEatUI();
		}
	}
}
