using ACT.UI;

namespace ACT.Event;

public class OnItemMutipleChoose : BaseEventContent
{
	public int itemCount;

	public int ItemTypeCount;

	public ItemUIComponent Choose;

	public override void ReleaseEvt()
	{
		itemCount = 0;
		ItemTypeCount = 0;
		Choose = null;
	}
}
