using LitJson;
using UnityEngine;

namespace FlowCanvas.Core;

public class fsBoxColliderData : fsColliderData
{
	public Vector3 center { get; private set; }

	public Vector3 size { get; private set; }

	public override void ReadFromJson(JsonData jd)
	{
		base.ReadFromJson(jd);
		JsonData jsonData = jd.get_Item("collider");
		center = fsColliderData.ParseToVector3(jsonData.get_Item("center").ToString());
		size = fsColliderData.ParseToVector3(jsonData.get_Item("size").ToString());
	}

	public override void WriteToJson(JsonWriter jw, Collider source)
	{
		BoxCollider boxCollider = source as BoxCollider;
		jw.WriteObjectStart();
		base.WriteToJson(jw, source);
		jw.WritePropertyName("collider");
		jw.WriteObjectStart();
		jw.WritePropertyName("center");
		jw.Write($"{boxCollider.center.x},{boxCollider.center.y},{boxCollider.center.z}");
		jw.WritePropertyName("size");
		jw.Write($"{boxCollider.size.x},{boxCollider.size.y},{boxCollider.size.z}");
		jw.WriteObjectEnd();
		jw.WriteObjectEnd();
	}
}
