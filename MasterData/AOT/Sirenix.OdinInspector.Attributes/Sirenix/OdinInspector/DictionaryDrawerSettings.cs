using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
public sealed class DictionaryDrawerSettings : Attribute
{
	public string KeyLabel = "Key";

	public string ValueLabel = "Value";

	public DictionaryDisplayOptions DisplayMode;

	public bool IsReadOnly;

	public float KeyColumnWidth = 130f;
}
