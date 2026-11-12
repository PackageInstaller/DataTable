using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50041XiaoFa;

public class Skill_Attack_LookAt_Two : SkillAdvancedBase
{
	private const string _customEventName_start_lookAt = "A";

	private const string _customEventName_end_lookAt = "B";

	private readonly FP _rotateSpeed = 120;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private AIScript.Utils.Skill_Attack_LookAt _attackAndLookAt;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_attackAndLookAt == null)
		{
			_attackAndLookAt = new AIScript.Utils.Skill_Attack_LookAt();
		}
		_attackAndLookAt.OnEnable(_actor, _skill, _actionKeys, _rotateSpeed, "A", "B");
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_attackAndLookAt?.OnDisable();
	}
}
