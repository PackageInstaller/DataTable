using UnityEngine;

namespace Bamboo.HeartBeat;

public sealed class FixedUpdateTimeDriver : BeatDriver<FixedUpdateTimeDriver>
{
	private void FixedUpdate()
	{
		int delta = Mathf.RoundToInt(1000f * Time.fixedDeltaTime);
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
				executeBeat.Update(delta);
			}
			catch (ActionException exception)
			{
				Debug.LogException(exception);
			}
		}
		_executeBeats.Clear();
	}
}
