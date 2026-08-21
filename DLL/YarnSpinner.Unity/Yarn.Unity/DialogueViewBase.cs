using System;
using UnityEngine;

namespace Yarn.Unity;

public abstract class DialogueViewBase : MonoBehaviour
{
	public Action requestInterrupt;

	public virtual void DialogueStarted()
	{
	}

	public virtual void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		onDialogueLineFinished?.Invoke();
	}

	public virtual void InterruptLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		onDialogueLineFinished?.Invoke();
	}

	public virtual void DismissLine(Action onDismissalComplete)
	{
		onDismissalComplete?.Invoke();
	}

	public virtual void RunOptions(DialogueOption[] dialogueOptions, Action<int> onOptionSelected)
	{
	}

	public virtual void DialogueComplete()
	{
	}

	public virtual void UserRequestedViewAdvancement()
	{
	}
}
