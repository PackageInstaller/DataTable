using System.Collections;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Skill_LuoDeng : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private readonly int summonedChessId = 100505;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	private static readonly int BuffID = 505810001;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.6);
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, new TSVector2(-6, -6), RotateTo(TSVector2.down, GetRandomValue(0, 180)).GetAngle(), isClearSelf: false, inheritAttr: false);
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, new TSVector2(6, -6), RotateTo(TSVector2.down, GetRandomValue(0, 180)).GetAngle(), isClearSelf: false, inheritAttr: false);
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, new TSVector2(0, 6), RotateTo(TSVector2.down, GetRandomValue(0, 180)).GetAngle(), isClearSelf: false, inheritAttr: false);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
