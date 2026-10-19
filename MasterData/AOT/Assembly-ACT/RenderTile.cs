using System;
using System.Collections.Generic;
using ACT_Instance;
using UnityEngine;

[ExecuteAlways]
public class RenderTile : MonoBehaviour
{
	[Serializable]
	public struct ArrayData
	{
		public Vector3 OffsetPosition;

		public Vector3 offsetRotation;

		public Vector3 localRotation;

		public Vector3 offsetScale;

		public Vector3 localScale;

		public int Count;
	}

	private DrawInstanceObject DrawObject;

	public DrawInstanceObject.InstanceObject InstanceObjects;

	public Vector3 originalOffset;

	public Vector3 originalSize = Vector3.one;

	private bool RenderShadow;

	public Mesh MeshToDraw;

	public Material MaterialToDraw;

	public List<ArrayData> ArrayList = new List<ArrayData>();

	private void OnEnable()
	{
		DrawObject = new DrawInstanceObject(InstanceObjects, cameraCull: true, VisiableCull: false);
		DrawObject.AddToRenderer();
	}

	private void Update()
	{
		if (InstanceObjects != null)
		{
			InstanceObjects.TransformMatrix = transform.localToWorldMatrix;
			InstanceObjects.bounds = GeometryUtility.CalculateBounds(getBoundCorner(InstanceObjects.LocalBounds), transform.localToWorldMatrix);
		}
	}

	private void CreateObject()
	{
		if (DrawObject != null)
		{
			DrawObject.RemoveFromRenderer();
		}
		UpdateData();
		DrawObject = new DrawInstanceObject(InstanceObjects, cameraCull: true, VisiableCull: false);
		DrawObject.AddToRenderer();
	}

	private Vector3[] getBoundCorner(Bounds bounds)
	{
		Vector3[] array = new Vector3[8];
		array[0] = bounds.center + bounds.extents;
		array[1] = bounds.center + new Vector3(0f - bounds.extents.x, bounds.extents.y, bounds.extents.z);
		array[2] = bounds.center + new Vector3(0f - bounds.extents.x, 0f - bounds.extents.y, bounds.extents.z);
		array[3] = bounds.center + new Vector3(0f - bounds.extents.x, bounds.extents.y, 0f - bounds.extents.z);
		array[4] = bounds.center + new Vector3(bounds.extents.x, 0f - bounds.extents.y, bounds.extents.z);
		array[5] = bounds.center + new Vector3(bounds.extents.x, 0f - bounds.extents.y, 0f - bounds.extents.z);
		array[5] = bounds.center + new Vector3(bounds.extents.x, bounds.extents.y, 0f - bounds.extents.z);
		array[7] = bounds.center - bounds.extents;
		return array;
	}

	private void UpdateData()
	{
		DrawInstanceObject.InstanceObject instanceObject = new DrawInstanceObject.InstanceObject();
		instanceObject.mesh = MeshToDraw;
		instanceObject.mat = MaterialToDraw;
		instanceObject.renderType = DrawInstanceObject.RenderType.GBuffer;
		instanceObject.renderShadow = RenderShadow;
		instanceObject.TransformMatrix = transform.localToWorldMatrix;
		InstanceObjects = instanceObject;
		Bounds bounds = new Bounds(transform.position, Vector3.zero);
		Matrix4x4 matrix4x = Matrix4x4.TRS(originalOffset, Quaternion.identity, originalSize);
		for (int i = 0; i < ArrayList.Count; i++)
		{
			ArrayData arrayData = ArrayList[i];
			if (i == 0)
			{
				Matrix4x4 matrix4x2 = Matrix4x4.TRS(arrayData.OffsetPosition, Quaternion.Euler(arrayData.offsetRotation), Vector3.one);
				Matrix4x4 matrix4x3 = Matrix4x4.Rotate(Quaternion.Euler(arrayData.localRotation));
				Matrix4x4 matrix4x4 = Matrix4x4.Scale(arrayData.localScale + Vector3.one);
				Bounds bounds2 = MeshToDraw.bounds;
				Vector3[] boundCorner = getBoundCorner(bounds2);
				Matrix4x4 matrix4x5 = Matrix4x4.identity;
				for (int j = 0; j < arrayData.Count; j++)
				{
					DrawInstanceObject.InstanceData item = default;
					if (j == 0)
					{
						matrix4x5 *= matrix4x;
					}
					if (j > 0)
					{
						matrix4x5 = matrix4x2 * matrix4x5 * matrix4x3 * matrix4x4;
					}
					item.LocalTransformMatrixs = matrix4x5;
					Bounds bounds3 = GeometryUtility.CalculateBounds(boundCorner, item.LocalTransformMatrixs);
					item.cullingBounds = new Vector4(bounds3.center.x, bounds3.center.y, bounds3.center.z, bounds3.extents.sqrMagnitude);
					bounds.Encapsulate(bounds3);
					instanceObject.instanceData.Add(item);
				}
				instanceObject.LocalBounds = bounds;
				instanceObject.bounds = GeometryUtility.CalculateBounds(getBoundCorner(bounds), transform.localToWorldMatrix);
				continue;
			}
			Matrix4x4 matrix4x6 = Matrix4x4.TRS(arrayData.OffsetPosition, Quaternion.Euler(arrayData.offsetRotation), Vector3.one);
			Matrix4x4 matrix4x7 = Matrix4x4.Scale(arrayData.localScale + Vector3.one);
			Bounds bounds4 = MeshToDraw.bounds;
			Vector3[] boundCorner2 = getBoundCorner(bounds4);
			int count = instanceObject.instanceData.Count;
			for (int k = 0; k < arrayData.Count; k++)
			{
				for (int l = 0; l < count; l++)
				{
					DrawInstanceObject.InstanceData instanceData = instanceObject.instanceData[l + k * count];
					DrawInstanceObject.InstanceData item2 = default;
					Vector3 vector = instanceData.LocalTransformMatrixs * new Vector4(0f, 0f, 0f, 1f);
					Vector3 vector2 = new Vector3(vector.x * arrayData.offsetScale.x, vector.y * arrayData.offsetScale.y, vector.z * arrayData.offsetScale.z);
					item2.LocalTransformMatrixs = matrix4x6 * Matrix4x4.Translate(vector2) * instanceData.LocalTransformMatrixs * matrix4x7;
					Bounds bounds5 = GeometryUtility.CalculateBounds(boundCorner2, item2.LocalTransformMatrixs);
					item2.cullingBounds = new Vector4(bounds5.center.x, bounds5.center.y, bounds5.center.z, bounds5.extents.magnitude);
					bounds.Encapsulate(bounds5);
					instanceObject.instanceData.Add(item2);
				}
			}
			instanceObject.LocalBounds = bounds;
			instanceObject.bounds = GeometryUtility.CalculateBounds(getBoundCorner(bounds), transform.localToWorldMatrix);
		}
	}

	private void OnDisable()
	{
		if (DrawObject != null)
		{
			DrawObject.RemoveFromRenderer();
		}
	}
}
