using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[Serializable]
public struct SerializationData
{
	[SerializeField]
	private string _json;

	[SerializeField]
	private UnityEngine.Object[] _objectReferences;

	public string json => _json;

	public UnityEngine.Object[] objectReferences => _objectReferences;

	public SerializationData(string json, IEnumerable<UnityEngine.Object> objectReferences)
	{
		_json = json;
		_objectReferences = objectReferences?.ToArray() ?? Empty<UnityEngine.Object>.array;
	}

	public SerializationData(string json, params UnityEngine.Object[] objectReferences)
		: this(json, (IEnumerable<UnityEngine.Object>)objectReferences)
	{
	}

	internal void Clear()
	{
		_json = null;
		_objectReferences = null;
	}

	public string ToString(string title)
	{
		using StringWriter stringWriter = new StringWriter();
		if (!string.IsNullOrEmpty(title))
		{
			stringWriter.WriteLine(title);
			stringWriter.WriteLine();
		}
		stringWriter.WriteLine("Object References: ");
		if (objectReferences.Length == 0)
		{
			stringWriter.WriteLine("(None)");
		}
		else
		{
			int num = 0;
			UnityEngine.Object[] array = objectReferences;
			foreach (UnityEngine.Object obj in array)
			{
				if (obj.IsUnityNull())
				{
					stringWriter.WriteLine($"{num}: null");
				}
				else if (UnityThread.allowsAPI)
				{
					stringWriter.WriteLine($"{num}: {obj.GetType().FullName} [{obj.GetHashCode()}] \"{obj.name}\"");
				}
				else
				{
					stringWriter.WriteLine($"{num}: {obj.GetType().FullName} [{obj.GetHashCode()}]");
				}
				num++;
			}
		}
		stringWriter.WriteLine();
		stringWriter.WriteLine("JSON: ");
		stringWriter.WriteLine(Serialization.PrettyPrint(json));
		return stringWriter.ToString();
	}

	public override string ToString()
	{
		return ToString(null);
	}

	public void ShowString(string title = null)
	{
		string text = Path.GetTempPath() + Guid.NewGuid().ToString() + ".json";
		File.WriteAllText(text, ToString(title));
		Process.Start(text);
	}
}
