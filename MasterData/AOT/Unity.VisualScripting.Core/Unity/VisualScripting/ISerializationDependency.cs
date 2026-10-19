using UnityEngine;

namespace Unity.VisualScripting;

public interface ISerializationDependency : ISerializationCallbackReceiver
{
	internal bool IsDeserialized { get; set; }
}
