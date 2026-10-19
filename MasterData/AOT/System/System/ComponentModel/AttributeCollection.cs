using System.Collections;
using System.Reflection;

namespace System.ComponentModel;

public class AttributeCollection : ICollection, IEnumerable
{
	private struct AttributeEntry
	{
		public Type type;

		public int index;
	}

	public static readonly AttributeCollection Empty = new AttributeCollection((Attribute[])null);

	private static Hashtable s_defaultAttributes;

	private readonly Attribute[] _attributes;

	private static readonly object s_internalSyncObject = new object();

	private AttributeEntry[] _foundAttributeTypes;

	private int _index;

	protected virtual Attribute[] Attributes => _attributes;

	public int Count => Attributes.Length;

	public virtual Attribute this[Type attributeType]
	{
		get
		{
			lock (s_internalSyncObject)
			{
				if (_foundAttributeTypes == null)
				{
					_foundAttributeTypes = new AttributeEntry[5];
				}
				int i;
				for (i = 0; i < 5; i++)
				{
					if (_foundAttributeTypes[i].type == attributeType)
					{
						int index = _foundAttributeTypes[i].index;
						if (index != -1)
						{
							return Attributes[index];
						}
						return GetDefaultAttribute(attributeType);
					}
					if (_foundAttributeTypes[i].type == null)
					{
						break;
					}
				}
				i = _index++;
				if (_index >= 5)
				{
					_index = 0;
				}
				_foundAttributeTypes[i].type = attributeType;
				int num = Attributes.Length;
				for (int j = 0; j < num; j++)
				{
					Attribute attribute = Attributes[j];
					if (attribute.GetType() == attributeType)
					{
						_foundAttributeTypes[i].index = j;
						return attribute;
					}
				}
				for (int k = 0; k < num; k++)
				{
					Attribute attribute2 = Attributes[k];
					if (attributeType.IsInstanceOfType(attribute2))
					{
						_foundAttributeTypes[i].index = k;
						return attribute2;
					}
				}
				_foundAttributeTypes[i].index = -1;
				return GetDefaultAttribute(attributeType);
			}
		}
	}

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => null;

	int ICollection.Count => Count;

	public AttributeCollection(params Attribute[] attributes)
	{
		_attributes = attributes ?? Array.Empty<Attribute>();
		for (int i = 0; i < _attributes.Length; i++)
		{
			if (_attributes[i] == null)
			{
				throw new ArgumentNullException("attributes");
			}
		}
	}

	public bool Contains(Attribute attribute)
	{
		return this[attribute.GetType()]?.Equals(attribute) ?? false;
	}

	protected Attribute GetDefaultAttribute(Type attributeType)
	{
		lock (s_internalSyncObject)
		{
			if (s_defaultAttributes == null)
			{
				s_defaultAttributes = new Hashtable();
			}
			if (s_defaultAttributes.ContainsKey(attributeType))
			{
				return (Attribute)s_defaultAttributes[attributeType];
			}
			Attribute attribute = null;
			Type reflectionType = TypeDescriptor.GetReflectionType(attributeType);
			FieldInfo field = reflectionType.GetField("Default", BindingFlags.Static | BindingFlags.Public | BindingFlags.GetField);
			if (field != null && field.IsStatic)
			{
				attribute = (Attribute)field.GetValue(null);
			}
			else
			{
				ConstructorInfo constructor = reflectionType.UnderlyingSystemType.GetConstructor(Array.Empty<Type>());
				if (constructor != null)
				{
					attribute = (Attribute)constructor.Invoke(Array.Empty<object>());
					if (!attribute.IsDefaultAttribute())
					{
						attribute = null;
					}
				}
			}
			s_defaultAttributes[attributeType] = attribute;
			return attribute;
		}
	}

	public IEnumerator GetEnumerator()
	{
		return Attributes.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void CopyTo(Array array, int index)
	{
		Array.Copy(Attributes, 0, array, index, Attributes.Length);
	}
}
