using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public struct RichTagConfig
{
	public RichTextTag.TagType tag;

	public int IntValue;

	public float FloatValue;

	public bool BooleanValue;

	public Color ColorValue;

	public Vector3 Vector3Value;

	public string StringValue;
}
