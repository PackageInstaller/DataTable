using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_TravelAround_1 : SkillScript_SkillBase
{
	protected TSVector2 movePoint = new TSVector2(-7, 10);

	protected TSVector2 LookAtJumpTarget = new TSVector2(-11, 14);

	private readonly string bulletPath2 = "Weapon_50501ShaSha_Dark_Bullet";

	public override void OnStart()
	{
	}

	protected override void BeginSkill()
	{
	}
}
