using ACT.Core;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class DialogueSFXSignal : ISignalAction
{
	public int dialogueSfxId;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		if (dialogueSfxId <= 0 || RuntimeConfigs.data == null || !RuntimeConfigs.data.dialogueSFXDatas.TryGetValue(dialogueSfxId, out var value) || string.IsNullOrEmpty(value.key))
		{
			return UniTask.CompletedTask;
		}
		Singleton<GameManager>.instance.audioManager?.PlaySound(value.key);
		return UniTask.CompletedTask;
	}
}
