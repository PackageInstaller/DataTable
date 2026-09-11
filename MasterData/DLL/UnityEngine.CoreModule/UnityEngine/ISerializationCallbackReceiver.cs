using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
public interface ISerializationCallbackReceiver
{
	[RequiredByNativeCode]
	void OnBeforeSerialize();

	[RequiredByNativeCode]
	void OnAfterDeserialize();
}
