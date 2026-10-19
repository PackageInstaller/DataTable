using UnityEngine;

namespace ACT;

public class LoadInstructionWithTime : LoadInstruction
{
	private float _currentTime;

	private float _waitTime;

	public bool CountIsComplete => Current == Total;

	public bool IsComplete => _currentTime >= _waitTime;

	public override float percent
	{
		get
		{
			if (Total == 0L)
			{
				return 0f;
			}
			return _currentTime / _waitTime;
		}
	}

	public LoadInstructionWithTime(float time, string name = "")
		: base(name)
	{
		_waitTime = time;
	}

	public LoadInstructionWithTime()
	{
		_waitTime = 1f;
	}

	public void AddTime(float time)
	{
		if (Total != 0L)
		{
			float num = Mathf.Min((float)Current / (float)Total * _waitTime, _waitTime);
			_currentTime += time;
			if (_currentTime >= num)
			{
				_currentTime = num;
			}
			OnUpdate();
		}
	}

	public void SetCurStateComplete()
	{
		if (Total != 0L)
		{
			float num = (float)Current / (float)Total;
			_currentTime = num * _waitTime;
			OnUpdate();
		}
	}

	public override void Reset()
	{
		_currentTime = 0f;
		m_Current = 0L;
	}
}
