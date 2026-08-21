using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class StoryDialogue : ViewModelBase
{
	private string speakerName;

	private string content;

	private string headIconUrl;

	private Func<string, Sprite> headIcon;

	private bool isBranchOption;

	private bool saidByPlayer;

	private bool isAsides;

	private int audioId;

	private bool audioPlaying;

	public bool AudioPlaying
	{
		get
		{
			return audioPlaying;
		}
		set
		{
			Set(ref audioPlaying, value, "AudioPlaying");
		}
	}

	public string SpeakerName
	{
		get
		{
			return speakerName;
		}
		set
		{
			Set(ref speakerName, value, "SpeakerName");
		}
	}

	public string Content
	{
		get
		{
			return content;
		}
		set
		{
			Set(ref content, value, "Content");
		}
	}

	public string HeadIconUrl
	{
		get
		{
			return headIconUrl;
		}
		set
		{
			Set(ref headIconUrl, value, "HeadIconUrl");
		}
	}

	public Func<string, Sprite> HeadIcon
	{
		get
		{
			return headIcon;
		}
		set
		{
			Set(ref headIcon, value, "HeadIcon");
		}
	}

	public bool IsBranchOption
	{
		get
		{
			return isBranchOption;
		}
		set
		{
			Set(ref isBranchOption, value, "IsBranchOption");
		}
	}

	public bool SaidByPlayer
	{
		get
		{
			return saidByPlayer;
		}
		set
		{
			Set(ref saidByPlayer, value, "SaidByPlayer");
		}
	}

	public bool IsAsides
	{
		get
		{
			return isAsides;
		}
		set
		{
			Set(ref isAsides, value, "IsAsides");
		}
	}

	public int AudioId
	{
		get
		{
			return audioId;
		}
		set
		{
			Set(ref audioId, value, "AudioId");
		}
	}
}
