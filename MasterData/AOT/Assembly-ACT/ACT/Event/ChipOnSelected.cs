using ACT.Game.Data;

namespace ACT.Event;

public class ChipOnSelected : BaseEventContent
{
	public Chip chip;

	public bool isBagSelected;

	public override void ReleaseEvt()
	{
		chip = null;
		isBagSelected = false;
	}
}
