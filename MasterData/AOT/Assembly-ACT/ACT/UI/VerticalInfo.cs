using System;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class VerticalInfo
{
	public enum Type
	{
		Text,
		Image
	}

	public Type type;

	public int content;

	public Sprite sprite;
}
