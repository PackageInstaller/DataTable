using AIScript.Utils;
using TrueSync;

namespace AIScript.Character.Common;

public class SkillScript_TransitionRush : SkillAdvancedBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_TransitionRush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.L };

	private static readonly FP duration = 0.1;

	private Skill_TransitionRush _skillTransitionRush;

	protected override void OnSkillEnable()
	{
		if (_skillTransitionRush == null)
		{
			_skillTransitionRush = new Skill_TransitionRush();
		}
		_skillTransitionRush.OnEnable(_actor, _skill, actionKeys_TransitionRush, duration);
	}

	protected override void OnSkillDisable()
	{
		_skillTransitionRush?.OnDisable();
	}

	public void OnUpdate()
	{
		_skillTransitionRush?.OnUpdate();
	}
}
