using ACT.Net;

namespace ACT.EventTrack;

public class AttributeChangeEvt : TrackBaseEvt<AttributeChangeEvt>
{
	public PlayerAttribute attributeType;

	public long changeNum;

	public int getReason;
}
