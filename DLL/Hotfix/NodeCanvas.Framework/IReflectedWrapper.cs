using ParadoxNotion.Serialization;

namespace NodeCanvas.Framework;

public interface IReflectedWrapper
{
	ISerializedReflectedInfo GetSerializedInfo();
}
