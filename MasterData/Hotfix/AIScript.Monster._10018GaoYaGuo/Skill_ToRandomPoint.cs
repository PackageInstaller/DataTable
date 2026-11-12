#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10018GaoYaGuo;

public class Skill_ToRandomPoint : SkillAdvancedBase
{
	protected readonly bool _playerCenter = true;

	protected FP _radius = 7;

	protected FP _innerRadius = 4;

	protected FP _angle = 150;

	protected FP _rotation = 0;

	protected FP _maxTime = 5;

	protected bool useLineRotate = true;

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
