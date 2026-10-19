using UnityEngine;

namespace Bamboo.HeartBeat;

public sealed class UpdateTimeDriver : BeatDriver<UpdateTimeDriver>
{
	private void Update()
	{
		int delta = Mathf.RoundToInt(1000f * Time.deltaTime);
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
