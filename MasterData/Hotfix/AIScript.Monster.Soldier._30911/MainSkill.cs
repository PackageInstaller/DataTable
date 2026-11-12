namespace AIScript.Monster.Soldier._30911;

public class MainSkill : SkillAdvancedBase
{
	private int buffId = 250105901;

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
		_actor.buffComponent.AddBuff(buffId, _actor);
		OnFinish();
	}
}
