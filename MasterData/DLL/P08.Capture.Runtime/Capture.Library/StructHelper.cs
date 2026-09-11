using UnityEngine;

namespace Capture.Library;

public static class StructHelper
{
	public static OBB GetOBBFromAABB(AABB aabb)
	{
		OBB result = new OBB
		{
			XAxis = Vector3.right,
			YAxis = Vector3.forward,
			ZAxis = Vector3.up
		};
		Vector3 vector = aabb.size / 2f;
		result.rect.P0 = new Vector4(aabb.center.x + vector.x, aabb.center.y + vector.y, aabb.center.z + vector.z, 1f);
		result.rect.P1 = new Vector4(aabb.center.x + (0f - vector.x), aabb.center.y + vector.y, aabb.center.z + vector.z, 1f);
		result.rect.P2 = new Vector4(aabb.center.x + vector.x, aabb.center.y + (0f - vector.y), aabb.center.z + vector.z, 1f);
		result.rect.P3 = new Vector4(aabb.center.x + vector.x, aabb.center.y + vector.y, aabb.center.z + (0f - vector.z), 1f);
		result.rect.P4 = new Vector4(aabb.center.x + (0f - vector.x), aabb.center.y + (0f - vector.y), aabb.center.z + vector.z, 1f);
		result.rect.P5 = new Vector4(aabb.center.x + (0f - vector.x), aabb.center.y + vector.y, aabb.center.z + (0f - vector.z), 1f);
		result.rect.P6 = new Vector4(aabb.center.x + (0f - vector.x), aabb.center.y + (0f - vector.y), aabb.center.z + (0f - vector.z), 1f);
		result.rect.P7 = new Vector4(aabb.center.x + vector.x, aabb.center.y + (0f - vector.y), aabb.center.z + (0f - vector.z), 1f);
		return result;
	}

	public static OBB GetOBBFromMeshFilter(MeshFilter mf)
	{
		OBB result = new OBB
		{
			XAxis = mf.transform.right,
			YAxis = mf.transform.forward,
			ZAxis = mf.transform.up
		};
		Vector3 vector = mf.mesh.bounds.size / 2f;
		Vector4 vector2 = new Vector4(mf.mesh.bounds.center.x, mf.mesh.bounds.center.y, mf.mesh.bounds.center.z, 0f);
		Matrix4x4 localToWorldMatrix = mf.transform.localToWorldMatrix;
		result.rect.P0 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, vector.z, 1f));
		result.rect.P1 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, vector.z, 1f));
		result.rect.P2 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P3 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P4 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P5 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P6 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 1f));
		result.rect.P7 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, 0f - vector.z, 1f));
		return result;
	}

	public static OBB GetOBBFromCharacterController(CharacterController cc)
	{
		OBB result = new OBB
		{
			XAxis = cc.transform.right,
			YAxis = cc.transform.forward,
			ZAxis = cc.transform.up
		};
		Vector3 vector = new Vector3(cc.radius, cc.height, cc.radius) / 2f;
		Vector4 vector2 = new Vector4(cc.center.x, cc.center.y, cc.center.z, 0f);
		Matrix4x4 localToWorldMatrix = cc.transform.localToWorldMatrix;
		result.rect.P0 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, vector.z, 1f));
		result.rect.P1 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, vector.z, 1f));
		result.rect.P2 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P3 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P4 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P5 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P6 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 1f));
		result.rect.P7 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, 0f - vector.z, 1f));
		return result;
	}

	public static OBB GetOBBFromCapsuleCollider(CapsuleCollider cc)
	{
		OBB result = new OBB
		{
			XAxis = cc.transform.right,
			YAxis = cc.transform.forward,
			ZAxis = cc.transform.up
		};
		Vector3 vector = new Vector3(cc.radius, cc.height, cc.radius) / 2f;
		Vector4 vector2 = new Vector4(cc.center.x, cc.center.y, cc.center.z, 0f);
		Matrix4x4 localToWorldMatrix = cc.transform.localToWorldMatrix;
		result.rect.P0 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, vector.z, 1f));
		result.rect.P1 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, vector.z, 1f));
		result.rect.P2 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P3 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P4 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P5 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P6 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 1f));
		result.rect.P7 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, 0f - vector.z, 1f));
		return result;
	}

	public static OBB GetOBBFromBoxCollider(BoxCollider cc)
	{
		OBB result = new OBB
		{
			XAxis = cc.transform.right,
			YAxis = cc.transform.forward,
			ZAxis = cc.transform.up
		};
		Vector3 vector = cc.size / 2f;
		Vector4 vector2 = cc.center;
		vector2.w = 0f;
		Matrix4x4 localToWorldMatrix = cc.transform.localToWorldMatrix;
		result.rect.P0 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, vector.z, 1f));
		result.rect.P1 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, vector.z, 1f));
		result.rect.P2 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P3 = localToWorldMatrix * (vector2 + new Vector4(vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P4 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, vector.z, 1f));
		result.rect.P5 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, vector.y, 0f - vector.z, 1f));
		result.rect.P6 = localToWorldMatrix * (vector2 + new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 1f));
		result.rect.P7 = localToWorldMatrix * (vector2 + new Vector4(vector.x, 0f - vector.y, 0f - vector.z, 1f));
		return result;
	}

	public static OBB GetOBBFromSkinedMeshRender(SkinnedMeshRenderer smr)
	{
		OBB result = new OBB
		{
			XAxis = smr.rootBone.transform.right,
			YAxis = smr.rootBone.transform.forward,
			ZAxis = smr.rootBone.transform.up
		};
		Bounds bounds = smr.bounds;
		Vector3 vector = bounds.size / 2f;
		Vector4 vector2 = new Vector4(bounds.center.x, bounds.center.y, bounds.center.z, 0f);
		result.rect.P0 = vector2 + new Vector4(vector.x, vector.y, vector.z, 1f);
		result.rect.P1 = vector2 + new Vector4(0f - vector.x, vector.y, vector.z, 1f);
		result.rect.P2 = vector2 + new Vector4(vector.x, 0f - vector.y, vector.z, 1f);
		result.rect.P3 = vector2 + new Vector4(vector.x, vector.y, 0f - vector.z, 1f);
		result.rect.P4 = vector2 + new Vector4(0f - vector.x, 0f - vector.y, vector.z, 1f);
		result.rect.P5 = vector2 + new Vector4(0f - vector.x, vector.y, 0f - vector.z, 1f);
		result.rect.P6 = vector2 + new Vector4(0f - vector.x, 0f - vector.y, 0f - vector.z, 1f);
		result.rect.P7 = vector2 + new Vector4(vector.x, 0f - vector.y, 0f - vector.z, 1f);
		return result;
	}

	public static AABB GetAABBFromBounds(Bounds bounds)
	{
		return new AABB
		{
			aabb = bounds
		};
	}

	public static Vector3 ConvertToProjection(this Vector3 vec)
	{
		Camera main = Camera.main;
		Vector4 vector = GL.GetGPUProjectionMatrix(main.projectionMatrix, renderIntoTexture: false) * main.worldToCameraMatrix * new Vector4(vec.x, vec.y, vec.z, 1f);
		return vector / vector.w;
	}

	public static Rect3D ConvertToProjection(this Rect3D rect)
	{
		Rect3D result = default(Rect3D);
		for (int i = 0; i < 8; i++)
		{
			result[i] = rect[i].ConvertToProjection();
		}
		return result;
	}
}
