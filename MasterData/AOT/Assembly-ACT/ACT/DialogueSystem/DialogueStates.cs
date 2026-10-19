using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace ACT.DialogueSystem;

public class DialogueStates
{
	private readonly Dictionary<Type, DialogueState> m_States = new Dictionary<Type, DialogueState>();

	public T GetState<T>() where T : DialogueState, new()
	{
		Type typeFromHandle = typeof(T);
		return m_States.GetValueOrDefault(typeFromHandle) as T;
	}

	public T GetOrCreateState<T>() where T : DialogueState, new()
	{
		Type typeFromHandle = typeof(T);
		if (!m_States.TryGetValue(typeFromHandle, out var value))
		{
			DialogueState dialogueState = (m_States[typeFromHandle] = new T());
			value = dialogueState;
		}
		return (T)value;
	}

	public void GetAllState(List<DialogueState> states)
	{
		states.Clear();
		states.AddRange(m_States.Values);
	}

	public async UniTask ApplyAllStates(DialogueContext context, CancellationToken token)
	{
		foreach (KeyValuePair<Type, DialogueState> state in m_States)
		{
			await ((IDialogueStateInternal)state.Value).ApplyImmediate(context, token);
		}
	}

	public void ClearAllStates()
	{
		m_States.Clear();
	}
}
