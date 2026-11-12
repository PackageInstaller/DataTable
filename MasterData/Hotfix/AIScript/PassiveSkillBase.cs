namespace AIScript;

public class PassiveSkillBase : AIBase
{
	public void OnEnable()
	{
		_actor = _skill.actor;
		OnSkillEnable();
	}

	public void OnDisable()
	{
		OnSkillDisable();
	}

	protected virtual void OnSkillEnable()
	{
	}

	protected virtual void OnSkillDisable()
	{
	}
}
