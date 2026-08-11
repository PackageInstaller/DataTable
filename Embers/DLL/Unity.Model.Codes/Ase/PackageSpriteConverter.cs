using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PackageSpriteConverter : IConverter
{
	private Dictionary<string, Sprite> sprites;

	public void Add(Sprite sprite)
	{
		if (!(sprite == null))
		{
			if (sprites == null)
			{
				sprites = new Dictionary<string, Sprite>();
			}
			if (sprites.ContainsKey(sprite.name))
			{
				throw new Exception("The sprite " + sprite.name + " already exists in the dictionary");
			}
			sprites.Add(sprite.name, sprite);
		}
	}

	public object Convert(object value)
	{
		if (value == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(value.ToString()))
		{
			return null;
		}
		sprites.TryGetValue((string)value, out var value2);
		return value2;
	}

	public object ConvertBack(object value)
	{
		throw new NotImplementedException();
	}
}
