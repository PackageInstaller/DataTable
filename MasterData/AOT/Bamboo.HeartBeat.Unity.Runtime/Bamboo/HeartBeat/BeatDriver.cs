using System.Collections.Generic;

namespace Bamboo.HeartBeat;

public abstract class BeatDriver<T> : BaseDriver<T> where T : BeatDriver<T>
{
	private Beat _common;

	protected readonly List<Beat> _beats = new List<Beat>();

	protected readonly List<Beat> _executeBeats = new List<Beat>();

	public Beat Common
	{
		get
		{
			if (_common == null)
			{
				_common = new Beat();
				_beats.Add(_common);
			}
			return _common;
		}
	}

	public Beat NewBeat()
	{
		Beat beat = new Beat();
		_beats.Add(beat);
		return beat;
	}

	public void RemoveBeat(Beat beat)
	{
		_beats.Remove(beat);
	}
}
