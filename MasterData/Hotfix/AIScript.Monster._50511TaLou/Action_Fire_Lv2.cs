namespace AIScript.Monster._50511TaLou;

public class Action_Fire_Lv2 : Action
{
	private readonly int _Skill_HitFloor = 5051111;

	private readonly int _Skill_FloatHitFloor = 5051112;

	private readonly int _Skill_GroundFire = 5051113;

	private readonly int _Skill_FireMine = 5051117;

	private readonly int _Skill_FireStorm = 5051119;

	private readonly int _Skill_FloatMove = 5051116;

	protected override void OnActionEnable()
	{
		InitConfig(_Skill_HitFloor, _Skill_FloatHitFloor, _Skill_GroundFire, _Skill_FireMine, _Skill_FireStorm, _Skill_FloatMove);
		SetLogicTagFpValue(_actor, "Difficulty", 2);
	}

	protected override void SetListenEvents()
	{
	}
}
