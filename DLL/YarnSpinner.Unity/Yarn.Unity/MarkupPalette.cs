using System;
using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

[CreateAssetMenu(fileName = "NewPalette", menuName = "Yarn Spinner/Markup Palette", order = 102)]
public class MarkupPalette : ScriptableObject
{
	[Serializable]
	public struct ColorMarker
	{
		public string Marker;

		public Color Color;
	}

	public List<ColorMarker> ColourMarkers = new List<ColorMarker>();

	public bool ColorForMarker(string Marker, out Color colour)
	{
		foreach (ColorMarker colourMarker in ColourMarkers)
		{
			if (colourMarker.Marker == Marker)
			{
				colour = colourMarker.Color;
				return true;
			}
		}
		colour = Color.black;
		return false;
	}
}
