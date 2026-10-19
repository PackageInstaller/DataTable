using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class OpenUIViewAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		OpenUIViewActionParam openUIViewActionParam = Param as OpenUIViewActionParam;
		await Singleton<NewUIManager>.instance.OpenUIAsync(openUIViewActionParam.uiType);
	}
}
