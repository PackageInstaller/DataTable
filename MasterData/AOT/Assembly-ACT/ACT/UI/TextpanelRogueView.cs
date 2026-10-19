using Bamboo.NumberString;
using Fundamental;
using TMPro;

namespace ACT.UI;

public class TextpanelRogueView : TextPanel
{
	private TextpanelRogueViewData m_data;

	public UIAtlasImage icon;

	public TextMeshProUGUI countText;

	protected override void Init()
	{
		base.Init();
		if (uiViewData != null)
		{
			m_data = uiViewData as TextpanelRogueViewData;
		}
		countText.text = m_data.UsedCount.FastToString();
		Singleton<UIAtlasManager>.instance.LoadItemSprite(GameLoader.meta.itemAtlasNameAssetID, m_data.item.Id, icon);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}
}
