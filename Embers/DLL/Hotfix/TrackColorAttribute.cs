using System;
using UnityEngine;

public class TrackColorAttribute : Attribute
{
	public Color Color;

	public TrackColorAttribute(float r, float g, float b)
	{
		Color = new Color(r, g, b);
	}
}
