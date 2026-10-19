using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.CommonComponent;

public class CommonHelpButton : ActToggle
{
	[SerializeField]
	private GameObject m_ContentRoot;

	[SerializeField]
	private LocalizeStringEvent m_HelpContentLocalizeString;

	protected override void Start()
	{
		base.Start();
		m_ContentRoot.SetActive(IsOn);
		onValueChanged.AddListener(OnValueChanged);
		onToggleClick.AddListener(OnToggleClick);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		onValueChanged.RemoveListener(OnValueChanged);
		onToggleClick.RemoveListener(OnToggleClick);
	}

	public void SetContent(int localizeID, string tableName = "shortcommon")
	{
		m_HelpContentLocalizeString.SetTable(tableName);
		m_HelpContentLocalizeString.StringReference.TableEntryReference = localizeID;
	}

	private void OnValueChanged(bool isOn)
	{
		m_ContentRoot.SetActive(isOn);
	}

	private void OnToggleClick()
	{
		if (IsOn && (bool)Group)
		{
			Group.SetAllToggleOff();
		}
	}
}
