using System;

namespace Ase;

public interface IDialogueEvent
{
	void RegisterDialogueCallback();

	void OnEnterInteractiveCallback(object sender, DialogueViewModel dialogueViewModel);

	void OnSendInteractiveEventCallback(object sender, MapItemEventType eventType);

	void OnFinishedInteractiveCallback(object sender, EventArgs e);
}
