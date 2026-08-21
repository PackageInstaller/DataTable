using System;

namespace Sirenix.OdinInspector;

public sealed class RequiredListLengthAttribute : Attribute
{
	private PrefabKind prefabKind;

	private bool prefabKindIsSet;

	private int minLength;

	private int maxLength;

	private bool minLengthIsSet;

	private bool maxLengthIsSet;

	public string MinLengthGetter;

	public string MaxLengthGetter;

	public int MinLength
	{
		get
		{
			return minLength;
		}
		set
		{
			minLength = value;
			minLengthIsSet = true;
		}
	}

	public int MaxLength
	{
		get
		{
			return maxLength;
		}
		set
		{
			maxLength = value;
			maxLengthIsSet = true;
		}
	}

	public bool MinLengthIsSet => minLengthIsSet;

	public bool MaxLengthIsSet => maxLengthIsSet;

	public bool PrefabKindIsSet => prefabKindIsSet;

	public PrefabKind PrefabKind
	{
		get
		{
			return prefabKind;
		}
		set
		{
			prefabKind = value;
			prefabKindIsSet = true;
		}
	}

	public RequiredListLengthAttribute()
	{
	}

	public RequiredListLengthAttribute(int fixedLength)
	{
		MinLength = fixedLength;
		MaxLength = fixedLength;
	}

	public RequiredListLengthAttribute(int minLength, int maxLength)
	{
		MinLength = minLength;
		MaxLength = maxLength;
	}

	public RequiredListLengthAttribute(int minLength, string maxLengthGetter)
	{
		MinLength = minLength;
		MaxLengthGetter = maxLengthGetter;
	}

	public RequiredListLengthAttribute(string fixedLengthGetter)
	{
		MinLengthGetter = fixedLengthGetter;
		MaxLengthGetter = fixedLengthGetter;
	}

	public RequiredListLengthAttribute(string minLengthGetter, string maxLengthGetter)
	{
		MinLengthGetter = minLengthGetter;
		MaxLengthGetter = maxLengthGetter;
	}

	public RequiredListLengthAttribute(string minLengthGetter, int maxLength)
	{
		MinLengthGetter = minLengthGetter;
		MaxLength = maxLength;
	}
}
