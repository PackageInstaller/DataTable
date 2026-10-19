using System;

namespace Unity.VisualScripting.FullSerializer;

public abstract class fsConverter : fsBaseConverter
{
	public abstract bool CanProcess(Type type);
}
