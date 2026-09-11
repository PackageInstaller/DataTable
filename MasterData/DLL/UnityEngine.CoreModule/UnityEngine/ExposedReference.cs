using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[UsedByNativeCode(Name = "ExposedReference")]
public struct ExposedReference<T> where T : Object
{
	[SerializeField]
	public PropertyName exposedName;

	[SerializeField]
	public Object defaultValue;

	public T Resolve(IExposedPropertyTable resolver)
	{
		if (resolver != null)
		{
			Object referenceValue = resolver.GetReferenceValue(exposedName, out var idValid);
			if (idValid)
			{
				return referenceValue as T;
			}
		}
		return defaultValue as T;
	}
}
