using System;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Drama.Conversation;

public class CloseUIEvent : BaseEvent
{
	public string uiType;

	public override async UniTask DoEvent(CancellationToken cancellationToken)
	{
		if (!uiType.Equals(UI_TYPE.UI_NONE))
		{
			await Singleton<NewUIManager>.instance.CloseUIAsync((UI_TYPE)Enum.Parse(typeof(UI_TYPE), uiType));
		}
	}
}
