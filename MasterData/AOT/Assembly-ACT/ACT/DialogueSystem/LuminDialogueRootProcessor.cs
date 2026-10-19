using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Drama;
using ACT.Event;
using ACT.UI;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.DialogueSystem;

public class LuminDialogueRootProcessor : DialogueNodeProcessor<LuminDialogueRoot>
{
	private float lastBgmVolume;

	private bool currentIsScreenMuteSnapShot;

	private const string SceneBlurStateName = "AVGSceneBlur";

	private AssetLoadHandle m_BlurAssetHandle;

	private async UniTask<DialogueNodeResult> ExecuteAVG(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext luminContext, DialogueFlowExecution execution, CancellationToken token)
	{
		DialogueNodeResult result = DialogueNodeResult.Continue;
		try
		{
			if (luminFlow.TData.muteBGM && !currentIsScreenMuteSnapShot)
			{
				currentIsScreenMuteSnapShot = true;
				GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
				evt.IsInState = true;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAVGPlayStateChange, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		try
		{
			result = ((!luminFlow.TData.useSceneBg) ? (await EnterImageBgAVGAsync(luminFlow, luminContext, execution, token)) : (await EnterSceneBlurAVGAsync(luminFlow, luminContext, execution, token)));
		}
		catch (Exception message2)
		{
			Debug.LogError(message2);
		}
		if (result.Type == DialogueNodeResultType.Error)
		{
			Debug.LogError(result.Message);
		}
		await CleanupAfterChildren(luminFlow, luminContext, token);
		return result;
	}

	private async UniTask<DialogueNodeResult> EnterSceneBlurAVGAsync(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext luminContext, DialogueFlowExecution execution, CancellationToken token)
	{
		bool inputPaused = false;
		AVGEnterInputPause(ref inputPaused);
		try
		{
			UniTask task = Singleton<UISceneManager>.instance.LoadScene<UIConversationScene>(GameLoader.meta.uiConversationSceneReferenceAssetID.GUID);
			UniTask<MonoConversationView> uniTask = AwaitDeferredConversationViewAsync(token);
			await LuminDialogueUtility.WhenAllPooled(task, uniTask);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			try
			{
				m_BlurAssetHandle = AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.conversationSceneBlurAssetID);
				await BlurTask(m_BlurAssetHandle, token);
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			try
			{
				Singleton<UISceneManager>.instance.OpenScene<UIConversationScene>();
				LuminDialogueUtility.SetAVGURPGraphicSettings();
				Singleton<UISceneManager>.instance.GetScene<UIConversationScene>().OpenSceneBg();
				ReleaseSceneBlur();
			}
			catch (Exception message2)
			{
				Debug.LogError(message2);
			}
			await PlayDeferredConversationOpenAsync(token);
			ReleaseAVGEnterInputPause(ref inputPaused);
			SetRootFinished(luminContext);
			ExitBlackScreenOnStart(luminFlow, luminContext, token).Forget();
			return await ExecuteChildren(execution, luminContext, token);
		}
		finally
		{
			ReleaseAVGEnterInputPause(ref inputPaused);
		}
	}

	private async UniTask<DialogueNodeResult> EnterImageBgAVGAsync(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext context, DialogueFlowExecution execution, CancellationToken token)
	{
		bool inputPaused = false;
		AVGEnterInputPause(ref inputPaused);
		try
		{
			UniTask task = Singleton<UISceneManager>.instance.LoadScene<UIConversationScene>(GameLoader.meta.uiConversationSceneReferenceAssetID.GUID);
			UniTask<MonoConversationView> uniTask = AwaitDeferredConversationViewAsync(token);
			await LuminDialogueUtility.WhenAllPooled(task, uniTask);
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime),
				fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime)
			});
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			UIConversationScene scene = null;
			try
			{
				Singleton<UISceneManager>.instance.OpenScene<UIConversationScene>();
				LuminDialogueUtility.SetAVGURPGraphicSettings();
				scene = Singleton<UISceneManager>.instance.GetScene<UIConversationScene>();
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
			await PlayDeferredConversationOpenAsync(token);
			context.PrepareNextUpdateSceneCompletion();
			ReleaseAVGEnterInputPause(ref inputPaused);
			UniTask<DialogueNodeResult> task2 = ExecuteChildren(execution, context, token);
			if (scene != null)
			{
				UniTask uniTask2 = context.WaitNextUpdateSceneCompletionAsync(token);
				UniTask uniTask3 = LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(5.0), token);
				await UniTask.WhenAny(uniTask2, uniTask3);
			}
			await PlayStartBlackScreenOutAsync(luminFlow, token, forceWait: true);
			SetRootFinished(context);
			return await task2;
		}
		finally
		{
			ReleaseAVGEnterInputPause(ref inputPaused);
		}
	}

	private async UniTask<MonoConversationView> AwaitDeferredConversationViewAsync(CancellationToken token)
	{
		return await LuminDialogueUtility.AwaitConversationView(token, new MonoConversationView.ConversationViewInitArg
		{
			DeferredOpenAnimation = true
		});
	}

	private async UniTask PlayDeferredConversationOpenAsync(CancellationToken token)
	{
		if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) is MonoConversationView monoConversationView)
		{
			await monoConversationView.PlayDeferredOpenAnimationAsync(token);
		}
	}

	private async UniTask PlayStartBlackScreenOutAsync(LuminDialogueFlowProcessor luminFlow, CancellationToken token = default(CancellationToken), bool forceWait = false)
	{
		_ = 1;
		try
		{
			if (luminFlow.TData.blackScreenOnStart && luminFlow.TData.blackScreenOnStartDuration > 0f)
			{
				await LuminDialogueUtility.WaitForSecondsOrForceNext(luminFlow.TData.blackScreenOnStartDuration, token);
			}
			UniTask task = Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime),
				fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime)
			});
			if (forceWait || luminFlow.TData.blackScreenOnStartWait)
			{
				await task;
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			}
			else
			{
				task.Forget();
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private async UniTask ExitSceneBlurAVGAsync(LuminDialogueFlowProcessor luminFlow, CancellationToken token)
	{
		await HideConversationContentBeforeCameraSwitchAsync(token);
		UIConversationScene scene = Singleton<UISceneManager>.instance.GetScene<UIConversationScene>();
		MonoConversationView conversationView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView;
		conversationView?.ShowSceneBlurSnapshotOverlay();
		if (luminFlow.TData.blackScreenOnStop)
		{
			Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
			{
				fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime),
				fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime)
			});
		}
		LuminDialogueUtility.ResetAVGURPGraphicSettings();
		scene?.RestoreMainBattleForTransition();
		Singleton<UISceneManager>.instance.ReleaseScene<UIConversationScene>();
		if (conversationView != null)
		{
			await conversationView.PlaySceneBlurSnapshotOverlayFadeOutAsync(token);
		}
		await Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_CONVERSATION);
		ScreenShotPass.Release();
		ExitBlackScreenOnStop(luminFlow).Forget();
	}

	private async UniTask ExitImageBgAVGAsync(LuminDialogueFlowProcessor luminFlow, CancellationToken token)
	{
		await HideConversationContentBeforeCameraSwitchAsync(token).AttachExternalCancellation(token);
		if (luminFlow.TData.blackScreenOnStop)
		{
			if (Singleton<NewUIManager>.HasInstance())
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
				Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime)
				}).Forget();
			}
			await UniTask.WaitForSeconds(luminFlow.TData.blackScreenOnStopTime, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		}
		LuminDialogueUtility.ResetAVGURPGraphicSettings();
		if (Singleton<UISceneManager>.HasInstance())
		{
			Singleton<UISceneManager>.instance.ReleaseScene<UIConversationScene>();
		}
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token);
		if (Singleton<NewUIManager>.HasInstance())
		{
			await Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_CONVERSATION).AttachExternalCancellation(token);
		}
		ExitBlackScreenOnStop(luminFlow).Forget();
	}

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		if (ChildrenCount == 0)
		{
			return DialogueNodeResult.Continue;
		}
		LuminDialogueFlowProcessor luminDialogueFlowProcessor = Flow as LuminDialogueFlowProcessor;
		LuminDialogueContext luminDialogueContext = (LuminDialogueContext)context;
		luminDialogueContext.States.GetOrCreateState<BGMState>().muteBGM = luminDialogueFlowProcessor.TData.muteBGM;
		luminDialogueContext.States.GetOrCreateState<LetterboxNodeProcessor.LetterboxState>().Reset();
		switch (luminDialogueFlowProcessor.TData.dialogueType)
		{
		case LuminDialogueFlowType.AVG:
			return await ExecuteAVG(luminDialogueFlowProcessor, luminDialogueContext, execution, token);
		case LuminDialogueFlowType.AVG_Mission:
		case LuminDialogueFlowType.AVG_NPC:
			return await ExecuteMissionAndNPC(luminDialogueFlowProcessor, luminDialogueContext, execution, token);
		default:
			return DialogueNodeResult.Continue;
		}
	}

	protected override async UniTask<DialogueNodeResult> OnJumpChild(DialogueStartRoute startRoute, DialogueContext context, CancellationToken token)
	{
		DialogueNodeProcessor c = GetChildById(startRoute.ChildId);
		if (c == null)
		{
			return DialogueNodeResult.Error($"找不到要跳转的子节点: {startRoute.ChildId}");
		}
		for (int i = c.Index; i < ChildrenCount; i++)
		{
			DialogueNodeProcessor child = GetChild(i);
			try
			{
				DialogueNodeResult result = ((child != c) ? (await child.Execute(startRoute.Execution, context, token)) : (await child.Jump(startRoute, context, token)));
				if (result.Type > DialogueNodeResultType.Continue)
				{
					return result;
				}
			}
			catch (Exception ex)
			{
				Debug.LogError(ex);
				return DialogueNodeResult.Error(ex.Message);
			}
			if (token.IsCancellationRequested)
			{
				break;
			}
		}
		return DialogueNodeResult.Continue;
	}

	private void SetRootFinished(LuminDialogueContext context)
	{
		context.States.GetOrCreateState<LuminFlowState>().RootFinished = true;
	}

	private async UniTask<DialogueNodeResult> ExecuteChildren(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		DialogueNodeResult result = DialogueNodeResult.Continue;
		int num = 0;
		if (num < ChildrenCount)
		{
			DialogueNodeProcessor child = GetChild(num);
			try
			{
				result = await child.Execute(execution, context, token);
			}
			catch (Exception ex)
			{
				Debug.LogError(ex);
				result = DialogueNodeResult.Error(ex.Message);
			}
		}
		return result;
	}

	private async UniTask PlayConversationUIHideAsync(CancellationToken token)
	{
		_ = 1;
		try
		{
			IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION);
			if (baseUIView is MonoConversationView conversationView && !(conversationView.uiEffectAnimator == null))
			{
				conversationView.uiEffectAnimator.Play("Hide", 0, 0f);
				await UniTask.Yield(PlayerLoopTiming.Update, token);
				AnimatorStateInfo currentAnimatorStateInfo = conversationView.uiEffectAnimator.GetCurrentAnimatorStateInfo(0);
				await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(GetSafeAnimatorStateLength(currentAnimatorStateInfo, 0.3f)), token);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private async UniTaskVoid ExitBlackScreenOnStart(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext luminContext, CancellationToken token)
	{
		try
		{
			UniTask uniTask = ExitBlackScreenOnStart_Inner();
			if (luminFlow.TData.blackScreenOnStartWait)
			{
				await uniTask;
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		SetRootFinished(luminContext);
		async UniTask ExitBlackScreenOnStart_Inner()
		{
			if (luminFlow.TData.blackScreenOnStart && luminFlow.TData.blackScreenOnStartDuration > 0f)
			{
				await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartDuration), token);
				Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime)
				}).Forget();
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			}
			else
			{
				await Singleton<NewUIManager>.instance.BlackScreen.Disable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime)
				});
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
			}
		}
	}

	private async UniTask ExitBlackScreenOnStop(LuminDialogueFlowProcessor luminFlow)
	{
		if (!luminFlow.TData.autoHideBlackScreenOnStop)
		{
			return;
		}
		if (luminFlow.TData.blackScreenOnStop)
		{
			await UniTask.WaitForSeconds(luminFlow.TData.blackScreenOnEndDuration);
		}
		if (Singleton<NewUIManager>.HasInstance())
		{
			FrameworkBlackScreen blackScreen = Singleton<NewUIManager>.instance.BlackScreen;
			if ((bool)blackScreen)
			{
				blackScreen.Disable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime)
				}).Forget();
				blackScreen.SetBlackScreenText(0, 0f);
			}
		}
	}

	private void ReleaseSceneBlur()
	{
		if (m_BlurAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_BlurAssetHandle);
			m_BlurAssetHandle = default;
		}
	}

	private async UniTask HideConversationContentBeforeCameraSwitchAsync(CancellationToken token)
	{
		UniTask task = PlayConversationUIHideAsync(token);
		UniTask task2 = UniTask.CompletedTask;
		try
		{
			UIConversationScene scene = Singleton<UISceneManager>.instance.GetScene<UIConversationScene>();
			if (scene != null)
			{
				task2 = scene.HideAllActorsAsync(token);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		await LuminDialogueUtility.WhenAllPooled(task, task2).SuppressCancellationThrow();
	}

	private float GetSafeAnimatorStateLength(AnimatorStateInfo stateInfo, float fallback)
	{
		float length = stateInfo.length;
		if (float.IsNaN(length) || float.IsInfinity(length) || length <= 0f || length > 10f)
		{
			return fallback;
		}
		return length;
	}

	private async UniTask BlurTask(AssetLoadHandle assetLoadHandle, CancellationToken token)
	{
		await assetLoadHandle;
		GameObject gameObject = assetLoadHandle.AsGameObject();
		DisableConversationImageBlurEffects(gameObject);
		Animator animator = gameObject?.GetComponentInChildren<Animator>();
		if (!(animator != null) || !(animator.runtimeAnimatorController != null))
		{
			await LuminDialogueUtility.WaitForSecondsOrForceNext(0.5f, token);
		}
		else
		{
			animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			animator.speed = 1f;
			animator.Play("AVGSceneBlur", 0, 0f);
			animator.Update(0f);
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			await LuminDialogueUtility.DelayOrForceNext(TimeSpan.FromSeconds(GetSafeAnimatorStateLength(currentAnimatorStateInfo, 0.5f)), token);
		}
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token);
		ScreenShotPass.Shot();
		await UniTask.DelayFrame(1, PlayerLoopTiming.LastPostLateUpdate, token);
	}

	private void DisableConversationImageBlurEffects(GameObject blurObject)
	{
		if (blurObject == null)
		{
			return;
		}
		ConversationImageBlur[] componentsInChildren = blurObject.GetComponentsInChildren<ConversationImageBlur>(includeInactive: true);
		foreach (ConversationImageBlur conversationImageBlur in componentsInChildren)
		{
			if (conversationImageBlur != null)
			{
				conversationImageBlur.enabled = false;
			}
		}
	}

	private async UniTask CleanupAfterChildren(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext luminContext, CancellationToken token)
	{
		if (currentIsScreenMuteSnapShot)
		{
			currentIsScreenMuteSnapShot = false;
			GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
			evt.IsInState = false;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnAVGPlayStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		luminContext.States.GetOrCreateState<BGMState>().ClearBgm();
		luminContext.States.GetOrCreateState<EnvBGMState>().ClearEnvBgm();
		luminContext.ReleaseAllPostProcessEffects(dialogueEndOnly: true);
		switch (luminFlow.TData.dialogueType)
		{
		case LuminDialogueFlowType.AVG:
			if (luminFlow.TData.useSceneBg)
			{
				await ExitSceneBlurAVGAsync(luminFlow, token);
			}
			else
			{
				await ExitImageBgAVGAsync(luminFlow, token);
			}
			break;
		case LuminDialogueFlowType.AVG_Mission:
		case LuminDialogueFlowType.AVG_NPC:
			if (luminFlow.TData.blackScreenOnStop)
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
				await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStopTime)
				});
			}
			Singleton<TimelineConversationManager>.instance.EndLeftModels();
			if (luminFlow.TData.hideControlRoles)
			{
				Entity mainEntity = MonoECS.instance.mainEntity;
				if (mainEntity != null)
				{
					GameObject model = mainEntity.GetModel();
					if ((bool)model)
					{
						model.gameObject.SetActive(value: true);
					}
				}
			}
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
			ExitBlackScreenOnStop(luminFlow).Forget();
			break;
		}
	}

	private static void AVGEnterInputPause(ref bool inputPaused)
	{
		if (!inputPaused)
		{
			MonoECS.instance.PushPause();
			MonoECS.instance.PushPauseUIInput();
			inputPaused = true;
		}
	}

	private static void ReleaseAVGEnterInputPause(ref bool inputPaused)
	{
		if (inputPaused)
		{
			MonoECS.instance.PopPauseUIInput();
			MonoECS.instance.PopPause();
			inputPaused = false;
		}
	}

	private IEnumerable<DialogueNodeProcessor> RecursiveAllNodes(DialogueNodeProcessor root)
	{
		if (root == null)
		{
			yield break;
		}
		yield return root;
		for (int i = 0; i < root.ChildrenCount; i++)
		{
			DialogueNodeProcessor child = root.GetChild(i);
			foreach (DialogueNodeProcessor item in RecursiveAllNodes(child))
			{
				yield return item;
			}
		}
	}

	private async UniTask<DialogueNodeResult> ExecuteMissionAndNPC(LuminDialogueFlowProcessor luminFlow, LuminDialogueContext luminContext, DialogueFlowExecution execution, CancellationToken token)
	{
		bool inputPaused = false;
		AVGEnterInputPause(ref inputPaused);
		try
		{
			if (luminFlow.TData.blackScreenOnStart)
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
				await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime),
					fadeOutTime = TimeSpan.FromSeconds(luminFlow.TData.blackScreenOnStartTime)
				});
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		if (luminFlow.TData.hideControlRoles)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity != null)
			{
				GameObject model = mainEntity.GetModel();
				if ((bool)model)
				{
					model.gameObject.SetActive(value: false);
				}
			}
		}
		try
		{
			Dictionary<int, string> dictionary = new Dictionary<int, string>();
			foreach (DialogueNodeProcessor item in RecursiveAllNodes(this))
			{
				if (item is ChatNodeProcessor chatNodeProcessor && !(chatNodeProcessor.TData.speaker == "<playername/>"))
				{
					int speakerId = chatNodeProcessor.TData.speakerId;
					if (!dictionary.ContainsKey(speakerId) && RuntimeConfigs.data != null && RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(speakerId, out var value) && !string.IsNullOrEmpty(value.model))
					{
						dictionary.Add(speakerId, value.model);
					}
				}
			}
			await Singleton<TimelineConversationManager>.instance.BeginLeftModels(dictionary, token);
		}
		catch (Exception message2)
		{
			Debug.LogError(message2);
		}
		try
		{
			await LuminDialogueUtility.AwaitConversationView(token);
		}
		catch (Exception message3)
		{
			Debug.LogError(message3);
		}
		ReleaseAVGEnterInputPause(ref inputPaused);
		ExitBlackScreenOnStart(luminFlow, luminContext, token).Forget();
		DialogueNodeResult result = DialogueNodeResult.Continue;
		try
		{
			result = await ExecuteChildren(execution, luminContext, token);
		}
		catch (Exception message4)
		{
			Debug.LogError(message4);
		}
		if (result.Type == DialogueNodeResultType.Error)
		{
			Debug.LogError(result.Message);
		}
		await CleanupAfterChildren(luminFlow, luminContext, token);
		return result;
	}
}
