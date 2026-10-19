using System;
using ACT.Utility;
using Bamboo.Pool;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MonoCylinderLineRenderer : MonoBehaviour
{
	public MeshFilter meshFilter;

	public float radius;

	public Vector3[] positions = new Vector3[2];

	public bool useWorldSpace;

	private static ObjectPool<Mesh> _pool = new ObjectPool<Mesh>();

	private Mesh _mesh;

	private Vector3[] _vertices = Array.Empty<Vector3>();

	private int[] _triangles = Array.Empty<int>();

	private Vector2[] _uv = Array.Empty<Vector2>();

	private bool _dirty = true;

	private Matrix4x4 _parentMMatrix;

	public int numSegments = 20;

	private Bamboo.Pool.ArrayPool<Vector3> _Vector3ArrayPool => Bamboo.Pool.ArrayPool<Vector3>.Default;

	private Bamboo.Pool.ArrayPool<Vector2> _Vector2ArrayPool => Bamboo.Pool.ArrayPool<Vector2>.Default;

	private Bamboo.Pool.ArrayPool<int> _IntArrayPool => Bamboo.Pool.ArrayPool<int>.Default;

	public int positionCount
	{
		get
		{
			return positions.Length;
		}
		set
		{
			if (value != positions.Length)
			{
				positions = new Vector3[value];
			}
		}
	}

	private void Start()
	{
		if (_mesh != null)
		{
			OnDisable();
		}
		_mesh = _pool.Get();
	}

	private void OnDestroy()
	{
		OnDisable();
		if ((bool)_mesh)
		{
			_pool.Release(_mesh);
		}
		_mesh = null;
	}

	private void OnEnable()
	{
		_dirty = true;
	}

	private void OnDisable()
	{
		ClearMesh();
		if ((bool)_mesh)
		{
			_mesh.RecalculateNormals();
			_mesh.RecalculateBounds();
		}
	}

	private void Update()
	{
		if (_dirty)
		{
			DrawAllMesh();
			_dirty = false;
		}
	}

	private void ClearMesh()
	{
		if ((bool)_mesh)
		{
			_mesh.Clear();
			_mesh.vertices = null;
			_mesh.uv = null;
			_mesh.triangles = null;
		}
		_IntArrayPool.Recycle(_triangles);
		_Vector3ArrayPool.Recycle(_vertices);
		_Vector2ArrayPool.Recycle(_uv);
		_triangles = Array.Empty<int>();
		_vertices = Array.Empty<Vector3>();
		_uv = Array.Empty<Vector2>();
	}

	private void DrawMesh(Vector3 top, Vector3 bottom)
	{
		float magnitude = (top - bottom).magnitude;
		Vector3[] array = _Vector3ArrayPool.Get(numSegments * 2 + 2);
		int[] array2 = _IntArrayPool.Get(numSegments * 12);
		Vector2[] array3 = _Vector2ArrayPool.Get(array.Length);
		for (int i = 0; i < numSegments; i++)
		{
			float f = MathF.PI * 2f * (float)i / (float)numSegments;
			float x = Mathf.Cos(f) * radius;
			float z = Mathf.Sin(f) * radius;
			array[i] = new Vector3(x, magnitude, z);
			array[i + numSegments] = new Vector3(x, 0f, z);
			array3[i] = new Vector2(magnitude, (float)i / (float)numSegments);
			array3[i + numSegments] = new Vector2(0f, (float)i / (float)numSegments);
		}
		array[numSegments * 2] = new Vector3(0f, magnitude, 0f);
		array[numSegments * 2 + 1] = new Vector3(0f, 0f, 0f);
		for (int j = 0; j < numSegments; j++)
		{
			int num = (j + 1) % numSegments;
			array2[j * 6] = j;
			array2[j * 6 + 1] = numSegments * 2;
			array2[j * 6 + 2] = num;
			array2[j * 6 + 3] = j + numSegments;
			array2[j * 6 + 4] = num + numSegments;
			array2[j * 6 + 5] = numSegments * 2 + 1;
			int num2 = j * 6 + 6 * numSegments;
			array2[num2] = j;
			array2[num2 + 1] = num;
			array2[num2 + 2] = j + numSegments;
			array2[num2 + 3] = num;
			array2[num2 + 4] = num + numSegments;
			array2[num2 + 5] = j + numSegments;
		}
		Matrix4x4 matrix4x = Matrix4x4.TRS(bottom, Quaternion.FromToRotation(Vector3.up, (top - bottom).normalized), Vector3.one);
		if (useWorldSpace)
		{
			matrix4x = _parentMMatrix.inverse * matrix4x;
		}
		for (int k = 0; k < array.Length; k++)
		{
			array[k] = matrix4x * array[k].ToHomogeneousCoordinatesVector();
		}
		for (int l = 0; l < array2.Length; l++)
		{
			array2[l] += _vertices.Length;
		}
		Vector3[] vertices = _vertices;
		int[] triangles = _triangles;
		Vector2[] uv = _uv;
		_vertices = ConcatWithPool(vertices, array);
		_triangles = ConcatWithPool(triangles, array2);
		_uv = ConcatWithPool(uv, array3);
		_Vector3ArrayPool.Recycle(array);
		_Vector3ArrayPool.Recycle(vertices);
		_Vector2ArrayPool.Recycle(array3);
		_Vector2ArrayPool.Recycle(uv);
		_IntArrayPool.Recycle(array2);
		_IntArrayPool.Recycle(triangles);
	}

	private T[] ConcatWithPool<T>(T[] array1, T[] array2)
	{
		T[] array3 = Bamboo.Pool.ArrayPool<T>.Default.Get(array1.Length + array2.Length);
		for (int i = 0; i < array3.Length; i++)
		{
			array3[i] = ((i < array1.Length) ? array1[i] : array2[i - array1.Length]);
		}
		return array3;
	}

	public void DrawAllMesh()
	{
		if (isActiveAndEnabled)
		{
			Vector3[] array = positions;
			if (array == null || array.Length <= 1)
			{
				throw new Exception("至少要有两个点才能确定一个线段");
			}
			ClearMesh();
			_parentMMatrix = Matrix4x4.TRS(transform.position, transform.rotation, Vector3.one);
			for (int i = 0; i < positions.Length - 1; i++)
			{
				Vector3 bottom = positions[i];
				Vector3 top = positions[i + 1];
				DrawMesh(top, bottom);
			}
			_mesh.vertices = _vertices;
			_mesh.triangles = _triangles;
			_mesh.uv = _uv;
			_mesh.RecalculateNormals();
			_mesh.RecalculateBounds();
			meshFilter.mesh = _mesh;
		}
	}

	public void SetPosition(int index, Vector3 position)
	{
		if (!positions[index].NearlyEqual(position))
		{
			positions[index] = position;
			_dirty = true;
		}
	}

	public void SetPositions(Vector3[] positions)
	{
		bool flag = this.positions.Length == positions.Length;
		int num = 0;
		while (flag && num < positions.Length)
		{
			if (!positions[num].NearlyEqual(this.positions[num]))
			{
				flag = false;
				break;
			}
			num++;
		}
		if (!flag)
		{
			this.positions = positions;
			_dirty = true;
		}
	}
}
