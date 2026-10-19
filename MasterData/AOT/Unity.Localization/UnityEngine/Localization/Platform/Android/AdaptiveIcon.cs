using System;

namespace UnityEngine.Localization.Platform.Android;

[Serializable]
public class AdaptiveIcon
{
	[SerializeField]
	private LocalizedTexture m_Background;

	[SerializeField]
	private LocalizedTexture m_Foreground;

	public LocalizedTexture Background
	{
		get
		{
			return m_Background;
		}
		set
		{
			m_Background = value;
		}
	}

	public LocalizedTexture Foreground
	{
		get
		{
			return m_Foreground;
		}
		set
		{
			m_Foreground = value;
		}
	}
}
