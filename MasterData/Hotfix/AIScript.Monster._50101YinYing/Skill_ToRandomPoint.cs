#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50101YinYing;

public class Skill_ToRandomPoint : SkillAdvancedBase
{
	protected readonly bool _playerCenter;

	protected FP _radius = 5;

	protected FP _innerRadius = 4;

	protected FP _angle = 240;

	protected FP _rotation = 180;

	protected FP _maxTime = 4;

	protected readonly bool useLineRotate = true;

	protected Skill_Free _skillF;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
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
