using ACT.UI;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace Runtime.UI.CommonComponent;

public class CommonTeamIndexComponent : BaseUIComponent
{
	[SerializeField]
	private GameObject m_Root;

	[SerializeField]
	private TMP_Text m_Number;

	[SerializeField]
	private GameObject m_TeamIcon;

	private int m_Index;

	public int Index
	{
		get
		{
			return m_Index;
		}
		set
		{
			if (m_Index != value)
			{
				m_Index = value;
				UpdateTeamIcon();
			}
		}
	}

	private void UpdateTeamIcon()
	{
		int index = Index;
		if (index <= 0)
		{
			switch (index)
			{
			case -1:
				m_Root.SetActive(value: false);
				break;
			case 0:
				m_Root.SetActive(value: true);
				m_Number.gameObject.SetActive(value: false);
				m_TeamIcon.SetActive(value: true);
				break;
			}
		}
		else
		{
			m_Root.SetActive(value: true);
			m_Number.gameObject.SetActive(value: true);
			m_Number.SetText(Index.FastToString());
			m_TeamIcon.SetActive(value: false);
		}
	}
}
