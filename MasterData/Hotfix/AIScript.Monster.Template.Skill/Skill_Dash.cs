using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Template.Skill;

public class Skill_Dash : SkillAdvancedBase
{
	private const string _customEventName_start_lookAt = "A";

	private const string _customEventName_end_lookAt = "B";

	private readonly FP _rotateSpeed = 0;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly FP _dashDistance = 8;

	private readonly bool _absDashSpeed = true;

	private readonly FP _dashSpeedOrMultiple = 12;

	private readonly bool _stopWhenContactActor = true;

	private AIScript.Utils.Skill_Dash _dash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_dash == null)
		{
			_dash = new AIScript.Utils.Skill_Dash();
		}
		_dash.OnEnable(_actor, _skill, _actionKeys, _rotateSpeed, "A", "B", _dashDistance, _absDashSpeed, _dashSpeedOrMultiple, _stopWhenContactActor);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dash?.OnDisable();
	}
}
