using System;
using ACT.UI;

namespace ACT.NPC.Actions;

[Serializable]
public struct ActionOpenUIReadableViewData
{
	public int textLibraryContentId;

	public ReadableViewData ToUIViewData()
	{
		return new ReadableViewData
		{
			id = textLibraryContentId
		};
	}
}
