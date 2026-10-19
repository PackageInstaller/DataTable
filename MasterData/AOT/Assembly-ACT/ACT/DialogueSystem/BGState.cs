using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.DialogueSystem;

public class BGState : DialogueState
{
	public struct Bg
	{
		public int BgId;

		public float Scale;

		public Vector2 Offset;
	}

	public Queue<Bg> bgs = new Queue<Bg>();

	public float scale;

	protected override async UniTask ApplyImmediate(DialogueContext context, CancellationToken token)
	{
		UIConversationScene conversationScene = UIConversationScene.Instance;
		if (!conversationScene)
		{
			return;
		}
		conversationScene.HideAllBg();
		foreach (Bg bg in bgs)
		{
			await conversationScene.AddBg(bg.BgId, bg.Scale, bg.Offset);
		}
	}

	public async UniTask ChangeBg(int bgId, float initScale, Vector2 initOffset, bool skipping)
	{
		if (bgId == 0 || ((bgs.Count > 0) ? bgs.Peek() : default(Bg)).BgId == bgId)
		{
			return;
		}
		bgs.Clear();
		if (bgId > 0)
		{
			bgs.Enqueue(new Bg
			{
				BgId = bgId,
				Scale = initScale,
				Offset = initOffset
			});
			if (!skipping)
			{
				UIConversationScene instance = UIConversationScene.Instance;
				if ((bool)instance)
				{
					await instance.ChangeBg(bgId);
				}
			}
		}
		else if (bgId < 0 && !skipping)
		{
			UIConversationScene instance2 = UIConversationScene.Instance;
			if ((bool)instance2)
			{
				instance2.HideAllBg();
			}
		}
	}

	public UniTask AddBg(int bgId, float initScale, Vector2 initOffset, bool skipping)
	{
		bgs.Enqueue(new Bg
		{
			BgId = bgId,
			Scale = initScale,
			Offset = initOffset
		});
		if (!skipping)
		{
			UIConversationScene instance = UIConversationScene.Instance;
			if ((bool)instance)
			{
				return instance.AddBg(bgId, initScale, initOffset);
			}
		}
		return UniTask.CompletedTask;
	}

	public async UniTask HideCurrentBg(float duration = 0f, bool skipping = false, CancellationToken token = default(CancellationToken))
	{
		if (bgs.Count == 0)
		{
			return;
		}
		bgs.Dequeue();
		if (!skipping)
		{
			UIConversationScene instance = UIConversationScene.Instance;
			if ((bool)instance)
			{
				await instance.HideCurrentBg(duration, token);
			}
		}
	}

	public int GetCurrentBgId()
	{
		if (bgs.Count <= 0)
		{
			return 0;
		}
		return bgs.Peek().BgId;
	}
}
