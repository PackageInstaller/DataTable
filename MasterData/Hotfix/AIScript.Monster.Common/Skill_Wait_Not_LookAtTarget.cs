using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Common;

public class Skill_Wait_Not_LookAtTarget : SkillAdvancedBase
{
	protected CoroutineNode _waitCoroutine;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_waitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitCoroutine);
			_waitCoroutine = null;
		}
	}

	public void OnStart()
	{
		_waitCoroutine = _actor.StartLogicCoroutine(JustWait());
	}

	private IEnumerator JustWait()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.1));
		_skill.Clear();
	}
}
