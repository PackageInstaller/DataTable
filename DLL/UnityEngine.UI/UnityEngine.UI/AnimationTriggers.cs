using System;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[Serializable]
public class AnimationTriggers
{
	private const string kDefaultNormalAnimName = "Normal";

	private const string kDefaultHighlightedAnimName = "Highlighted";

	private const string kDefaultPressedAnimName = "Pressed";

	private const string kDefaultSelectedAnimName = "Selected";

	private const string kDefaultDisabledAnimName = "Disabled";

	[FormerlySerializedAs("normalTrigger")]
	[SerializeField]
	private string m_NormalTrigger = "Normal";

	[FormerlySerializedAs("highlightedTrigger")]
	[SerializeField]
	private string m_HighlightedTrigger = "Highlighted";

	[FormerlySerializedAs("pressedTrigger")]
	[SerializeField]
	private string m_PressedTrigger = "Pressed";

	[FormerlySerializedAs("m_HighlightedTrigger")]
	[SerializeField]
	private string m_SelectedTrigger = "Selected";

	[SerializeField]
	[FormerlySerializedAs("disabledTrigger")]
	private string m_DisabledTrigger = "Disabled";

	public string normalTrigger
	{
		get
		{
			return m_NormalTrigger;
		}
		set
		{
			m_NormalTrigger = value;
		}
	}

	public string highlightedTrigger
	{
		get
		{
			return m_HighlightedTrigger;
		}
		set
		{
			m_HighlightedTrigger = value;
		}
	}

	public string pressedTrigger
	{
		get
		{
			return m_PressedTrigger;
		}
		set
		{
			m_PressedTrigger = value;
		}
	}

	public string selectedTrigger
	{
		get
		{
			return m_SelectedTrigger;
		}
		set
		{
			m_SelectedTrigger = value;
		}
	}

	public string disabledTrigger
	{
		get
		{
			return m_DisabledTrigger;
		}
		set
		{
			m_DisabledTrigger = value;
		}
	}
}
