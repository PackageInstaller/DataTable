using System;
using System.Text.RegularExpressions;
using UnityEngine;

namespace ACT.Sound;

[Serializable]
public struct AudioEventReference : IAudioEventReference
{
	[SerializeField]
	private string _eventPath;

	[SerializeField]
	[HideInInspector]
	private bool _isVoice;

	private static readonly Regex VoiceEventRegex = new Regex("^event:/Vo/(CN|EN|JP)/(.+)$", RegexOptions.Compiled);

	public const string NullEvent = "Null";

	public bool IsVoice => _isVoice;

	public AudioEventReference(string eventPath)
	{
		_eventPath = eventPath;
		_isVoice = false;
		if (!string.IsNullOrEmpty(eventPath))
		{
			Match match = VoiceEventRegex.Match(eventPath);
			if (match.Success)
			{
				_eventPath = "event:/Vo/" + match.Groups[2].Value;
				_isVoice = true;
			}
			else if (eventPath.StartsWith("event:/Vo/"))
			{
				_isVoice = true;
			}
		}
	}

	public static AudioEventReference CreateVoiceEvent(string voicePath)
	{
		return new AudioEventReference(voicePath);
	}

	public string GetEventPath()
	{
		return _eventPath;
	}

	public bool IsMultilingualEvent()
	{
		if (!string.IsNullOrEmpty(_eventPath))
		{
			return _isVoice;
		}
		return false;
	}

	public bool IsNull()
	{
		return string.IsNullOrEmpty(_eventPath);
	}

	public override string ToString()
	{
		if (IsNull())
		{
			return "Null";
		}
		if (!IsMultilingualEvent())
		{
			return _eventPath;
		}
		return _eventPath + " [Voice]";
	}

	public static implicit operator string(AudioEventReference reference)
	{
		return reference._eventPath;
	}

	public static bool operator ==(AudioEventReference a, AudioEventReference b)
	{
		return a._eventPath == b._eventPath;
	}

	public static bool operator !=(AudioEventReference a, AudioEventReference b)
	{
		return !(a == b);
	}

	public override bool Equals(object obj)
	{
		if (obj is AudioEventReference audioEventReference)
		{
			return this == audioEventReference;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _eventPath?.GetHashCode() ?? 0;
	}
}
