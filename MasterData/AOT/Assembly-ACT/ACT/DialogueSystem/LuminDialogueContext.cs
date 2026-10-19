using System.Collections.Generic;
using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.DialogueSystem;

public class LuminDialogueContext : DialogueContext
{
	private int m_StoryGroupId;

	private LuminDialogueFlowType m_StoryGroupMode;

	private ConversationManager.ConversationTriggerSource m_TriggerSource;

	private DialogueEnvironment m_Env;

	private bool m_Skipping;

	private readonly DialogueSubTaskContainer m_SubTasks = new DialogueSubTaskContainer();

	private UniTaskCompletionSource m_NextAppearCompletion;

	private readonly Dictionary<string, AVGPostProcessRuntimeEffect> m_PostProcessEffects = new Dictionary<string, AVGPostProcessRuntimeEffect>();

	public int StoryGroupId => m_StoryGroupId;

	public LuminDialogueFlowType StoryGroupMode => m_StoryGroupMode;

	public DialogueEnvironment Env => m_Env;

	public ConversationManager.ConversationTriggerSource TriggerSource => m_TriggerSource;

	public bool Skipping
	{
		get
		{
			if (!m_Skipping)
			{
				return m_SubTasks.Flushing;
			}
			return true;
		}
		set
		{
			m_Skipping = value;
		}
	}

	public bool SkipRequested => m_Skipping;

	public DialogueSubTaskContainer SubTasks => m_SubTasks;

	public LuminDialogueContext(int storyGroupId, LuminDialogueFlowType storyGroupMode, DialogueEnvironment env)
	{
		m_StoryGroupId = storyGroupId;
		m_StoryGroupMode = storyGroupMode;
		m_TriggerSource = ConversationManager.ConversationTriggerSource.Normal;
		m_Env = env;
	}

	public LuminDialogueContext(int storyGroupId, LuminDialogueFlowType storyGroupMode, ConversationManager.ConversationTriggerSource triggerSource, DialogueEnvironment env)
	{
		m_StoryGroupId = storyGroupId;
		m_StoryGroupMode = storyGroupMode;
		m_TriggerSource = triggerSource;
		m_Env = env;
	}

	public async UniTask BeginSkip()
	{
		if (!m_Skipping)
		{
			m_Skipping = true;
			await m_SubTasks.FlushToEnd();
		}
	}

	public void UpdateSceneCompleted()
	{
		m_NextAppearCompletion?.TrySetResult();
		m_NextAppearCompletion = null;
	}

	public void PrepareNextUpdateSceneCompletion()
	{
		m_NextAppearCompletion = new UniTaskCompletionSource();
	}

	public async UniTask WaitNextUpdateSceneCompletionAsync(CancellationToken token)
	{
		if (m_NextAppearCompletion != null)
		{
			await m_NextAppearCompletion.Task.AttachExternalCancellation(token).SuppressCancellationThrow();
		}
	}

	public bool TryGetPostProcessEffect(string key, out AVGPostProcessRuntimeEffect effect)
	{
		if (string.IsNullOrEmpty(key))
		{
			effect = null;
			return false;
		}
		if (m_PostProcessEffects.TryGetValue(key, out effect))
		{
			return effect != null;
		}
		return false;
	}

	public void SetPostProcessEffect(string key, AVGPostProcessRuntimeEffect effect)
	{
		if (!string.IsNullOrEmpty(key) && effect != null)
		{
			ReleasePostProcessEffect(key);
			m_PostProcessEffects[key] = effect;
		}
	}

	public void ReleasePostProcessEffect(string key)
	{
		if (!string.IsNullOrEmpty(key) && m_PostProcessEffects.TryGetValue(key, out var value))
		{
			m_PostProcessEffects.Remove(key);
			value.Release();
		}
	}

	public void ReleaseAllPostProcessEffects(bool dialogueEndOnly)
	{
		if (m_PostProcessEffects.Count == 0)
		{
			return;
		}
		List<string> list = ListPool<string>.Get();
		foreach (KeyValuePair<string, AVGPostProcessRuntimeEffect> postProcessEffect in m_PostProcessEffects)
		{
			if (!dialogueEndOnly || postProcessEffect.Value.ReleaseOnDialogueEnd)
			{
				list.Add(postProcessEffect.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			ReleasePostProcessEffect(list[i]);
		}
		ListPool<string>.Release(list);
	}
}
