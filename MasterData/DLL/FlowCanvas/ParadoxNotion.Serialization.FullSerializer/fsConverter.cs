using System;

namespace ParadoxNotion.Serialization.FullSerializer;

public abstract class fsConverter : fsBaseConverter
{
	public abstract bool CanProcess(Type type);
}
