using System;

namespace GameFramework.Runtime;

[Serializable]
public class ObjectSourceDescription : SourceDescription
{
	private Path path;

	public virtual Path Path
	{
		get
		{
			return path;
		}
		set
		{
			path = value;
			if (path != null)
			{
				IsStatic = path.IsStatic;
			}
		}
	}

	public ObjectSourceDescription()
	{
		IsStatic = false;
	}

	public override string ToString()
	{
		return (path == null) ? "Path:null" : ("Path:" + path.ToString());
	}
}
