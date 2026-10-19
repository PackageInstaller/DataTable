using ACT.Model;
using Runtime.Model.PowerModel;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class TextPanelWithPower : TextPanel
{
	public Color powerNormalColor;

	public Color powerLessColor;

	public TextMeshProUGUI powerCount;

	private new Param m_Param;

	protected override void Init()
	{
		SetUI();
		base.Init();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public void SetUI()
	{
		if (uiViewData != null)
		{
			m_Param = (Param)uiViewData;
		}
		int num = int.Parse(m_Param.texts[0]);
		if (Model<PowerModel>.Interface.PowerCount < num)
		{
			powerCount.color = powerLessColor;
		}
		else
		{
			if (m_Param.btnInfos != null)
			{
				m_Param.btnInfos = null;
			}
			powerCount.color = powerNormalColor;
		}
		uiViewData = m_Param;
	}
}
