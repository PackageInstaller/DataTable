using System;
using System.Collections.Generic;
using System.ComponentModel;
using Sirenix.Serialization.Utilities;
using UnityEngine;

namespace Sirenix.Serialization;

[Serializable]
public struct SerializationData
{
	public const string PrefabModificationsReferencedUnityObjectsFieldName = "PrefabModificationsReferencedUnityObjects";

	public const string PrefabModificationsFieldName = "PrefabModifications";

	public const string PrefabFieldName = "Prefab";

	[SerializeField]
	public DataFormat SerializedFormat;

	[SerializeField]
	public byte[] SerializedBytes;

	[SerializeField]
	public List<UnityEngine.Object> ReferencedUnityObjects;

	[SerializeField]
	public string SerializedBytesString;

	[SerializeField]
	public UnityEngine.Object Prefab;

	[SerializeField]
	public List<UnityEngine.Object> PrefabModificationsReferencedUnityObjects;

	[SerializeField]
	public List<string> PrefabModifications;

	[SerializeField]
	public List<SerializationNode> SerializationNodes;

	[Obsolete("Use ContainsData instead")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool HasEditorData
	{
		get
		{
			switch (SerializedFormat)
			{
			case DataFormat.Binary:
			case DataFormat.JSON:
				if (SerializedBytesString.IsNullOrWhitespace())
				{
					if (SerializedBytes != null)
					{
						return SerializedBytes.Length != 0;
					}
					return false;
				}
				return true;
			case DataFormat.Nodes:
				if (SerializationNodes != null)
				{
					return SerializationNodes.Count != 0;
				}
				return false;
			default:
				throw new NotImplementedException(SerializedFormat.ToString());
			}
		}
	}

	public bool ContainsData
	{
		get
		{
			if (SerializedBytes != null && SerializationNodes != null && PrefabModifications != null)
			{
				return ReferencedUnityObjects != null;
			}
			return false;
		}
	}

	public void Reset()
	{
		SerializedFormat = DataFormat.Binary;
		if (SerializedBytes != null && SerializedBytes.Length != 0)
		{
			SerializedBytes = new byte[0];
		}
		if (ReferencedUnityObjects != null && ReferencedUnityObjects.Count > 0)
		{
			ReferencedUnityObjects.Clear();
		}
		Prefab = null;
		if (SerializationNodes != null && SerializationNodes.Count > 0)
		{
			SerializationNodes.Clear();
		}
		if (SerializedBytesString != null && SerializedBytesString.Length > 0)
		{
			SerializedBytesString = string.Empty;
		}
		if (PrefabModificationsReferencedUnityObjects != null && PrefabModificationsReferencedUnityObjects.Count > 0)
		{
			PrefabModificationsReferencedUnityObjects.Clear();
		}
		if (PrefabModifications != null && PrefabModifications.Count > 0)
		{
			PrefabModifications.Clear();
		}
	}
}
