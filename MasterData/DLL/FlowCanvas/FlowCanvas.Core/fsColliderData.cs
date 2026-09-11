using LitJson;
using UnityEngine;

namespace FlowCanvas.Core;

public abstract class fsColliderData : IJsonFormater
{
	public string name { get; private set; }

	public string typeName { get; private set; }

	public int layer { get; private set; }

	public Vector3 position { get; private set; }

	public Vector3 forward { get; private set; }

	public fsColliderData()
	{
	}

	public virtual void ReadFromJson(JsonData jd)
	{
		name = jd.get_Item("go").ToString();
		typeName = jd.get_Item("type").ToString();
		layer = int.Parse(jd.get_Item("layer").ToString());
		position = ParseToVector3(jd.get_Item("position").ToString());
		forward = ParseToVector3(jd.get_Item("forward").ToString());
	}

	public virtual void WriteToJson(JsonWriter jw, Collider col)
	{
		jw.WritePropertyName("go");
		jw.Write(col.gameObject.name);
		jw.WritePropertyName("type");
		jw.Write(col.GetType().Name);
		jw.WritePropertyName("layer");
		jw.Write(col.gameObject.layer);
		jw.WritePropertyName("position");
		jw.Write($"{col.transform.position.x},{col.transform.position.y},{col.transform.position.z}");
		jw.WritePropertyName("forward");
		jw.Write($"{col.transform.forward.x},{col.transform.forward.y},{col.transform.forward.z}");
	}

	public static fsColliderData New(Collider source)
	{
		fsColliderData fsColliderData2 = null;
		if (source is BoxCollider)
		{
			fsColliderData2 = new fsBoxColliderData();
		}
		else if (source is SphereCollider)
		{
			fsColliderData2 = new fsSphereColliderData();
		}
		else if (source is CapsuleCollider)
		{
			fsColliderData2 = new fsCapsuleColliderData();
		}
		if (fsColliderData2 == null)
		{
			Debug.LogError($"{source.GetType()} 未定义Data类");
		}
		return fsColliderData2;
	}

	public static fsColliderData New(string type)
	{
		fsColliderData fsColliderData2 = null;
		switch (type)
		{
		case "BoxCollider":
			fsColliderData2 = new fsBoxColliderData();
			break;
		case "SphereCollider":
			fsColliderData2 = new fsSphereColliderData();
			break;
		case "CapsuleCollider":
			fsColliderData2 = new fsCapsuleColliderData();
			break;
		}
		if (fsColliderData2 == null)
		{
			Debug.LogError(type + " 未定义Data类");
		}
		return fsColliderData2;
	}

	public static Vector3 ParseToVector3(string str)
	{
		Vector3 zero = Vector3.zero;
		string[] array = str.Split(',');
		zero.x = float.Parse(array[0]);
		zero.y = float.Parse(array[1]);
		zero.z = float.Parse(array[2]);
		return zero;
	}
}
