using System.Collections.Generic;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class OpenVerticalReadUIAction : ISignalAction
{
	public int titleId;

	public List<VerticalInfo> infos;

	public async UniTask Invoke(INotificationReceiver receiver)
	{
		bool waitOver = false;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_VERTICALREAD, new MonoVerticalReadView.VerticalInfos
		{
			titleId = titleId,
			infos = infos,
			onClose = () =>
			{
				waitOver = true;
			}
		});
		await UniTask.WaitUntil(() => waitOver);
	}
}
