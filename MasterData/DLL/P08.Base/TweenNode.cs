using System;
using UnityEngine;

[Serializable]
public class TweenNode
{
	public TweenType type;

	[SerializeField]
	public GameObject go;

	public Vector4 fromData;

	public Vector4 toData;

	public bool isInitFrom;

	public float time;

	public float delay;

	public LeanTweenType easeType;
}
