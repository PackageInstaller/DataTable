using TrueSync;

namespace AIScript.Monster.Activity.Activity_18;

public class Action : MonsterActionBase
{
	private static readonly int skillId_DcValue = 0;

	private static readonly FP triggerDistance = 10;

	private bool _dcValueTriggered;

	public new void OnStart()
	{
	}

	protected override void OnActionEnable()
	{
		_dcValueTriggered = false;
	}

	public void OnUpdate()
	{
		if (!_dcValueTriggered)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			if (!(currentPlayer == null) && !(Distance(GetPosition(), GetEntityPosition(currentPlayer)) > triggerDistance))
			{
				_dcValueTriggered = true;
				CastSkill(skillId_DcValue);
			}
		}
	}
}
