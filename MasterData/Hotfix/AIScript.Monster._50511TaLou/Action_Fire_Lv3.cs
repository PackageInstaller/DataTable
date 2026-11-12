using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Action_Fire_Lv3 : Action
{
	private readonly int _Skill_HitFloor = 5051111;

	private readonly int _Skill_FloatHitFloor = 5051112;

	private readonly int _Skill_GroundFire = 5051113;

	private readonly int _Skill_FireMine = 5051118;

	private readonly int _Skill_FireStorm = 5051120;

	private readonly int _Skill_FloatMove = 5051116;

	protected override void OnActionEnable()
	{
		InitConfig(_Skill_HitFloor, _Skill_FloatHitFloor, _Skill_GroundFire, _Skill_FireMine, _Skill_FireStorm, _Skill_FloatMove);
		SetLogicTagFpValue(_actor, "Difficulty", 3);
		SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint1"), TSVector2.up, 4);
		SummonTeammate(1, GetPlaceHolderPosition("CommonSummonPoint2"), TSVector2.up, 4);
	}

	protected override void SetListenEvents()
	{
	}
}
