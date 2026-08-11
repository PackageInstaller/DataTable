using System;
using UnityEngine;

namespace ES3Internal;

[Serializable]
public class ES3IdRefDictionary : ES3SerializableDictionary<long, UnityEngine.Object>
{
	protected override bool KeysAreEqual(long a, long b)
	{
		return a == b;
	}

	protected override bool ValuesAreEqual(UnityEngine.Object a, UnityEngine.Object b)
	{
		return a == b;
	}
}
