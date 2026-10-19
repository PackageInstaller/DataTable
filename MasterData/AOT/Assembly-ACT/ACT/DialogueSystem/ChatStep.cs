using System;

namespace ACT.DialogueSystem;

[Flags]
public enum ChatStep
{
	None = 0,
	OnEnter = 1,
	OnBeforeUpdateScene = 2,
	OnUpdateScene = 4,
	OnAfterUpdateScene = 8,
	OnBeforeShowDialogue = 0x10,
	OnShowDialogue = 0x20,
	OnAfterShowDialogue = 0x40,
	OnExit = 0x80,
	All = -1
}
