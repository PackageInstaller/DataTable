namespace AIScript.Monster.Soldier._31101;

public class Summon_Spawn : SkillAdvancedBase
{
	private const int buffId = 250106301;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_actor.buffComponent?.AddBuff(250106301, _actor);
		OnFinish();
	}
}
