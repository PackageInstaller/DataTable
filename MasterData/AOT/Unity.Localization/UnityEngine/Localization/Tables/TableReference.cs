using System;
using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.Serialization;

namespace UnityEngine.Localization.Tables;

[Serializable]
public struct TableReference : ISerializationCallbackReceiver, IEquatable<TableReference>
{
	public enum Type
	{
		Empty,
		Guid,
		Name
	}

	private static readonly Dictionary<Guid, string> s_GuidToStringCache = new Dictionary<Guid, string>();

	private static readonly Dictionary<string, Guid> s_StringToGuidCache = new Dictionary<string, Guid>();

	[FormerlySerializedAs("m_TableName")]
	[SerializeField]
	private string m_TableCollectionName;

	private bool m_Valid;

	private const string k_GuidTag = "GUID:";

	public Type ReferenceType { get; private set; }

	public Guid TableCollectionNameGuid { get; private set; }

	public string TableCollectionName
	{
		get
		{
			if (ReferenceType != Type.Name)
			{
				return SharedTableData?.TableCollectionName;
			}
			return m_TableCollectionName;
		}
		private set
		{
			m_TableCollectionName = value;
		}
	}

	public SharedTableData SharedTableData
	{
		get
		{
			if (ReferenceType == Type.Guid)
			{
				if (LocalizationSettings.StringDatabase != null && LocalizationSettings.StringDatabase.SharedTableDataOperations.TryGetValue(TableCollectionNameGuid, out var value))
				{
					return value.Result;
				}
				if (LocalizationSettings.AssetDatabase != null && LocalizationSettings.AssetDatabase.SharedTableDataOperations.TryGetValue(TableCollectionNameGuid, out value))
				{
					return value.Result;
				}
			}
			else if (ReferenceType == Type.Name)
			{
				foreach (KeyValuePair<Guid, AsyncOperationHandle<SharedTableData>> item in LocalizationSettings.StringDatabase?.SharedTableDataOperations)
				{
					if (item.Value.Result?.TableCollectionName == m_TableCollectionName)
					{
						return item.Value.Result;
					}
				}
				foreach (KeyValuePair<Guid, AsyncOperationHandle<SharedTableData>> item2 in LocalizationSettings.AssetDatabase?.SharedTableDataOperations)
				{
					if (item2.Value.Result?.TableCollectionName == m_TableCollectionName)
					{
						return item2.Value.Result;
					}
				}
			}
			return null;
		}
	}

	public static implicit operator TableReference(string tableCollectionName)
	{
		return new TableReference
		{
			TableCollectionName = tableCollectionName,
			ReferenceType = ((!string.IsNullOrWhiteSpace(tableCollectionName)) ? Type.Name : Type.Empty)
		};
	}

	public static implicit operator TableReference(Guid tableCollectionNameGuid)
	{
		return new TableReference
		{
			TableCollectionNameGuid = tableCollectionNameGuid,
			ReferenceType = ((!(tableCollectionNameGuid == Guid.Empty)) ? Type.Guid : Type.Empty)
		};
	}

	public static implicit operator string(TableReference tableReference)
	{
		return tableReference.TableCollectionName;
	}

	public static implicit operator Guid(TableReference tableReference)
	{
		return tableReference.TableCollectionNameGuid;
	}

	internal void Validate()
	{
		if (m_Valid)
		{
			return;
		}
		switch (ReferenceType)
		{
		case Type.Empty:
			throw new ArgumentException("Empty Table Reference. Must contain a Guid or Table Collection Name");
		case Type.Guid:
			if (TableCollectionNameGuid == Guid.Empty)
			{
				throw new ArgumentException("Must use a valid Table Collection Name Guid, can not be Empty.");
			}
			break;
		case Type.Name:
			if (string.IsNullOrWhiteSpace(TableCollectionName))
			{
				throw new ArgumentException("Table Collection Name can not be null or empty.");
			}
			break;
		}
		m_Valid = true;
	}

	internal string GetSerializedString()
	{
		if (ReferenceType == Type.Guid)
		{
			return "GUID:" + StringFromGuid(TableCollectionNameGuid);
		}
		return TableCollectionName;
	}

	public override string ToString()
	{
		if (ReferenceType == Type.Guid)
		{
			return string.Format("{0}({1} - {2})", "TableReference", TableCollectionNameGuid, TableCollectionName);
		}
		if (ReferenceType == Type.Name)
		{
			return "TableReference(" + TableCollectionName + ")";
		}
		return "TableReference(Empty)";
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is TableReference other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (ReferenceType == Type.Guid)
		{
			return TableCollectionNameGuid.GetHashCode();
		}
		if (ReferenceType == Type.Name)
		{
			return TableCollectionName.GetHashCode();
		}
		return base.GetHashCode();
	}

	public bool Equals(TableReference other)
	{
		if (ReferenceType != other.ReferenceType)
		{
			return false;
		}
		if (ReferenceType == Type.Guid)
		{
			return TableCollectionNameGuid == other.TableCollectionNameGuid;
		}
		if (ReferenceType == Type.Name)
		{
			return TableCollectionName == other.TableCollectionName;
		}
		return true;
	}

	internal static Guid GuidFromString(string value)
	{
		if (s_StringToGuidCache.TryGetValue(value, out var value2))
		{
			return value2;
		}
		Guid guid = Guid.Parse(value.Substring("GUID:".Length, value.Length - "GUID:".Length));
		s_StringToGuidCache[value] = guid;
		return guid;
	}

	internal static string StringFromGuid(Guid value)
	{
		if (s_GuidToStringCache.TryGetValue(value, out var value2))
		{
			return value2.ToString();
		}
		string text = value.ToString("N");
		s_GuidToStringCache[value] = text;
		return text;
	}

	internal static TableReference TableReferenceFromString(string value)
	{
		if (IsGuid(value))
		{
			return GuidFromString(value);
		}
		return value;
	}

	internal static bool IsGuid(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return false;
		}
		return value.StartsWith("GUID:", StringComparison.Ordinal);
	}

	public void OnBeforeSerialize()
	{
		m_TableCollectionName = GetSerializedString();
	}

	public void OnAfterDeserialize()
	{
		if (string.IsNullOrEmpty(m_TableCollectionName))
		{
			ReferenceType = Type.Empty;
		}
		else if (IsGuid(m_TableCollectionName))
		{
			TableCollectionNameGuid = GuidFromString(m_TableCollectionName);
			ReferenceType = Type.Guid;
			m_TableCollectionName = null;
		}
		else
		{
			ReferenceType = Type.Name;
		}
	}
}
