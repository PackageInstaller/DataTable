using System;
using System.Collections;

namespace Unity.VisualScripting;

public sealed class DictionaryCloner : Cloner<IDictionary>
{
	public override bool Handles(Type type)
	{
		return typeof(IDictionary).IsAssignableFrom(type);
	}

	public override void FillClone(Type type, ref IDictionary clone, IDictionary original, CloningContext context)
	{
		IDictionaryEnumerator enumerator = original.GetEnumerator();
		while (enumerator.MoveNext())
		{
			object key = enumerator.Key;
			object value = enumerator.Value;
			object key2 = Cloning.Clone(context, key);
			object value2 = Cloning.Clone(context, value);
			clone.Add(key2, value2);
		}
	}
}
