using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/触发器内部事件/等待时间(s)", 1)]
public class Task_WaitTime : TaskCellBase
{
	public FP _duration;

	private FP _leftTime;

	protected override void OnExecute()
	{
		if (_duration <= 0)
		{
			LogWarning("未配置");
			EndAction();
		}
		else
		{
			_leftTime = _duration + ElapsedTime;
		}
	}

	protected override void LogicUpdate()
	{
		if (_leftTime < ElapsedTime)
		{
			EndAction();
		}
	}
}
