using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class MessageEndComp : MonoBehaviour
{
	public void Init(long messageId, int sessionId, bool appear)
	{
		if (!appear)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
	}
}
