using System.Threading;
using ACT;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;

public class MonoConversationEmojiLayer : MonoBehaviour
{
	public void Play(int emojiId, Transform bindTransform)
	{
		if (emojiId > 0 && !(bindTransform == null) && RuntimeConfigs.data.dialogueEmojiDatas.TryGetValue(emojiId, out var value))
		{
			string assetKey = value.assetKey;
			if (string.IsNullOrEmpty(assetKey))
			{
				Debug.LogWarning($"对话表情 {emojiId} 未配置资源键", this);
			}
			else
			{
				PlayInternal(assetKey, bindTransform, destroyCancellationToken).Forget();
			}
		}
	}

	private async UniTask PlayInternal(string assetKey, Transform bindTransform, CancellationToken token)
	{
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(assetKey, transform, instantiateInWorldSpace: false, (AssetLoadHandle _handle) =>
		{
			_handle.As<GameObject>()?.SetActive(value: false);
		});
		try
		{
			await handle;
			if (!token.IsCancellationRequested)
			{
				MonoConversationEmoji monoConversationEmoji = handle.AsGameObject()?.GetComponent<MonoConversationEmoji>();
				if (monoConversationEmoji == null)
				{
					Debug.LogWarning("对话表情资源缺少 MonoConversationEmoji: " + assetKey, this);
					return;
				}
				monoConversationEmoji.BindTransform(bindTransform);
				monoConversationEmoji.gameObject.SetActive(value: true);
				await monoConversationEmoji.Play(token);
			}
		}
		finally
		{
			if (handle.IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(handle);
			}
		}
	}
}
