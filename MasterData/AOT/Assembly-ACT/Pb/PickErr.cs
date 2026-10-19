using Google.Protobuf.Reflection;

namespace Pb;

public enum PickErr
{
	[OriginalName("PICK_NO_ERR")]
	PickNoErr,
	[OriginalName("PICK_UNKNOWN_ERR")]
	PickUnknownErr,
	[OriginalName("PICK_BAG_FULL_ERR")]
	PickBagFullErr
}
