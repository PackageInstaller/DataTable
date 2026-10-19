using System;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.DialogueSystem;
using ACT.Event;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Drama;

public class AVGDialogueFromInstance : DialogueWrapper, IAVGDialogue
{
	private GameObject m_DialogueInstance;

	private ConversationManager.ConversationTriggerSource m_TriggerSource;

	private DialogueEnvironment m_DialogueEnvironment;

	private LuminDialogueContext m_Context;

	private bool m_IsRunning;

	private bool m_BeginSkipRunning;

	public GameObject DialogueInstance => m_DialogueInstance;

	public int StoryGroupId => m_DialogueEnvironment.FlowAsset.data.storyGroupId;

	public bool IsRunning
	{
		get
		{
			if (m_IsRunning)
			{
				return IsPlaying();
			}
			return false;
		}
	}

	public event Func<CancellationToken, UniTask> OnBegin;

	public event Func<CancellationToken, UniTask> OnEnd;

	public AVGDialogueFromInstance(GameObject dialogueInstance, ConversationManager.ConversationTriggerSource triggerSource)
	{
		m_DialogueInstance = dialogueInstance;
		m_DialogueEnvironment = m_DialogueInstance.GetComponent<DialogueEnvironment>();
		m_TriggerSource = triggerSource;
	}

	protected override async UniTask Play(CancellationToken token)
	{
		m_IsRunning = true;
		ConversationAVGStartEvt evt = Singleton<EventManager>.instance.GetEvt<ConversationAVGStartEvt>();
		evt.conversationId = StoryGroupId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Conversation_AVG_Start, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		UniTask uniTask = UniTask.CompletedTask;
		UniTask uniTask2 = UniTask.CompletedTask;
		UniTask uniTask3 = UniTask.CompletedTask;
		if (OnBegin != null)
		{
			uniTask = OnBegin(token);
		}
		if (token.IsCancellationRequested)
		{
			return;
		}
		if (m_TriggerSource == ConversationManager.ConversationTriggerSource.Mission)
		{
			Singleton<NewUIManager>.instance.CloseAllUI();
			uniTask2 = UniTask.WaitForSeconds(0.5f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			uniTask3 = WaitIdle(token);
		}
		await UniTask.WhenAll(uniTask, uniTask2, uniTask3);
		m_Context = new LuminDialogueContext(m_DialogueEnvironment.FlowAsset.data.storyGroupId, m_DialogueEnvironment.FlowAsset.data.dialogueType, m_TriggerSource, m_DialogueEnvironment);
		await m_DialogueEnvironment.PlayAsync(m_Context, token).SuppressCancellationThrow();
		if (token.IsCancellationRequested)
		{
			DoStopLogic();
			await OnEnd(token);
			return;
		}
		if (OnEnd != null)
		{
			await OnEnd(token);
		}
		m_IsRunning = false;
		ConversationAVGEndEvt evt2 = Singleton<EventManager>.instance.GetEvt<ConversationAVGEndEvt>();
		evt2.conversationId = StoryGroupId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Conversation_AVG_End, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private async UniTask WaitIdle(CancellationToken token)
	{
		await UniTask.WaitUntil(() =>
		{
			if (!MonoECS.instance)
			{
				return false;
			}
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity == null)
			{
				return false;
			}
			CompMotion compMotion = mainEntity.GetCompMotion();
			CompPhysics compPhysics = mainEntity.GetCompPhysics();
			if (compMotion == null || compPhysics == null)
			{
				return false;
			}
			return compMotion.curMotionState == MotionState.Idle && compPhysics.isGrounded;
		}, PlayerLoopTiming.Update, token);
	}

	private void DoStopLogic()
	{
		m_DialogueInstance = null;
		m_DialogueEnvironment = null;
	}

	async UniTask IAVGDialogue.BeginSkip()
	{
		if (m_Context == null)
		{
			ForceNext();
		}
		else
		{
			if (m_BeginSkipRunning)
			{
				return;
			}
			if (m_Context.SkipRequested)
			{
				ForceNext();
			}
			else
			{
				if (m_BeginSkipRunning)
				{
					return;
				}
				m_BeginSkipRunning = true;
				try
				{
					if (m_Context != null)
					{
						await m_Context.BeginSkip();
					}
				}
				finally
				{
					m_BeginSkipRunning = false;
					ForceNext();
				}
			}
		}
	}

	protected override void Skip()
	{
		((IAVGDialogue)this).BeginSkip();
	}
}
