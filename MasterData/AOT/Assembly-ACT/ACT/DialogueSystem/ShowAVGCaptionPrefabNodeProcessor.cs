using System;
using System.Threading;
using ACT.Drama;
using ACT.UI;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.DialogueSystem;

public class ShowAVGCaptionPrefabNodeProcessor : DialogueNodeProcessor<ShowAVGCaptionPrefabNode>, IDialogueInputHandler
{
	private AssetLoadHandle m_Handle;

	private MonoAVGCaptionSequence m_Sequence;

	private DialogueInputHandle m_InputHandle;

	private bool m_Subscribed;

	protected override async UniTask<DialogueNodeResult> OnExecute(DialogueFlowExecution execution, DialogueContext context, CancellationToken token)
	{
		LuminDialogueFlowProcessor luminFlow = (LuminDialogueFlowProcessor)Flow;
		if (((LuminDialogueContext)context).Skipping)
		{
			return DialogueNodeResult.Continue;
		}
		MonoConversationView conversationView = Singleton<ConversationManager>.instance.conversationView;
		if (conversationView == null || TData.captionPrefab == null || string.IsNullOrEmpty(TData.captionPrefab.GUID))
		{
			return DialogueNodeResult.Continue;
		}
		try
		{
			Transform captionPrefabRoot = conversationView.GetCaptionPrefabRoot();
			m_Handle = AssetStationManager.BattleStation.InstantiateAsync(TData.captionPrefab, captionPrefabRoot);
			await m_Handle;
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			GameObject gameObject = m_Handle.AsGameObject();
			if (gameObject == null)
			{
				return DialogueNodeResult.Continue;
			}
			gameObject.SetActive(value: true);
			m_Sequence = gameObject.GetComponentInChildren<MonoAVGCaptionSequence>(includeInactive: true);
			if (m_Sequence == null)
			{
				Debug.LogError("ShowAVGCaptionPrefabNode requires MonoAVGCaptionSequence on caption prefab.");
				return DialogueNodeResult.Continue;
			}
			m_Sequence.Prepare(luminFlow);
			SubscribeInput();
			await m_Sequence.PlayIn(token).SuppressCancellationThrow();
			if (token.IsCancellationRequested)
			{
				return DialogueNodeResult.Continue;
			}
			if (!TData.hideBlackScreenWithCaption)
			{
				await m_Sequence.Hide(token).SuppressCancellationThrow();
			}
			else
			{
				UniTask task = m_Sequence.Hide(token);
				UniTask task2 = conversationView.blackScreen.Hide(TData.blackScreenHideSpeed);
				await LuminDialogueUtility.WhenAllPooled(task, task2).SuppressCancellationThrow();
			}
			_ = token.IsCancellationRequested;
			return DialogueNodeResult.Continue;
		}
		catch (Exception message)
		{
			Debug.LogError(message);
			return DialogueNodeResult.Continue;
		}
		finally
		{
			if (token.IsCancellationRequested && m_Sequence != null)
			{
				m_Sequence.CompleteImmediate(visible: false);
			}
			UnsubscribeInput();
			ReleasePrefab();
		}
	}

	private void SubscribeInput()
	{
		if (!m_Subscribed && Singleton<ConversationManager>.instance.PlayingDialogue is IAVGDialogue iAVGDialogue)
		{
			m_InputHandle = iAVGDialogue.RegisterInputHandler(this);
			m_Subscribed = true;
		}
	}

	private void UnsubscribeInput()
	{
		if (m_Subscribed)
		{
			m_InputHandle.Dispose();
			m_InputHandle = default;
			m_Subscribed = false;
		}
	}

	public bool TryNext()
	{
		if (TData.completeCurrentOnClick && m_Sequence != null && m_Sequence.IsPlaying)
		{
			m_Sequence.CompleteCurrent();
			return true;
		}
		return false;
	}

	public void ForceNext()
	{
		if (m_Sequence != null && m_Sequence.IsPlaying)
		{
			m_Sequence.SkipToEnd();
		}
	}

	private void ReleasePrefab()
	{
		m_Sequence = null;
		if (!m_Handle.IsValid)
		{
			return;
		}
		if (m_Handle.IsDone)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
		}
		else
		{
			m_Handle.Completed += (AssetLoadHandle handle) =>
			{
				AssetStationManager.BattleStation.ReleaseInstance(handle);
			};
		}
		m_Handle = default;
	}
}
