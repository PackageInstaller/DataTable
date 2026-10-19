using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class OpenReadableViewAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		OpenReadableViewConditionParam openReadableViewConditionParam = Param as OpenReadableViewConditionParam;
		ReadableViewData uiData = new ReadableViewData
		{
			id = openReadableViewConditionParam.textLibraryContentId
		};
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_READABLE, uiData).Forget();
		return UniTask.CompletedTask;
	}
}
