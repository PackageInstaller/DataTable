using System.Collections;
using Nova.Hotfix;
using TrueSync;

namespace AIScript;

public class TowerDefenseItem_AreaEffect_IceArea : TowerDefenseItemBase
{
	private int templeteID = 8099901;

	private readonly string[] fxAlias = new string[3] { "Misc/TowerDefence/ItemPrefab/IceArea/AreaEffect_IceArea_Buff", "Misc/TowerDefence/ItemPrefab/IceArea/AreaEffect_IceArea_FX", "Misc/TowerDefence/ItemPrefab/IceArea/AreaEffect_IceArea_Hit" };

	public override void InitConfig(TowerDefenseItem itemData)
	{
		base.InitConfig(itemData);
		indicatorRange = 7;
	}

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		PlayAreaEffect(templeteID, fxAlias, position);
		yield break;
	}
}
