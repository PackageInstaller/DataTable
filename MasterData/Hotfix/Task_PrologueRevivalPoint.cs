using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/序章关卡与引导/序章复活点", 0)]
public class Task_PrologueRevivalPoint : TaskCellBase
{
	public int RevivalPointId;

	public TSVector2 revivalPos;

	public List<string> btnNames = new List<string>();

	protected override void OnExecute()
	{
		if (RevivalPointId <= 0)
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		AdventurePrologueBattleRevival adventurePrologueBattleRevival = AdventurePrologueBattleRevival.Generate();
		adventurePrologueBattleRevival.names = btnNames;
		adventurePrologueBattleRevival.revivalPos = revivalPos;
		adventurePrologueBattleRevival.revivalPoint = RevivalPointId;
		Dictionary<int, Dictionary<int, int>> personalPerkInfos = ModuleController<AdventureModuleController>.Instance.PersonalPerkInfos;
		adventurePrologueBattleRevival.PersonalPerkInfos = personalPerkInfos;
		List<int> perkThemes = ModuleController<AdventureModuleController>.Instance.PerkThemes;
		adventurePrologueBattleRevival.perkThemes = perkThemes;
		adventurePrologueBattleRevival.boxID = ModuleController<AdventureModuleController>.Instance.levelInstance.boxID;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurePrologueBattleRevival);
		EndAction();
	}
}
