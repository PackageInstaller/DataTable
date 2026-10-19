using System;
using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.DialogueSystem;

public class PostProcessPrefabStepEventNodeProcessor : ChatStepEventNodeProcessor<PostProcessPrefabStepEventNode>
{
	private bool m_ReleasedOnExit;

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminContext = context as LuminDialogueContext;
		if (luminContext == null || string.IsNullOrEmpty(TData.effectKey))
		{
			return DialogueNodeResult.Continue;
		}
		m_ReleasedOnExit = false;
		if (luminContext.Skipping)
		{
			if (TData.operation == PostProcessPrefabOperation.Release || TData.operation == PostProcessPrefabOperation.PlayAndRelease || (TData.operation == PostProcessPrefabOperation.LoadAndPlay && TData.releaseOnExit))
			{
				luminContext.ReleasePostProcessEffect(TData.effectKey);
			}
			return DialogueNodeResult.Continue;
		}
		if (TData.waitEnd)
		{
			await ExecuteInternal(luminContext, token);
		}
		else
		{
			CancellationTokenSource childCts = CancellationTokenSource.CreateLinkedTokenSource(token);
			luminContext.SubTasks.Run(new DialogueSubTask(RunSubTask(luminContext, childCts), () =>
			{
				SkipToEnd(luminContext, childCts);
			}));
		}
		return DialogueNodeResult.Continue;
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		bool flag = chatStep == ChatStep.OnExit && TData.releaseOnExit && (TData.step & ChatStep.OnExit) == 0;
		if (!flag && (chatStep & TData.step) == 0)
		{
			return UniTask.CompletedTask;
		}
		if (!(context is LuminDialogueContext luminDialogueContext) || string.IsNullOrEmpty(TData.effectKey))
		{
			return UniTask.CompletedTask;
		}
		if (flag)
		{
			m_ReleasedOnExit = true;
			luminDialogueContext.ReleasePostProcessEffect(TData.effectKey);
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
	}

	private async UniTask RunSubTask(LuminDialogueContext context, CancellationTokenSource cts)
	{
		try
		{
			await ExecuteInternal(context, cts.Token);
		}
		finally
		{
			cts.Dispose();
		}
	}

	private void SkipToEnd(LuminDialogueContext context, CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch (ObjectDisposedException)
		{
		}
		AVGPostProcessRuntimeEffect effect;
		if (ShouldReleaseOnSkip())
		{
			context.ReleasePostProcessEffect(TData.effectKey);
		}
		else if ((TData.operation == PostProcessPrefabOperation.SetWeight || TData.tweenWeight) && context.TryGetPostProcessEffect(TData.effectKey, out effect))
		{
			effect.SetWeight(TData.targetWeight);
		}
	}

	private bool ShouldReleaseOnSkip()
	{
		if (TData.operation != PostProcessPrefabOperation.Release && TData.operation != PostProcessPrefabOperation.PlayAndRelease && !TData.releaseAfterAnimation)
		{
			if (TData.operation == PostProcessPrefabOperation.LoadAndPlay)
			{
				return TData.releaseOnExit;
			}
			return false;
		}
		return true;
	}

