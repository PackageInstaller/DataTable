using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.API)]
public abstract class SignalSourceAsset : ScriptableObject, ISignalSource6D
{
	public abstract float SignalDuration { get; }

	public abstract void GetSignal(float timeSinceSignalStart, out Vector3 pos, out Quaternion rot);
}
