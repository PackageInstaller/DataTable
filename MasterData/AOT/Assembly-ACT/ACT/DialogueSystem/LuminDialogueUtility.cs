using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using ACT.Game;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class LuminDialogueUtility
{
	public static string ProcessPlayerName(string content)
	{
		return content.Replace("<playername/>", Singleton<ConversationManager>.instance.GetRichPlayerName());
	}

	public static string ProcessPurePlayerName(string content)
	{
		return content.Replace("<playername/>", G.detailUserInfo?.Brief?.Nickname);
	}

	public static async UniTask<MonoConversationView> AwaitConversationView(CancellationToken token, object openData = null)
	{
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_CONVERSATION);
		if (firstUIState != UIState.Opened && firstUIState != UIState.Opening)
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CONVERSATION, openData);
		}
		await UniTask.WaitUntil(() =>
		{
			IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION);
			if (baseUIView != null)
			{
				IBaseUIController uIController = baseUIView.UIController;
				if (uIController != null)
				{
					return uIController.State == UIState.Opened;
				}
			}
			return false;
		}, PlayerLoopTiming.Update, token);
		return Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView;
	}

	public static UniTask WaitForSecondsOrForceNext(float seconds, CancellationToken token, Action onForceNext = null)
	{
		if (seconds <= 0f)
		{
			return UniTask.CompletedTask;
		}
		return DelayOrForceNext(TimeSpan.FromSeconds(seconds), token, onForceNext);
	}

	public static UniTask WaitForSecondsOrInput(float seconds, CancellationToken token, Func<bool> onTryNext = null, Action onForceNext = null)
	{
		if (seconds <= 0f)
		{
			return UniTask.CompletedTask;
		}
		return DelayOrInput(TimeSpan.FromSeconds(seconds), token, onTryNext, onForceNext);
	}

	public static async UniTask DelayOrForceNext(TimeSpan delay, CancellationToken token, Action onForceNext = null)
	{
		if (!(delay <= TimeSpan.Zero) && !token.IsCancellationRequested)
		{
			await DelayOrInput(delay, token, null, onForceNext);
		}
	}

	public static async UniTask DelayOrInput(TimeSpan delay, CancellationToken token, Func<bool> onTryNext = null, Action onForceNext = null)
	{
		if (!(delay <= TimeSpan.Zero) && !token.IsCancellationRequested)
		{
			float elapsed = 0f;
			float seconds = (float)delay.TotalSeconds;
			await WaitUntilOrInput(() =>
			{
				elapsed += Time.deltaTime;
				return elapsed >= seconds;
			}, token, onTryNext, onForceNext);
		}
	}

	public static async UniTask WaitUntilOrForceNext(Func<bool> predicate, CancellationToken token, Action onForceNext = null)
	{
		await WaitUntilOrInput(predicate, token, null, onForceNext);
	}

	public static async UniTask WaitUntilOrInput(Func<bool> predicate, CancellationToken token, Func<bool> onTryNext = null, Action onForceNext = null)
	{
		if (predicate())
		{
			return;
		}
		bool forceNext;
		bool tryNext;
		if (Singleton<ConversationManager>.instance?.PlayingDialogue is IAVGDialogue iAVGDialogue)
		{
			forceNext = false;
			tryNext = false;
			using (iAVGDialogue.RegisterInputHandler(new DialogueInputActions(TriggerTryNext, TriggerForceNext)))
			{
				await UniTask.WaitUntil(() => (forceNext | tryNext) || predicate(), PlayerLoopTiming.Update, token).SuppressCancellationThrow();
				return;
			}
		}
		await UniTask.WaitUntil(predicate, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
		void TriggerForceNext()
		{
			if (!forceNext)
			{
				forceNext = true;
				onForceNext?.Invoke();
			}
		}
		bool TriggerTryNext()
		{
			if (onTryNext == null)
			{
				return false;
			}
			if (!onTryNext())
			{
				return false;
			}
			tryNext = true;
			return true;
		}
	}

	public static void SetAVGURPGraphicSettings()
	{
		try
		{
			RenderUtility.SetURPGraphicSettings(isColor: false, isDepth: true, isSkybox: false, isDistortion: false);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	public static void ResetAVGURPGraphicSettings()
	{
		try
		{
			RenderUtility.ResetRenderFeature();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public static async UniTask WhenAllPooled(UniTask task0, UniTask task1)
	{
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		try
		{
			tasks.Add(task0);
			tasks.Add(task1);
			await UniTask.WhenAll(tasks);
		}
		finally
		{
			CollectionPool<List<UniTask>, UniTask>.Release(tasks);
		}
	}

	public static async UniTask WhenAllPooled(UniTask task0, UniTask task1, UniTask task2)
	{
		List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
		try
		{
			tasks.Add(task0);
			tasks.Add(task1);
			tasks.Add(task2);
			await UniTask.WhenAll(tasks);
		}
		finally
		{
			CollectionPool<List<UniTask>, UniTask>.Release(tasks);
		}
	}
}
