using ACT.Config;
using ACT.Core;
using ACT.UI;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace Runtime.UI.CommonComponent;

public class AttributeIntroCell : BaseUIComponent
{
	[SerializeField]
	private BImage m_AttributeIcon;

	[SerializeField]
	private LocalizeStringEvent m_AttributeName;

	private ImageAssetStation m_Station;

	public void Init(int attributeId, ImageAssetStation station)
	{
		m_Station = station;
		PropertyData data = CoreUtils.GetData(attributeId, RuntimeConfigs.data.propertyDatas);
		if (data != null)
		{
			m_Station.LoadImageAsync(146, data.icon, m_AttributeIcon).Forget();
			m_AttributeName.SetTable("shortcommon");
			m_AttributeName.StringReference.TableEntryReference = data.descLocal;
		}
	}
}
