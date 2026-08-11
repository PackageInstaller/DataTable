using System;
using UnityEngine.Events;

namespace Yarn.Unity;

public class DialogueCharacterNameView : DialogueViewBase
{
	public DialogueRunner.StringUnityEvent onNameUpdate;

	public UnityEvent onDialogueStarted;

	public UnityEvent onNameNotPresent;

	public override void DialogueStarted()
	{
		onDialogueStarted?.Invoke();
	}

	public override void RunLine(LocalizedLine dialogueLine, Action onDialogueLineFinished)
	{
		string characterName = dialogueLine.CharacterName;
		if (!string.IsNullOrEmpty(characterName))
		{
			onNameUpdate?.Invoke(characterName);
		}
		else
		{
			onNameNotPresent?.Invoke();
		}
		onDialogueLineFinished();
	}
}
