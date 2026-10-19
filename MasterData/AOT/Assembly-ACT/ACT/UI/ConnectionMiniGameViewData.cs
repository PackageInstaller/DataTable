using System;
using ACT.Config;

namespace ACT.UI;

public class ConnectionMiniGameViewData : UIViewData
{
	public Action<bool> callback;

	public SeparateSegmentConfig separateSegmentConfig;

	public int swid;
}
