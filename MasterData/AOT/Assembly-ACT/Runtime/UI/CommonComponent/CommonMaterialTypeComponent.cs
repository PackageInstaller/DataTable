using ACT.Model;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;

namespace Runtime.UI.CommonComponent;

public class CommonMaterialTypeComponent : BaseUIComponent
{
	[SerializeField]
	private BImage m_MatTypeIcon;

	private BloodBottleMaterial m_BloodBottleMaterial;

	public BloodBottleMaterial BloodBottleMaterial
	{
		get
		{
			return m_BloodBottleMaterial;
		}
		set
		{
			m_BloodBottleMaterial = value;
			if (value != null)
			{
				gameObject.SetActive(value: true);
				Station.LoadImage(157, value.type, m_MatTypeIcon);
			}
			else
			{
				gameObject.SetActive(value: false);
			}
		}
	}
}
