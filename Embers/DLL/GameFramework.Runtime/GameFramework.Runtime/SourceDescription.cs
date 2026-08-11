using System;

namespace GameFramework.Runtime;

[Serializable]
public abstract class SourceDescription
{
	private bool isStatic = false;

	public virtual bool IsStatic
	{
		get
		{
			return isStatic;
		}
		set
		{
			isStatic = value;
		}
	}
}
