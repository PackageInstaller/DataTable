using Google.Protobuf.Reflection;

namespace Pb;

public enum ContactGMMode
{
	[OriginalName("CONTACT_GM_MODE_NONE")]
	None,
	[OriginalName("CONTACT_GM_MODE_NORMAL")]
	Normal,
	[OriginalName("CONTACT_GM_MODE_OPEN_UI")]
	OpenUi
}
