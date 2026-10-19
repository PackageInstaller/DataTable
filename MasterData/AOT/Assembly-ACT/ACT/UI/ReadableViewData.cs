using System;

namespace ACT.UI;

public class ReadableViewData : UIViewData
{
	public int id;

	public Action onClose;

	public int previewType = -1;
}