	private async UniTask ExecuteInternal(LuminDialogueContext context, CancellationToken token)
	{
		_ = 5;
		try
		{
			if (TData.delay > 0f)
			{
				await LuminDialogueUtility.WaitForSecondsOrForceNext(TData.delay, token);
			}
			if (token.IsCancellationRequested || m_ReleasedOnExit)
			{
				return;
			}
			switch (TData.operation)
			{
			case PostProcessPrefabOperation.LoadAndPlay:
			{
				AVGPostProcessRuntimeEffect aVGPostProcessRuntimeEffect = await LoadEffect(context, token);
				if (aVGPostProcessRuntimeEffect != null)
				{
					await PlayEffect(context, aVGPostProcessRuntimeEffect, releaseAfterPlay: false, token);
				}
				break;
			}
			case PostProcessPrefabOperation.Play:
			{
				if (TryGetEffect(context, out var effect2))
				{
					await PlayEffect(context, effect2, releaseAfterPlay: false, token);
				}
				break;
			}
			case PostProcessPrefabOperation.SetWeight:
			{
				if (TryGetEffect(context, out var effect3))
				{
					await TweenWeight(effect3, token);
				}
				break;
			}
			case PostProcessPrefabOperation.PlayAndRelease:
			{
				if (TryGetEffect(context, out var effect))
				{
					await PlayEffect(context, effect, releaseAfterPlay: true, token);
				}
				break;
			}
			case PostProcessPrefabOperation.Release:
				context.ReleasePostProcessEffect(TData.effectKey);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private async UniTask<AVGPostProcessRuntimeEffect> LoadEffect(LuminDialogueContext context, CancellationToken token)
	{
		if (TData.postProcessPrefab == null || string.IsNullOrEmpty(TData.postProcessPrefab.GUID))
		{
			Debug.LogError("PostProcessPrefabStepEventNode LoadAndPlay requires postProcessPrefab.");
			return null;
		}
		UIConversationScene instance = UIConversationScene.Instance;
		if (instance == null)
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires UIConversationScene.Instance.");
			return null;
		}
		context.ReleasePostProcessEffect(TData.effectKey);
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(TData.postProcessPrefab, instance.transform);
		await handle;
		if (token.IsCancellationRequested)
		{
			ReleaseHandle(handle);
			return null;
		}
		GameObject gameObject = handle.AsGameObject();
		if (gameObject == null)
		{
			Debug.LogError("PostProcessPrefabStepEventNode failed to instantiate postProcessPrefab.");
			ReleaseHandle(handle);
			return null;
		}
		Volume componentInChildren = gameObject.GetComponentInChildren<Volume>(includeInactive: true);
		IPostProcessWeightTarget postProcessWeightTarget = FindWeightTarget(gameObject);
		if (componentInChildren == null && postProcessWeightTarget == null)
		{
			Debug.LogError("PostProcessPrefabStepEventNode postProcessPrefab requires a Volume or IPostProcessWeightTarget on root or child.");
			ReleaseHandle(handle);
			return null;
		}
		gameObject.SetActive(value: true);
		AVGPostProcessRuntimeEffect aVGPostProcessRuntimeEffect = new AVGPostProcessRuntimeEffect(handle, gameObject, componentInChildren, postProcessWeightTarget, gameObject.GetComponentInChildren<Animator>(includeInactive: true), gameObject.GetComponentInChildren<Animation>(includeInactive: true), TData.releaseOnDialogueEnd);
		aVGPostProcessRuntimeEffect.SetWeight(TData.initialWeight);
		context.SetPostProcessEffect(TData.effectKey, aVGPostProcessRuntimeEffect);
		return aVGPostProcessRuntimeEffect;
	}

	private static IPostProcessWeightTarget FindWeightTarget(GameObject instance)
	{
		MonoBehaviour[] componentsInChildren = instance.GetComponentsInChildren<MonoBehaviour>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] is IPostProcessWeightTarget result)
			{
				return result;
			}
		}
		return null;
	}

	private async UniTask PlayEffect(LuminDialogueContext context, AVGPostProcessRuntimeEffect effect, bool releaseAfterPlay, CancellationToken token)
	{
		UniTask task = UniTask.CompletedTask;
		if (TData.playAnimation)
		{
			float num = effect.PlayAnimation(TData.animationStateName, TData.animationLayer);
			if (num > 0f)
			{
				task = LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(num), token);
			}
		}
		UniTask task2 = (TData.tweenWeight ? TweenWeight(effect, token) : UniTask.CompletedTask);
		await LuminDialogueUtility.WhenAllPooled(task, task2).SuppressCancellationThrow();
		if (releaseAfterPlay || TData.releaseAfterAnimation)
		{
			context.ReleasePostProcessEffect(TData.effectKey);
		}
	}

	private async UniTask TweenWeight(AVGPostProcessRuntimeEffect effect, CancellationToken token)
	{
		if (!TData.tweenWeight)
		{
			return;
		}
		if (TData.weightDuration <= 0f)
		{
			effect.SetWeight(TData.targetWeight);
			return;
		}
		UniTask<bool> uniTask = effect.TweenWeight(TData.targetWeight, TData.weightDuration, token).SuppressCancellationThrow();
		await LuminDialogueUtility.WhenAllPooled(task1: LuminDialogueUtility.WaitForSecondsOrForceNext(TData.weightDuration, token, () =>
		{
			effect.SetWeight(TData.targetWeight);
		}), task0: uniTask).SuppressCancellationThrow();
	}

	private bool TryGetEffect(LuminDialogueContext context, out AVGPostProcessRuntimeEffect effect)
	{
		if (context.TryGetPostProcessEffect(TData.effectKey, out effect))
		{
			return true;
		}
		Debug.LogWarning("PostProcessPrefabStepEventNode cannot find effectKey: " + TData.effectKey);
		return false;
	}

	private static void ReleaseHandle(AssetLoadHandle handle)
	{
		if (handle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
	}
}
