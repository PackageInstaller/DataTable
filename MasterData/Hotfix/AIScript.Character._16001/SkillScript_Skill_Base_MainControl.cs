namespace AIScript.Character._16001;

public class SkillScript_Skill_Base_MainControl : SkillAdvancedBase
{
	protected PlayerSkillCd _playerSkillCd;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		DefaultLookAt();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_playerSkillCd = null;
	}
}
