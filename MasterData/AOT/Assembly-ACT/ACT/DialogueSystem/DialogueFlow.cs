using System;
using UnityEngine;

namespace ACT.DialogueSystem;

[Serializable]
public class DialogueFlow
{
	[SerializeReference]
	public DialogueRoot root = new DialogueRoot();
}
