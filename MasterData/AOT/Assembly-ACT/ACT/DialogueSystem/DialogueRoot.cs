using System;

namespace ACT.DialogueSystem;

[Serializable]
public class DialogueRoot : DialogueNode
{
	public DialogueRoot()
	{
		children.Add(new DialogueGroup
		{
			title = "Main"
		});
	}
}
