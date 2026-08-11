using UnityEngine;

namespace NodeCanvas.DialogueTrees;

public interface IDialogueActor
{
	string name { get; }

	Texture2D portrait { get; }

	Sprite portraitSprite { get; }

	Color dialogueColor { get; }

	Vector3 dialoguePosition { get; }

	Transform transform { get; }
}
