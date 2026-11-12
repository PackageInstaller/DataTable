using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50071ZhongShiLaiMu;

public class Skill_MoveToPoint : SkillAdvancedBase
{
	private readonly TSVector2 targetPoint = TSVector2.zero;

	private NavigationMove _navigationMove;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		_navigationMove?.Clear();
	}

	public void OnStart()
	{
		if (_navigationMove == null)
		{
			_navigationMove = new NavigationMove();
		}
		_navigationMove.MoveTo(_actor, targetPoint, 1, () =>
		{
			_skill.Clear();
		});
	}
}
