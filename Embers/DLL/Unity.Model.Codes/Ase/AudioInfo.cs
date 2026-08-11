using System;

namespace Ase;

public struct AudioInfo
{
	public int id;

	public int eventType;

	public int languageType;

	public string oriPath;

	public string audioPath;

	public static readonly AudioInfo EmptyInfo = new AudioInfo
	{
		id = 0,
		eventType = 0,
		languageType = 0,
		audioPath = string.Empty,
		oriPath = string.Empty
	};

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		AudioInfo audioInfo = (AudioInfo)obj;
		if (id == audioInfo.id && languageType == audioInfo.languageType && audioPath.Equals(audioInfo.audioPath) && oriPath.Equals(audioInfo.oriPath))
		{
			return eventType == audioInfo.eventType;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(id, languageType, audioPath, oriPath, eventType);
	}

	public static bool operator ==(AudioInfo a, AudioInfo b)
	{
		return a.Equals(b);
	}

	public static bool operator !=(AudioInfo a, AudioInfo b)
	{
		return !a.Equals(b);
	}
}
