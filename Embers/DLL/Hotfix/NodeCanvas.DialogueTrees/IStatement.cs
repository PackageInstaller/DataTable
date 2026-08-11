using UnityEngine;

namespace NodeCanvas.DialogueTrees;

public interface IStatement
{
	string text { get; }

	AudioClip audio { get; }

	string meta { get; }
}
