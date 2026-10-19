using System;
using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.DialogueSystem;

public abstract class FixedPostProcessStepEventNodeProcessor<T> : ChatStepEventNodeProcessor<T> where T : FixedPostProcessStepEventNode
{
	private bool m_ReleasedOnExit;

	private PostProcessPrefabOperation m_Operation;

	public abstract string EffectKey { get; }

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueContext luminContext = context as LuminDialogueContext;
		if (luminContext == null)
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires LuminDialogueContext.");
			return DialogueNodeResult.Continue;
		}
		if (string.IsNullOrEmpty(EffectKey))
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires a non-empty effectKey.");
			return DialogueNodeResult.Continue;
		}
		m_ReleasedOnExit = false;
		if (luminContext.Skipping)
		{
			if (m_Operation == PostProcessPrefabOperation.Release || m_Operation == PostProcessPrefabOperation.PlayAndRelease || (m_Operation == PostProcessPrefabOperation.LoadAndPlay && TData.releaseOnExit))
			{
				luminContext.ReleasePostProcessEffect(EffectKey);
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
			luminContext.SubTasks.Run(new DialogueSubTask(RunPostProcessSubTask(luminContext, childCts), () =>
			{
				SkipPostProcessToEnd(luminContext, childCts);
			}));
		}
		return DialogueNodeResult.Continue;
	}

	private async UniTask RunPostProcessSubTask(LuminDialogueContext context, CancellationTokenSource cts)
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

	private void SkipPostProcessToEnd(LuminDialogueContext context, CancellationTokenSource cts)
	{
		try
		{
			cts.Cancel();
		}
		catch (ObjectDisposedException)
		{
		}
		AVGPostProcessRuntimeEffect effect;
		if (m_Operation == PostProcessPrefabOperation.Release || m_Operation == PostProcessPrefabOperation.PlayAndRelease || TData.releaseAfterAnimation || (m_Operation == PostProcessPrefabOperation.LoadAndPlay && TData.releaseOnExit))
		{
			context.ReleasePostProcessEffect(EffectKey);
		}
		else if ((m_Operation == PostProcessPrefabOperation.SetWeight || TData.tweenWeight) && context.TryGetPostProcessEffect(EffectKey, out effect))
		{
			effect.SetWeight(TData.targetWeight);
		}
	}

	public override UniTask ExecuteStepEvent(ChatStep chatStep, DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		bool flag = chatStep == ChatStep.OnExit && TData.releaseOnExit && (TData.step & ChatStep.OnExit) == 0;
		if (!flag && (chatStep & TData.step) == 0)
		{
			return UniTask.CompletedTask;
		}
		if (!(context is LuminDialogueContext luminDialogueContext))
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires LuminDialogueContext.");
			return UniTask.CompletedTask;
		}
		if (string.IsNullOrEmpty(EffectKey))
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires a non-empty effectKey.");
			return UniTask.CompletedTask;
		}
		if (flag)
		{
			m_ReleasedOnExit = true;
			luminDialogueContext.ReleasePostProcessEffect(EffectKey);
			return UniTask.CompletedTask;
		}
		return Execute(execution, context, token);
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
			switch (m_Operation)
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
				context.ReleasePostProcessEffect(EffectKey);
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
		UIConversationScene instance = UIConversationScene.Instance;
		if (instance == null)
		{
			Debug.LogError("PostProcessPrefabStepEventNode requires UIConversationScene.Instance.");
			return null;
		}
		context.ReleasePostProcessEffect(EffectKey);
		AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(EffectKey, instance.transform);
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
		Animator componentInChildren2 = gameObject.GetComponentInChildren<Animator>(includeInactive: true);
		Animation componentInChildren3 = gameObject.GetComponentInChildren<Animation>(includeInactive: true);
		AVGPostProcessRuntimeEffect aVGPostProcessRuntimeEffect = new AVGPostProcessRuntimeEffect(handle, gameObject, componentInChildren, postProcessWeightTarget, componentInChildren2, componentInChildren3, TData.releaseOnDialogueEnd);
		aVGPostProcessRuntimeEffect.SetWeight(TData.initialWeight);
		context.SetPostProcessEffect(EffectKey, aVGPostProcessRuntimeEffect);
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
		UniTask completedTask = UniTask.CompletedTask;
		UniTask task = (TData.tweenWeight ? TweenWeight(effect, token) : UniTask.CompletedTask);
		await LuminDialogueUtility.WhenAllPooled(completedTask, task).SuppressCancellationThrow();
		if (releaseAfterPlay || TData.releaseAfterAnimation)
		{
			context.ReleasePostProcessEffect(EffectKey);
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
		if (context.TryGetPostProcessEffect(EffectKey, out effect))
		{
			return true;
		}
		Debug.LogWarning("PostProcessPrefabStepEventNode cannot find effectKey: " + EffectKey);
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
