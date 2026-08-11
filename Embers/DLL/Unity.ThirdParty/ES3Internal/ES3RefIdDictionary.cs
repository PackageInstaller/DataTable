using System;
using System.ComponentModel;
using UnityEngine;

namespace ES3Internal;

[Serializable]
[EditorBrowsable(EditorBrowsableState.Never)]
public class ES3RefIdDictionary : ES3SerializableDictionary<UnityEngine.Object, long>
{
	protected override bool KeysAreEqual(UnityEngine.Object a, UnityEngine.Object b)
	{
		return a == b;
	}

	protected override bool ValuesAreEqual(long a, long b)
	{
		return a == b;
	}
}
