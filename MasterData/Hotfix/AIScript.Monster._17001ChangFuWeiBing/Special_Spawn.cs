using System.Collections;
using TrueSync;

namespace AIScript.Monster._17001ChangFuWeiBing;

public class Special_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private static readonly string airBorneDeathEffectAlias = "fx_common_base_die_airborne";

	private readonly string fx_Alias = "fx_switch_monster_actor";

	private static readonly FP effectDuration = 2f;

	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		TSVector2 position = GetPosition();
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("Move_1");
		TSVector2 placeHolderPosition2 = GetPlaceHolderPosition("Move_2");
		TSVector2 placeHolderPosition3 = GetPlaceHolderPosition("Move_3");
		FP fP = Distance(position, placeHolderPosition);
		FP fP2 = Distance(position, placeHolderPosition2);
		FP fP3 = Distance(position, placeHolderPosition3);
		TSVector2 position2;
		if (fP <= fP2 && fP <= fP3)
		{
			position2 = placeHolderPosition;
		}
		else
		{
			position2 = ((fP2 <= fP3) ? placeHolderPosition2 : placeHolderPosition3);
		}
		MoveToPosition(position2, 0, AdventureActor.MovementMode.Run, 5, _stopDisIgnoreRadius: false);
		yield return WaitMoveStatus();
		yield return WaitTime(0.2);
		SetBattleOutDisable();
	}
}
