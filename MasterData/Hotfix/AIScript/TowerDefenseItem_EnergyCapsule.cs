using System.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseItem_EnergyCapsule : TowerDefenseItemBase
{
	private FP chargePercent = 100;

	private const string EFFECT1 = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_skill_charge_light_ring.prefab";

	private const string EFFECT2 = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_skill_charge_light.prefab";

	public override void InitConfig(TowerDefenseItem itemData)
	{
		base.InitConfig(itemData);
		indicatorRange = 4.5f;
	}

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_skill_charge_light_ring.prefab", new Vector3((float)position.x, 0f, (float)position.y));
		if (actOnEntities == null || actOnEntities.Count == 0)
		{
			yield break;
		}
		TowerDefenseEnergyCapsuleEvent towerDefenseEnergyCapsuleEvent = TowerDefenseEnergyCapsuleEvent.Generate();
		towerDefenseEnergyCapsuleEvent.chargePercent = chargePercent;
		for (int i = 0; i < actOnEntities.Count; i++)
		{
			LogicEntity logicEntity = actOnEntities.get_Item(i);
			if (!(null == logicEntity) && logicEntity.ActiveSelf && TSVector2.Distance(position, logicEntity.tsTransform.Position) <= indicatorRange)
			{
				towerDefenseEnergyCapsuleEvent.entityID = logicEntity.Id;
				PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_skill_charge_light.prefab", logicEntity.transform.position);
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefenseEnergyCapsuleEvent);
			}
		}
	}
}
