using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Spawn_Hardcore : SkillSimpleBase
{
	protected static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	private string SpawnMode;

	private float GroundFxSize;

	private float FxSize;

	protected override void OnSkillEnable()
	{
		if (_actor.dataID == GetTeammateIdByIndex(0))
		{
			SpawnMode = "Master";
			FxSize = 5f;
			GroundFxSize = 1.5f;
		}
		else
		{
			SpawnMode = "Hand";
			FxSize = 2.5f;
			GroundFxSize = 1f;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Spawn_Hardcore skill_Spawn_Hardcore = this;
		TSVector2 position = GetPosition();
		float groundFxSize = GroundFxSize;
		skill_Spawn_Hardcore.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position, default, groundFxSize);
		yield return WaitTime(0.15);
		Skill_Spawn_Hardcore skill_Spawn_Hardcore2 = this;
		position = GetPosition();
		groundFxSize = FxSize;
		skill_Spawn_Hardcore2.PlayEffect("fx_common_base_monster_in", 1f, default, position, default, groundFxSize);
		SetLogicTagToggleValue(_actor, "IsHardcore", value: true);
		if (SpawnMode == "Master")
		{
			SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.right, 4);
			SummonTeammate(3, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.left, 4);
			BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.5);
			SetHideModelDisable();
			ReplaceAnimationGroup();
			ShowCenterHpBar();
			SetBattleOutDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			yield return WaitTime(0.5);
			SetHideModelDisable();
			SetBattleOutDisable();
		}
	}
}
