using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class MonoSpecialItemAchieveView : BaseUIView
{
	public BImage image;

	private int m_Param;

	protected override void Init()
	{
		base.Init();
		m_Param = (int)uiViewData;
		Station.LoadItemIcon(RuntimeConfigs.data.itemDatas[m_Param].iconAddress, image);
	}

	protected override void UnInit()
	{
		base.UnInit();
		image.UnLoad();
	}
}
