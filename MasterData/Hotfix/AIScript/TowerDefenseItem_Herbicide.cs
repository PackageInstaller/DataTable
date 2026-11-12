using System.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseItem_Herbicide : TowerDefenseItemBase
{
	private FP chargePercent = 100;

	private const string EFFECT1 = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_grass_end.prefab";

	private Vector3[] effectPositions;

	public override void InitConfig(TowerDefenseItem itemData)
	{
		base.InitConfig(itemData);
		indicatorRange = 3;
	}

	public void TakeEffectPositions(Vector3[] positions)
	{
		effectPositions = positions;
	}

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		if (effectPositions != null)
		{
			for (int i = 0; i < effectPositions.Length; i++)
			{
				PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_grass_end.prefab", effectPositions[i]);
			}
			effectPositions = null;
		}
		yield break;
	}
}
