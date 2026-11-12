using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class SimpleAPI_ChuShi : SkillSimpleBase
{
	protected IEnumerator JumpToPoints(TSVector2 Position)
	{
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.U,
			ComboInputBuffer.ActionKey.U
		};
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.V,
			ComboInputBuffer.ActionKey.V
		};
		FP fP = 15;
		ComboInputBuffer.ActionKey[] keys;
		FP fP2;
		if (Distance(GetPosition(), Position) >= fP)
		{
			keys = array2;
			fP2 = 25.714285714285715;
		}
		else
		{
			keys = array;
			fP2 = 20;
		}
		TSVector2 DashDirection = Position - GetPosition();
		FP DashDistance = Distance(Position, GetPosition());
		FP DashSpeed = DashDistance / (fP2 / 60f);
		BeginAttack(1, keys);
		yield return WaitCustomEvent("Dash");
		BeginDash(1, DashDirection, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0);
		yield return WaitCustomEvent("CloseBlock");
		SetCloseBlockEnable();
		yield return WaitCustomEvent("OpenBlock");
		SetCloseBlockDisable();
		yield return WaitCustomEvent("StopDash");
		StopDash();
	}
}
