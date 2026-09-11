using System;

namespace UnityEngine;

internal struct EnumData
{
	public Enum[] values;

	public int[] flagValues;

	public string[] displayNames;

	public string[] names;

	public string[] tooltip;

	public bool flags;

	public Type underlyingType;

	public bool unsigned;

	public bool serializable;
}
