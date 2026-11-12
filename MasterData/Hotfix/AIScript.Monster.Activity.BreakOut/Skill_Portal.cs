using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Trap;

namespace AIScript.Monster.Activity.BreakOut;

public class Skill_Portal : TrapSkillBase
{
	private readonly Dictionary<int, string> TrapID_Prefab_Dictionary = new Dictionary<int, string>
	{
		[50916001] = "Misc/BreakOut/Gear/Gear_Poral_3_1_1",
		[50916014] = "Misc/BreakOut/Gear/Gear_Poral_3_1_2",
		[50916002] = "Misc/BreakOut/Gear/Gear_Poral_3_2_1",
		[50916003] = "Misc/BreakOut/Gear/Gear_Poral_3_2_2",
		[50916004] = "Misc/BreakOut/Gear/Gear_Poral_3_3_1",
		[50916005] = "Misc/BreakOut/Gear/Gear_Poral_3_3_2",
		[50916006] = "Misc/BreakOut/Gear/Gear_Poral_3_4_1",
		[50916007] = "Misc/BreakOut/Gear/Gear_Poral_3_4_2",
		[50916008] = "Misc/BreakOut/Gear/Gear_Poral_3_6_1",
		[50916009] = "Misc/BreakOut/Gear/Gear_Poral_3_6_2",
		[50916010] = "Misc/BreakOut/Gear/Gear_Poral_3_7_1",
		[50916011] = "Misc/BreakOut/Gear/Gear_Poral_3_7_2",
		[50916012] = "Misc/BreakOut/Gear/Gear_Poral_3_8_1",
		[50916013] = "Misc/BreakOut/Gear/Gear_Poral_3_8_2"
	};

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		string fxAlias = TrapID_Prefab_Dictionary.get_Item(_actor.dataID);
		Singleton<BrickBreakerManager>.Instance.GetGearToScence(fxAlias, _actor.tsTransform.Position);
		yield return WaitTime(99999);
	}
}
