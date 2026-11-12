#define LOG_DEBUG
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50051DanZhuTouShou;

public class Skill_GoBack : SkillAdvancedBase
{
	protected readonly bool _playerCenter;

	protected FP _radius = 10;

	protected FP _innerRadius = 8;

	protected FP _angle = 30;

	protected FP _rotation = 180;

	protected FP _maxTime = 4;

	protected bool useLineRotate;

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
