using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseItem_AreaEffect : TowerDefenseItemBase
{
	private int templeteID = 6202101;

	private readonly string[] fxAlias = new string[1] { "Misc/FateCard/Theme_WindArea_1" };

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		Debug.LogError($"grid position = {position}");
		PlayAreaEffect(templeteID, fxAlias, position);
		yield return null;
	}
}
