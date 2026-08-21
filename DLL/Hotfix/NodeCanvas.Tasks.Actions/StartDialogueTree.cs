using NodeCanvas.DialogueTrees;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Dialogue")]
[Description("Starts the Dialogue Tree assigned on a Dialogue Tree Controller object with specified agent used for 'Instigator'.")]
[Icon("Dialogue", false, "")]
public class StartDialogueTree : ActionTask<IDialogueActor>
{
	[RequiredField]
	public BBParameter<DialogueTreeController> dialogueTreeController;

	public bool waitActionFinish = true;

	public bool isPrefab;

	private DialogueTreeController instance;

	protected override string info => $"Start Dialogue {dialogueTreeController}";

	protected override void OnExecute()
	{
		instance = (isPrefab ? Object.Instantiate(dialogueTreeController.value) : dialogueTreeController.value);
		if (waitActionFinish)
		{
			instance.StartDialogue(base.agent, delegate(bool success)
			{
				if (isPrefab)
				{
					Object.Destroy(instance.gameObject);
				}
				EndAction(success);
			});
			return;
		}
		instance.StartDialogue(base.agent, delegate
		{
			if (isPrefab)
			{
				Object.Destroy(instance.gameObject);
			}
		});
		EndAction();
	}
}
