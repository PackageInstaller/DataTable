using System;

namespace UnityEngine.Localization.Tables;

[Serializable]
public struct TableEntryReference : ISerializationCallbackReceiver, IEquatable<TableEntryReference>
{
	public enum Type
	{
		Empty,
		Name,
		Id
	}

	[SerializeField]
	private long m_KeyId;

	[SerializeField]
	private string m_Key;

	private bool m_Valid;

	public Type ReferenceType { get; private set; }

	public long KeyId
	{
		get
		{
			return m_KeyId;
		}
		private set
		{
			m_KeyId = value;
		}
	}

	public string Key
	{
		get
		{
			return m_Key;
		}
		private set
		{
			m_Key = value;
		}
	}

	public static implicit operator TableEntryReference(LocalizationCommonData.CommonString keyId)
	{
		return new TableEntryReference
		{
			KeyId = (long)keyId,
			ReferenceType = Type.Id
		};
	}

	public static implicit operator LocalizationCommonData.CommonString(TableEntryReference reference)
	{
		return (LocalizationCommonData.CommonString)reference.KeyId;
	}

	public static bool operator ==(TableEntryReference left, LocalizationCommonData.CommonString right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(TableEntryReference left, LocalizationCommonData.CommonString right)
	{
		return !left.Equals(right);
	}

	public bool Equals(LocalizationCommonData.CommonString other)
	{
		return KeyId == (long)other;
	}

	public static implicit operator TableEntryReference(string key)
	{
		if (!string.IsNullOrWhiteSpace(key))
		{
			return new TableEntryReference
			{
				Key = key,
				ReferenceType = Type.Name
			};
		}
		return default;
	}

	public static implicit operator TableEntryReference(long keyId)
	{
		if (keyId != 0L)
		{
			return new TableEntryReference
			{
				KeyId = keyId,
				ReferenceType = Type.Id
			};
		}
		return default;
	}

	public static implicit operator string(TableEntryReference tableEntryReference)
	{
		return tableEntryReference.Key;
	}

	public static implicit operator long(TableEntryReference tableEntryReference)
	{
		return tableEntryReference.KeyId;
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
			throw new ArgumentException("Empty Table Entry Reference. Must contain a Name or Key Id");
		case Type.Name:
			if (string.IsNullOrWhiteSpace(Key))
			{
				throw new ArgumentException("Must use a valid Key, can not be null or Empty.");
			}
			break;
		case Type.Id:
			if (KeyId == 0L)
			{
				throw new ArgumentException("Key Id can not be empty.");
			}
			break;
		}
		m_Valid = true;
	}

	public string ResolveKeyName(SharedTableData sharedData)
	{
		if (ReferenceType == Type.Name)
		{
			return Key;
		}
		if (ReferenceType == Type.Id)
		{
			if (!(sharedData != null))
			{
				return $"Key Id {KeyId}";
			}
			return sharedData.GetKey(KeyId);
		}
		return null;
	}

	public override string ToString()
	{
		return ReferenceType switch
		{
			Type.Name => "TableEntryReference(" + Key + ")", 
			Type.Id => string.Format("{0}({1})", "TableEntryReference", KeyId), 
			_ => "TableEntryReference(Empty)", 
		};
	}

	public string ToString(TableReference tableReference)
	{
		SharedTableData sharedTableData = tableReference.SharedTableData;
		if (sharedTableData != null)
		{
			string key;
			long num;
			if (ReferenceType == Type.Name)
			{
				key = Key;
				num = sharedTableData.GetId(key);
			}
			else
			{
				if (ReferenceType != Type.Id)
				{
					return ToString();
				}
				num = KeyId;
				key = sharedTableData.GetKey(num);
			}
			return string.Format("{0}({1} - {2})", "TableEntryReference", num, key);
		}
		return ToString();
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is TableEntryReference other)
		{
			return Equals(other);
		}
		return false;
	}

	public bool Equals(TableEntryReference other)
	{
		if (ReferenceType != other.ReferenceType)
		{
			return false;
		}
		if (ReferenceType == Type.Name)
		{
			return Key == other.Key;
		}
		if (ReferenceType == Type.Id)
		{
			return KeyId == other.KeyId;
		}
		return true;
	}

	public override int GetHashCode()
	{
		if (ReferenceType == Type.Name)
		{
			return Key.GetHashCode();
		}
		if (ReferenceType == Type.Id)
		{
			return KeyId.GetHashCode();
		}
		return base.GetHashCode();
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
		if (KeyId != 0L)
		{
			ReferenceType = Type.Id;
		}
		else if (string.IsNullOrEmpty(m_Key))
		{
			ReferenceType = Type.Empty;
		}
		else
		{
			ReferenceType = Type.Name;
		}
	}
}
