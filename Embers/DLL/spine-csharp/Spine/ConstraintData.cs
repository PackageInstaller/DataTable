using System;

namespace Spine;

public abstract class ConstraintData
{
	internal readonly string name;

	internal int order;

	internal bool skinRequired;

	public string Name => name;

	public int Order
	{
		get
		{
			return order;
		}
		set
		{
			order = value;
		}
	}

	public bool SkinRequired
	{
		get
		{
			return skinRequired;
		}
		set
		{
			skinRequired = value;
		}
	}

	public ConstraintData(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null.");
		}
		this.name = name;
	}

	public override string ToString()
	{
		return name;
	}
}
