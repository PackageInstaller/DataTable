using System;

namespace Spine;

public abstract class Attachment
{
	public string Name { get; }

	protected Attachment(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name", "name cannot be null");
		}
		Name = name;
	}

	protected Attachment(Attachment other)
	{
		Name = other.Name;
	}

	public override string ToString()
	{
		return Name;
	}

	public abstract Attachment Copy();
}
