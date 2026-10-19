using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class VariantKeyedCollection<TBase, TImplementation, TKey> : VariantCollection<TBase, TImplementation>, IKeyedCollection<TKey, TBase>, ICollection<TBase>, IEnumerable<TBase>, IEnumerable where TImplementation : TBase
{
	public TBase this[TKey key] => (TBase)(object)implementation[key];

	public new IKeyedCollection<TKey, TImplementation> implementation { get; private set; }

	TBase IKeyedCollection<TKey, TBase>.this[int index] => (TBase)(object)implementation[index];

	public VariantKeyedCollection(IKeyedCollection<TKey, TImplementation> implementation)
		: base((ICollection<TImplementation>)implementation)
	{
		this.implementation = implementation;
	}

	public bool TryGetValue(TKey key, out TBase value)
	{
		bool result = implementation.TryGetValue(key, out var value2);
		value = (TBase)(object)value2;
		return result;
	}

	public bool Contains(TKey key)
	{
		return implementation.Contains(key);
	}

	public bool Remove(TKey key)
	{
		return implementation.Remove(key);
	}
}
