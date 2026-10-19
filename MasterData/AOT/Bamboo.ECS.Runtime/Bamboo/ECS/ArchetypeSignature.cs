using System;

namespace Bamboo.ECS;

internal struct ArchetypeSignature : IEquatable<ArchetypeSignature>
{
	private enum SignatureMode : byte
	{
		Concrete,
		Added,
		Removed
	}

	private readonly ComponentTypeId[] _componentTypes;

	private readonly ComponentTypeId _deltaType;

	private readonly int _deltaIndex;

	private readonly int _componentCount;

	private readonly int _hashCode;

	private readonly SignatureMode _mode;

	public ComponentTypeId[] ComponentTypes => _componentTypes;

	public int ComponentCount => _componentCount;

	public ArchetypeSignature(ComponentTypeId[] componentTypes)
	{
		_componentTypes = componentTypes ?? Array.Empty<ComponentTypeId>();
		Array.Sort(_componentTypes, (ComponentTypeId a, ComponentTypeId b) => a.Id.CompareTo(b.Id));
		_deltaType = default;
		_deltaIndex = -1;
		_componentCount = _componentTypes.Length;
		_hashCode = ComputeHash(_componentTypes, _componentCount);
		_mode = SignatureMode.Concrete;
	}

	public ArchetypeSignature(ComponentTypeId[] componentTypes, ComponentTypeId deltaType, bool isAdd)
	{
		_componentTypes = componentTypes ?? Array.Empty<ComponentTypeId>();
		_deltaType = deltaType;
		_componentCount = (isAdd ? (_componentTypes.Length + 1) : (_componentTypes.Length - 1));
		_hashCode = (isAdd ? ComputeHashWithAdded(_componentTypes, deltaType) : ComputeHashWithRemoved(_componentTypes, deltaType));
		_deltaIndex = (isAdd ? FindAddInsertIndex(_componentTypes, deltaType) : FindRemoveIndex(_componentTypes, deltaType));
		_mode = (isAdd ? SignatureMode.Added : SignatureMode.Removed);
	}

	public static int ComputeHash(ComponentTypeId[] componentTypes, int length)
	{
		int num = 17;
		for (int i = 0; i < length; i++)
		{
			num = num * 31 + componentTypes[i].Id;
		}
		return num;
	}

	public static bool Matches(ComponentTypeId[] left, int leftLength, ComponentTypeId[] right)
	{
		if (right.Length != leftLength)
		{
			return false;
		}
		for (int i = 0; i < leftLength; i++)
		{
			if (left[i].Id != right[i].Id)
			{
				return false;
			}
		}
		return true;
	}

	public static int ComputeHashWithAdded(ComponentTypeId[] componentTypes, ComponentTypeId addedType)
	{
		int num = 17;
		bool flag = false;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (!flag && addedType.Id < componentTypes[i].Id)
			{
				num = num * 31 + addedType.Id;
				flag = true;
			}
			num = num * 31 + componentTypes[i].Id;
		}
		if (!flag)
		{
			num = num * 31 + addedType.Id;
		}
		return num;
	}

	public static int ComputeHashWithRemoved(ComponentTypeId[] componentTypes, ComponentTypeId removedType)
	{
		int num = 17;
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (componentTypes[i].Id != removedType.Id)
			{
				num = num * 31 + componentTypes[i].Id;
			}
		}
		return num;
	}

	public static bool MatchesWithAdded(ComponentTypeId[] candidateTypes, ComponentTypeId[] currentTypes, ComponentTypeId addedType)
	{
		if (candidateTypes.Length != currentTypes.Length + 1)
		{
			return false;
		}
		int num = 0;
		bool flag = false;
		for (int i = 0; i < candidateTypes.Length; i++)
		{
			int id = candidateTypes[i].Id;
			if (!flag && id == addedType.Id)
			{
				flag = true;
				continue;
			}
			if (num >= currentTypes.Length || id != currentTypes[num].Id)
			{
				return false;
			}
			num++;
		}
		if (flag)
		{
			return num == currentTypes.Length;
		}
		return false;
	}

	public static bool MatchesWithRemoved(ComponentTypeId[] candidateTypes, ComponentTypeId[] currentTypes, ComponentTypeId removedType)
	{
		if (candidateTypes.Length != currentTypes.Length - 1)
		{
			return false;
		}
		int num = 0;
		bool flag = false;
		for (int i = 0; i < currentTypes.Length; i++)
		{
			int id = currentTypes[i].Id;
			if (!flag && id == removedType.Id)
			{
				flag = true;
				continue;
			}
			if (num >= candidateTypes.Length || candidateTypes[num].Id != id)
			{
				return false;
			}
			num++;
		}
		if (flag)
		{
			return num == candidateTypes.Length;
		}
		return false;
	}

	public bool Equals(ArchetypeSignature other)
	{
		if (_componentCount != other._componentCount)
		{
			return false;
		}
		for (int i = 0; i < _componentCount; i++)
		{
			if (GetComponentTypeIdAt(i) != other.GetComponentTypeIdAt(i))
			{
				return false;
			}
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (obj is ArchetypeSignature other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _hashCode;
	}

	public static bool operator ==(ArchetypeSignature left, ArchetypeSignature right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(ArchetypeSignature left, ArchetypeSignature right)
	{
		return !left.Equals(right);
	}

	public override string ToString()
	{
		if (_componentCount == 0)
		{
			return "ArchetypeSignature[]";
		}
		string[] array = new string[_componentCount];
		for (int i = 0; i < _componentCount; i++)
		{
			ComponentTypeId id = new ComponentTypeId(GetComponentTypeIdAt(i));
			array[i] = ComponentTypeRegistry.GetType(id)?.Name ?? $"Unknown({id.Id})";
		}
		return "ArchetypeSignature[" + string.Join(", ", array) + "]";
	}

	private static int FindAddInsertIndex(ComponentTypeId[] componentTypes, ComponentTypeId addedType)
	{
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (addedType.Id < componentTypes[i].Id)
			{
				return i;
			}
		}
		return componentTypes.Length;
	}

	private static int FindRemoveIndex(ComponentTypeId[] componentTypes, ComponentTypeId removedType)
	{
		for (int i = 0; i < componentTypes.Length; i++)
		{
			if (componentTypes[i].Id == removedType.Id)
			{
				return i;
			}
		}
		return -1;
	}

	private int GetComponentTypeIdAt(int index)
	{
		switch (_mode)
		{
		case SignatureMode.Concrete:
			return _componentTypes[index].Id;
		case SignatureMode.Added:
			if (index < _deltaIndex)
			{
				return _componentTypes[index].Id;
			}
			if (index == _deltaIndex)
			{
				return _deltaType.Id;
			}
			return _componentTypes[index - 1].Id;
		case SignatureMode.Removed:
			if (index < _deltaIndex)
			{
				return _componentTypes[index].Id;
			}
			return _componentTypes[index + 1].Id;
		default:
			throw new InvalidOperationException($"Unknown signature mode: {_mode}");
		}
	}
}
