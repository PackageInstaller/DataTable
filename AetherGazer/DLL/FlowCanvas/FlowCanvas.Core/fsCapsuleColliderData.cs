using LitJson;
using UnityEngine;

namespace FlowCanvas.Core;

public class fsCapsuleColliderData : fsColliderData
{
	public Vector3 center { get; private set; }

	public float height { get; private set; }

	public float radius { get; private set; }

	public override void ReadFromJson(JsonData jd)
	{
		base.ReadFromJson(jd);
		JsonData jsonData = jd.get_Item("collider");
		center = fsColliderData.ParseToVector3(jsonData.get_Item("center").ToString());
		height = float.Parse(jsonData.get_Item("height").ToString());
		radius = float.Parse(jsonData.get_Item("radius").ToString());
	}

	public override void WriteToJson(JsonWriter jw, Collider source)
	{
		CapsuleCollider capsuleCollider = source as CapsuleCollider;
		jw.WriteObjectStart();
		base.WriteToJson(jw, source);
		jw.WritePropertyName("collider");
		jw.WriteObjectStart();
		jw.WritePropertyName("center");
		jw.Write($"{capsuleCollider.center.x},{capsuleCollider.center.y},{capsuleCollider.center.z}");
		jw.WritePropertyName("height");
		jw.Write($"{capsuleCollider.height}");
		jw.WritePropertyName("radius");
		jw.Write($"{capsuleCollider.radius}");
		jw.WriteObjectEnd();
		jw.WriteObjectEnd();
	}
}
