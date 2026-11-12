#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_ToRandomPoint : SkillAdvancedBase
{
	protected readonly bool _playerCenter;

	protected FP _radius = 12;

	protected FP _innerRadius = 10;

	protected FP _angle = 120;

	protected FP _rotation = 180;

	protected FP _maxTime = 13;

	protected readonly bool useLineRotate = true;

	protected Skill_Free _skillF;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		NovaLogger.Debug("Skill_ToRandomPoint OnDisable");
		if (_skillF != null)
		{
			_skillF.clear();
			_skillF = null;
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("Skill_ToRandomPoint OnStart");
		if (_skillF == null)
		{
			_skillF = new Skill_Free();
		}
		_skillF._onStart(_actor, _playerCenter, _radius, _innerRadius, _angle, _rotation, _maxTime, _skill, useLineRotate);
	}
}
