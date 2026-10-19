using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

internal class MaterialReplacements
{
	private class MaterialOverride
	{
		private int _useCount;

		public Material original { get; private set; }

		public Material replacement { get; private set; }

		public MaterialOverride(Material original, Material replacement)
		{
			this.original = original;
			this.replacement = replacement;
			_useCount = 1;
		}

		public Material Get()
		{
			_useCount++;
			return replacement;
		}

		public bool Release()
		{
			return --_useCount == 0;
		}
	}

	private readonly IMaterialReplacer _replacer;

	private readonly Action<Material> _applyParameters;

	private readonly List<MaterialOverride> _overrides = new List<MaterialOverride>();

	public MaterialReplacements(IMaterialReplacer replacer, Action<Material> applyParameters)
	{
		_replacer = replacer;
		_applyParameters = applyParameters;
	}

	public Material Get(Material original)
	{
		for (int i = 0; i < _overrides.Count; i++)
		{
			MaterialOverride materialOverride = _overrides[i];
			if ((object)materialOverride.original == original)
			{
				Material material = materialOverride.Get();
				if ((bool)material && (object)material != original)
				{
					material.CopyPropertiesFromMaterial(original);
					_applyParameters(material);
				}
				return material;
			}
		}
		Material material2 = _replacer.Replace(original);
		if ((bool)material2)
		{
			_applyParameters(material2);
		}
		_overrides.Add(new MaterialOverride(original, material2));
		return material2;
	}

	public void Release(Material replacement)
	{
		for (int i = 0; i < _overrides.Count; i++)
		{
			MaterialOverride materialOverride = _overrides[i];
			if (materialOverride.replacement == replacement && materialOverride.Release())
			{
				_overrides.RemoveAt(i);
				break;
			}
		}
	}

	public void ApplyAll()
	{
		for (int i = 0; i < _overrides.Count; i++)
		{
			Material replacement = _overrides[i].replacement;
			if ((bool)replacement)
			{
				_applyParameters(replacement);
			}
		}
	}

	public void DestroyAllAndClear()
	{
		_overrides.Clear();
	}
}
