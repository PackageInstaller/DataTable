using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Monster.Template.Skill;

public class Skill_Die_Summon : SkillAdvancedBase
{
	private readonly string _customEventName = "Born";

	private readonly int _search_inner_radius = 3;

	private readonly int _search_outer_radius = 5;

	private readonly int _summon_count = 3;

	private readonly string _bullet_alias = "Slime_L_Born";

	private readonly string _bullet_tag = "Slime_L_Born";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private ComboAttack _comboAttack;

	private Skill_Bullet_Summon _skillSummon;

	protected override void OnSkillEnable()
	{
		_actor = _skill.actor;
	}

	protected override void OnSkillDisable()
	{
		_comboAttack?.Clear();
		_skillSummon?.OnClear();
		_skillSummon = null;
	}

	public void OnStart()
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		_skillSummon = new Skill_Bullet_Summon();
		_skillSummon.OnStart(_actor, _comboAttack, _actionKeys, _skill, _customEventName, _summon_count, _bullet_alias, _bullet_tag, _search_inner_radius, _search_outer_radius);
	}
}
