using ACT.Drama;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

[SignalActionName("设置KeyPoint")]
public class SetKeyPointSignalAction : SignalAction
{
	public int keyPoint;

	[Header("立即发送信号，默认为立即发送，不知道怎么用就开着")]
	public bool sendImmediately = true;

	public override bool CanSkip => false;

	public override void Invoke(ISignalEmitter emitter)
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(keyPoint);
		if (sendImmediately)
		{
			Singleton<ConversationManager>.instance.SendKeyPoints();
		}
	}
}
