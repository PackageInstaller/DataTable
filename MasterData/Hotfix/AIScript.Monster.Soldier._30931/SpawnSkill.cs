namespace AIScript.Monster.Soldier._30931;

public class SpawnSkill : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public new void OnStart()
	{
		ModelNodeShow("ShaJuRen", isShow: false);
		ModelNodeShow("ShaJuRen_trans", isShow: false);
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
