using System;
using ES3Internal;
using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public abstract class ES3ComponentType : ES3UnityObjectType
{
	protected const string gameObjectPropertyName = "goID";

	public ES3ComponentType(Type type)
		: base(type)
	{
	}

	protected abstract void WriteComponent(object obj, ES3Writer writer);

	protected abstract void ReadComponent<T>(ES3Reader reader, object obj);

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		Component component = obj as Component;
		if (obj != null && component == null)
		{
			throw new ArgumentException("Only types of UnityEngine.Component can be written with this method, but argument given is type of " + obj.GetType());
		}
		ES3ReferenceMgrBase current = ES3ReferenceMgrBase.Current;
		if (current != null)
		{
			writer.WriteProperty("goID", current.Add(component.gameObject).ToString(), ES3Type_string.Instance);
		}
		WriteComponent(component, writer);
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		ReadComponent<T>(reader, obj);
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		throw new NotImplementedException();
	}

	protected override object ReadObject<T>(ES3Reader reader)
	{
		ES3ReferenceMgrBase current = ES3ReferenceMgrBase.Current;
		long id = -1L;
		UnityEngine.Object obj = null;
		foreach (string property in reader.Properties)
		{
			if (property == "_ES3Ref")
			{
				id = reader.Read_ref();
				obj = current.Get(id, suppressWarnings: true);
				continue;
			}
			if (property == "goID")
			{
				long id2 = reader.Read_ref();
				if (!(obj != null))
				{
					GameObject gameObject = (GameObject)current.Get(id2, type);
					if (gameObject == null)
					{
						gameObject = new GameObject("Easy Save 3 Loaded GameObject");
						current.Add(gameObject, id2);
					}
					obj = GetOrAddComponent(gameObject, type);
					current.Add(obj, id);
				}
			}
			else
			{
				reader.overridePropertiesName = property;
				if (obj == null)
				{
					GameObject gameObject2 = new GameObject("Easy Save 3 Loaded GameObject");
					obj = GetOrAddComponent(gameObject2, type);
					current.Add(obj, id);
					current.Add(gameObject2);
				}
			}
			break;
		}
		if (obj != null)
		{
			ReadComponent<T>(reader, obj);
		}
		return obj;
	}

	private static Component GetOrAddComponent(GameObject go, Type type)
	{
		Component component = go.GetComponent(type);
		if (component != null)
		{
			return component;
		}
		return go.AddComponent(type);
	}

	public static Component CreateComponent(Type type)
	{
		GameObject gameObject = new GameObject("Easy Save 3 Loaded Component");
		if (type == typeof(Transform))
		{
			return gameObject.GetComponent(type);
		}
		return GetOrAddComponent(gameObject, type);
	}
}
