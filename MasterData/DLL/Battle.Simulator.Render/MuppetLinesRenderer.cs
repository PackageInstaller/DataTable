using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

[RequireComponent(typeof(MeshRenderer))]
[RequireComponent(typeof(MeshFilter))]
public class MuppetLinesRenderer : MonoBehaviour
{
	public enum ELineAlignment
	{
		View,
		TranformZ
	}

	public class MuppetLine
	{
		public int offset;

		public List<Vector3> vertices;

		public List<Vector2> uvs;

		public List<int> triangles;

		public MuppetLine(List<Vector3> vertices, List<Vector2> uv, List<int> tris, int offset)
		{
			this.offset = offset;
			this.vertices = vertices;
			uvs = uv;
			triangles = tris;
			triangles.Add(4 * offset);
			triangles.Add(1 + 4 * offset);
			triangles.Add(3 + 4 * offset);
			triangles.Add(3 + 4 * offset);
			triangles.Add(1 + 4 * offset);
			triangles.Add(2 + 4 * offset);
		}

		public void Calc(Vector3 origin, Vector3 end, float width, Camera camera, ELineAlignment alignment, Transform root)
		{
			Vector3 vector = end - origin;
			Vector3 rhs = Vector3.forward;
			switch (alignment)
			{
			case ELineAlignment.View:
			{
				Vector3 vector2 = (end + origin) * 0.5f;
				rhs = (-camera.transform.position + vector2).normalized;
				break;
			}
			case ELineAlignment.TranformZ:
				rhs = -camera.transform.forward;
				break;
			}
			Vector3 normalized = Vector3.Cross(vector, rhs).normalized;
			Vector3 vector3 = origin + normalized * width * 0.5f;
			Vector3 vector4 = origin - normalized * width * 0.5f;
			Vector3 position = vector4 + vector;
			Vector3 position2 = vector3 + vector;
			vector3 = root.InverseTransformPoint(vector3);
			vector4 = root.InverseTransformPoint(vector4);
			position = root.InverseTransformPoint(position);
			position2 = root.InverseTransformPoint(position2);
			vertices.Add(vector3);
			vertices.Add(vector4);
			vertices.Add(position);
			vertices.Add(position2);
			uvs.Add(new Vector2(0f, 1f));
			uvs.Add(new Vector2(0f, 0f));
			uvs.Add(new Vector2(1f, 0f));
			uvs.Add(new Vector2(1f, 1f));
		}
	}

	public Transform[] mTargetPoints;

	public Transform[] mOriginPoints;

	private Mesh mDynMesh;

	private MeshRenderer mMeshRender;

	private MeshFilter mMeshFilter;

	public Material mMat;

	public float mWidth = 0.05f;

	private Camera mCam;

	public ELineAlignment mAlignment;

	private MuppetLine[] mLines;

	private bool mIsValid;

	private List<Vector3> mVertices = new List<Vector3>();

	private List<Vector2> mUVs = new List<Vector2>();

	private List<int> mTriangles = new List<int>();

	private void Start()
	{
		if (mDynMesh == null)
		{
			mDynMesh = new Mesh();
			mDynMesh.MarkDynamic();
		}
		mDynMesh.Clear();
		if (mMeshRender == null)
		{
			mMeshRender = GetComponent<MeshRenderer>();
			mMeshRender.sharedMaterial = mMat;
		}
		if (mMeshFilter == null)
		{
			mMeshFilter = GetComponent<MeshFilter>();
			mMeshFilter.mesh = mDynMesh;
		}
		if (mTargetPoints != null && mOriginPoints != null && mTargetPoints.Length != 0 && mOriginPoints.Length != 0 && mOriginPoints.Length == mTargetPoints.Length)
		{
			mIsValid = true;
			mLines = new MuppetLine[mOriginPoints.Length];
		}
		else
		{
			mIsValid = false;
			Debug.LogError("木偶提取线挂点错误！检查是起点和终点挂点数量是否一致");
		}
	}

	private void LateUpdate()
	{
		if (mIsValid)
		{
			mVertices.Clear();
			mUVs.Clear();
			for (int i = 0; i < mOriginPoints.Length; i++)
			{
				BuildQuad(i);
			}
			mDynMesh.SetVertices(mVertices);
			mDynMesh.SetUVs(0, mUVs);
			mDynMesh.SetTriangles(mTriangles, 0);
			mDynMesh.RecalculateBounds();
			mDynMesh.RecalculateNormals();
			mMeshFilter.sharedMesh = mDynMesh;
			mMeshRender.sharedMaterial = mMat;
		}
	}

	private void BuildQuad(int i)
	{
		MuppetLine muppetLine = mLines[i];
		if (muppetLine == null)
		{
			muppetLine = new MuppetLine(mVertices, mUVs, mTriangles, i);
			mLines[i] = muppetLine;
		}
		if (mCam == null)
		{
			CameraExtension cameraExtension = Object.FindObjectOfType<CameraExtension>();
			if (cameraExtension != null)
			{
				mCam = cameraExtension.GetComponent<Camera>();
			}
			if (mCam == null)
			{
				mCam = Camera.main;
			}
		}
		muppetLine.Calc(mOriginPoints[i].position, mTargetPoints[i].position, mWidth, mCam, mAlignment, base.transform);
	}

	private void OnDestroy()
	{
		if (mDynMesh != null)
		{
			Object.Destroy(mDynMesh);
			mDynMesh = null;
		}
	}
}
