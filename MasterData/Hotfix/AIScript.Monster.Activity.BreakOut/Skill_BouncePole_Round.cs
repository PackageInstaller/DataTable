using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Trap;

namespace AIScript.Monster.Activity.BreakOut;

public class Skill_BouncePole_Round : TrapSkillBase
{
	private readonly Dictionary<int, string> TrapID_Prefab_Dictionary = new Dictionary<int, string>
	{
		[50912002] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_5",
		[50912003] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_6_1",
		[50912004] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_7_1",
		[50912005] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_8_1",
		[50912006] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_6_2",
		[50912007] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_7_2",
		[50912008] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_8_2",
		[50912009] = "Misc/BreakOut/Gear/Gear_BouncePole_Round_3_8_3"
	};

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		string fxAlias = TrapID_Prefab_Dictionary.get_Item(_actor.dataID);
		Singleton<BrickBreakerManager>.Instance.GetGearToScence(fxAlias, _actor.tsTransform.Position);
		yield return WaitTime(99999);
	}
}
