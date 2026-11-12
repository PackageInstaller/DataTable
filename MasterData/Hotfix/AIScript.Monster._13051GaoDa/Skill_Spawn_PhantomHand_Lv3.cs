using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Spawn_PhantomHand_Lv3 : SkillSimpleBase
{
	protected static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	private float GroundFxSize;

	private float FxSize;

	protected override void OnSkillEnable()
	{
		FxSize = 2.5f;
		GroundFxSize = 1f;
	}

	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable();
		Skill_Spawn_PhantomHand_Lv3 skill_Spawn_PhantomHand_Lv = this;
		TSVector2 position = GetPosition();
		float groundFxSize = GroundFxSize;
		skill_Spawn_PhantomHand_Lv.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position, default, groundFxSize);
		yield return WaitTime(0.15);
		Skill_Spawn_PhantomHand_Lv3 skill_Spawn_PhantomHand_Lv2 = this;
		position = GetPosition();
		groundFxSize = FxSize;
		skill_Spawn_PhantomHand_Lv2.PlayEffect("fx_common_base_monster_in", 1f, default, position, default, groundFxSize);
		EnterSneakWithDynamicTransparentByDistance(0, 99999, 0.75, 0);
		yield return WaitTime(0.5);
		SetHideModelDisable();
		yield return WaitTime(1);
	}
}
