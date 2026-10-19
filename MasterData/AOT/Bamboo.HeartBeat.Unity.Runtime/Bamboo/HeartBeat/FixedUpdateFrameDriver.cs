using UnityEngine;

namespace Bamboo.HeartBeat;

public sealed class FixedUpdateFrameDriver : BeatDriver<FixedUpdateFrameDriver>
{
	private const int DELTA_FRAME = 1;

	private void FixedUpdate()
	{
		_executeBeats.Clear();
		foreach (Beat beat in _beats)
		{
			if (beat != null)
			{
				_executeBeats.Add(beat);
			}
		}
		foreach (Beat executeBeat in _executeBeats)
		{
			try
			{
				executeBeat.Update(1);
			}
			catch (ActionException exception)
			{
				Debug.LogException(exception);
			}
		}
		_executeBeats.Clear();
	}
}
