using System.Collections;
using System.Collections.Specialized;
using UnityEngine.Scripting;

namespace Unity.VisualScripting;

public sealed class AotDictionary : OrderedDictionary
{
	public AotDictionary()
	{
	}

	public AotDictionary(IEqualityComparer comparer)
		: base(comparer)
	{
	}

	public AotDictionary(int capacity)
		: base(capacity)
	{
	}

	public AotDictionary(int capacity, IEqualityComparer comparer)
		: base(capacity, comparer)
	{
	}

	[Preserve]
	public static void AotStubs()
	{
		AotDictionary aotDictionary = new AotDictionary();
		aotDictionary.Add(null, null);
		aotDictionary.Remove(null);
		_ = aotDictionary[null];
		aotDictionary[null] = null;
		aotDictionary.Contains(null);
		aotDictionary.Clear();
		_ = aotDictionary.Count;
	}
}
