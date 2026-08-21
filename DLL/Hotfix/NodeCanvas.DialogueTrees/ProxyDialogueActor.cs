using System;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Serializable]
public class ProxyDialogueActor : IDialogueActor
{
	private string _name;

	private Transform _transform;

	public string name => _name;

	public Texture2D portrait => null;

	public Sprite portraitSprite => null;

	public Color dialogueColor => Color.white;

	public Vector3 dialoguePosition => Vector3.zero;

	public Transform transform => _transform;

	public ProxyDialogueActor(string name, Transform transform)
	{
		_name = name;
		_transform = transform;
	}
}
