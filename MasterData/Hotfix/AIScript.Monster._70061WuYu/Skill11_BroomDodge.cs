using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill11_BroomDodge : SkillSimpleBase
{
	public const string ComboKey = "Dodge";

	private static readonly FP TeleportDistance = 10;

	private static readonly FP RotateAngle = 90;

	private const string DecoyBornFxAlias = "fx_70061WuYu_SaoZhou_base_dodge_born";

	public const string AppearFxAlias = "fx_70061WuYu_base_dodge_born";

	public static readonly FP Delay = 0.5;

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("CenterPoint");
		TSVector2 tSVector = position - placeHolderPosition;
		TSVector2 tSVector2 = ((tSVector.magnitude > FP.Zero) ? tSVector.normalized : forward);
		TSVector2 tSVector3 = RotateTo(tSVector2, RotateAngle);
		TSVector2 result = placeHolderPosition + tSVector3 * TeleportDistance;
		SetHideModelEnable();
		Skill11_BroomDodge skill11_BroomDodge = this;
		TSVector2 position2 = position;
		skill11_BroomDodge.PlayEffect("fx_70061WuYu_SaoZhou_base_dodge_born", 1f, default, position2);
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		Teleport(result);
		Skill11_BroomDodge skill11_BroomDodge2 = this;
		position2 = result;
		skill11_BroomDodge2.PlayEffect("fx_70061WuYu_base_dodge_born", 1f, default, position2);
		yield return WaitTime(Delay);
		SetHideModelDisable();
		BeginAttack(0, "Dodge", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
