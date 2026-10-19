using System;

namespace Sirenix.OdinInspector;

[Flags]
public enum PrefabKind
{
	None = 0,
	InstanceInScene = 1,
	InstanceInPrefab = 2,
	Regular = 4,
	Variant = 8,
	NonPrefabInstance = 0x10,
	PrefabInstance = InstanceInScene | InstanceInPrefab,
	PrefabAsset = Regular | Variant,
	PrefabInstanceAndNonPrefabInstance = PrefabInstance | NonPrefabInstance,
	All = PrefabInstanceAndNonPrefabInstance | PrefabAsset
}
