using LitJson;
using UnityEngine;

namespace FlowCanvas.Core;

public class fsSphereColliderData : fsColliderData
{
	public new string typeName { get; private set; }

	public Vector3 center { get; private set; }

	public float radius { get; private set; }

	public override void ReadFromJson(JsonData jd)
	{
		base.ReadFromJson(jd);
		JsonData jsonData = jd.get_Item("collider");
		center = fsColliderData.ParseToVector3(jsonData.get_Item("center").ToString());
		radius = float.Parse(jsonData.get_Item("radius").ToString());
	}

	public override void WriteToJson(JsonWriter jw, Collider col)
	{
		SphereCollider sphereCollider = col as SphereCollider;
		jw.WriteObjectStart();
		base.WriteToJson(jw, col);
		jw.WritePropertyName("collider");
		jw.WriteObjectStart();
		jw.WritePropertyName("center");
		jw.Write($"{sphereCollider.center.x},{sphereCollider.center.y},{sphereCollider.center.z}");
		jw.WritePropertyName("radius");
		jw.Write($"{sphereCollider.radius}");
		jw.WriteObjectEnd();
		jw.WriteObjectEnd();
	}
}
