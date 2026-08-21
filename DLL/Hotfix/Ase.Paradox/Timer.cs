using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("计时器", 0)]
[Category("✫ DragonLost/System")]
public class Timer : ActionTaskBase
{
	[Name("计时器", 0)]
	public BBParameter<float> timer;

	[Name("开始", 0)]
	public BBParameter<bool> startTimer;

	private float _timer;

	protected override void OnExecute()
	{
		base.OnExecute();
		_timer = 0f;
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (!startTimer.value)
		{
			timer.value = _timer - base.ownerSystem.deltaTime;
			EndAction();
		}
		else
		{
			_timer += base.ownerSystem.deltaTime;
		}
	}

	protected override void OnStop()
	{
		base.OnStop();
		timer.value = _timer - base.ownerSystem.deltaTime;
		_timer = 0f;
	}
}
