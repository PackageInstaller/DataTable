using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_VineWall : SkillSimpleBase
{
	private static readonly int BornIndex = 1;

	private static readonly string BornAction = "Born";

	private static readonly string Dormancy = "fx_debuff_loop_Dormancy";

	private static readonly string WallDamage = "WallDamage";

	private static readonly TSVector2 WallPOS = new TSVector2(0, 10.5);

	private const int stateID01 = 105010000;

	private const int stateID02 = 105010001;

	private const int stateID03 = 105010002;

	private static TSVector2 SelfPOS;

	private static TSVector2 TargetPOS;

	private static long Fx01;

	private static long FxWallDamage;

	private int stateID;

	protected override IEnumerator DoMainLogic()
	{
		ShowBlood(isShow: true);
		FxWallDamage = PlayAreaEffect(WallDamage, GetPosition());
		yield break;
	}
}
