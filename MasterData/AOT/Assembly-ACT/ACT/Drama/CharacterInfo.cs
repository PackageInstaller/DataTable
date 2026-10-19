using System;
using ACT.DialogueSystem;
using UnityEngine;

namespace ACT.Drama;

[Serializable]
public struct CharacterInfo
{
	[DialogueCharacterPicker]
	public int id;

	public GameObject character;
}
