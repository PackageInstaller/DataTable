using ACT.Net;
using Fundamental;
using Pb;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoGMView : BaseUIView
{
	public InputField gmCmd;

	private GmActionProcessReq req = new GmActionProcessReq();

	public void SendGMCmd()
	{
		req.Cmd = gmCmd.text;
		Singleton<NetManager>.instance.Post(req);
	}
}
