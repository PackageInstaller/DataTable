using System.Collections.Generic;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

public sealed class UnityReferenceResolver : IExternalIndexReferenceResolver, ICacheNotificationReceiver
{
	private Dictionary<Object, int> referenceIndexMapping = new Dictionary<Object, int>(32, ReferenceEqualityComparer<Object>.Default);

	private List<Object> referencedUnityObjects;

	public UnityReferenceResolver()
	{
		referencedUnityObjects = new List<Object>();
	}

	public UnityReferenceResolver(List<Object> referencedUnityObjects)
	{
		SetReferencedUnityObjects(referencedUnityObjects);
	}

	public List<Object> GetReferencedUnityObjects()
	{
		return referencedUnityObjects;
	}

	public void SetReferencedUnityObjects(List<Object> referencedUnityObjects)
	{
		if (referencedUnityObjects == null)
		{
			referencedUnityObjects = new List<Object>();
		}
		this.referencedUnityObjects = referencedUnityObjects;
		referenceIndexMapping.Clear();
		for (int i = 0; i < this.referencedUnityObjects.Count; i++)
		{
			if ((object)this.referencedUnityObjects[i] != null && !referenceIndexMapping.ContainsKey(this.referencedUnityObjects[i]))
			{
				referenceIndexMapping.Add(this.referencedUnityObjects[i], i);
			}
		}
	}

	public bool CanReference(object value, out int index)
	{
		if (referencedUnityObjects == null)
		{
			referencedUnityObjects = new List<Object>(32);
		}
		if (value is Object obj)
		{
			if (!referenceIndexMapping.TryGetValue(obj, out index))
			{
				index = referencedUnityObjects.Count;
				referenceIndexMapping.Add(obj, index);
				referencedUnityObjects.Add(obj);
			}
			return true;
		}
		index = -1;
		return false;
	}

	public bool TryResolveReference(int index, out object value)
	{
		if (referencedUnityObjects == null || index < 0 || index >= referencedUnityObjects.Count)
		{
			value = null;
			return true;
		}
		value = referencedUnityObjects[index];
		return true;
	}

	public void Reset()
	{
		referencedUnityObjects = null;
		referenceIndexMapping.Clear();
	}

	void ICacheNotificationReceiver.OnFreed()
	{
		Reset();
	}

	void ICacheNotificationReceiver.OnClaimed()
	{
	}
}
