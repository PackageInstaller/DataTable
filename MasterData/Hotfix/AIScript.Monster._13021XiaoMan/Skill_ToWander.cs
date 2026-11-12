#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13021XiaoMan;

public class Skill_ToWander : SkillAdvancedBase
{
	protected FP _skillDuration = 1.5;

	protected FP _moveTime = 1.5;

	protected FP _moveCd = 0.5;

	protected FP _nearDistance = 4;

	protected FP _farDistance = 8;

	protected FP _angle = 40;

	protected FP _rotation = 0;

	protected readonly FP _aimSpeed = 30;

	protected readonly FP _changeAngle = 60;

	protected readonly FP _newAimSpeed = 180;

	protected Skill_Wander _skillW;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		NovaLogger.Debug("Skill_ToWander OnDisable");
		if (_skillW != null)
		{
			_skillW.clear();
			_skillW = null;
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("Skill_ToWander OnStart");
		if (_skillW == null)
		{
			_skillW = new Skill_Wander();
		}
		_skillW._onStart(_actor, _skillDuration, _moveTime, _moveCd, _nearDistance, _farDistance, _angle, _rotation, _aimSpeed, _changeAngle, _newAimSpeed, _skill);
	}

	public void OnUpdate()
	{
		_skillW?.OnUpdate();
	}
}
