using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

[AddComponentMenu("Rendering/URP Water Tile Surface")]
[DisallowMultipleComponent]
[ExecuteAlways]
public sealed class WaterTileSurface : MonoBehaviour
{
	private const string k_TilePrefix = "__WaterTileSurface_Tile_";

	private const string k_LODRendererPrefix = "__WaterTileSurface_LOD_";

	private const int k_MaxLODCount = 3;

	private static readonly List<Transform> s_TilesToRemove = new List<Transform>(64);

	[SerializeField]
	private Vector2 m_Size = new Vector2(20f, 20f);

	[SerializeField]
	private float m_TileSize = 10f;

	[SerializeField]
	private int m_SubdivisionsPerTile = 16;

	[SerializeField]
	private float m_BoundsWaveHeight = 2f;

	[SerializeField]
	private bool m_EnableLOD = true;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float m_LOD0ScreenRelativeHeight = 0.55f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float m_LOD1ScreenRelativeHeight = 0.25f;

	[Range(0.01f, 1f)]
	[SerializeField]
	private float m_LOD2ScreenRelativeHeight = 0.08f;

	[Range(0.01f, 1f)]
	[SerializeField]
	private float m_LOD1SubdivisionScale = 0.5f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float m_LOD2SubdivisionScale = 0.25f;

	[SerializeField]
	private Material m_WaterMaterial;

	[SerializeField]
	private bool m_AutoRebuild = true;

	[SerializeField]
	private bool m_DrawGizmos = true;

	[SerializeField]
	private Color m_GizmoColor = new Color(0.2f, 0.75f, 1f, 0.75f);

	private readonly Mesh[] m_SharedLODMeshes = new Mesh[3];

	private readonly int[] m_SharedLODSubdivisions = new int[3];

	private readonly float[] m_SharedLODBoundsWaveHeights = new float[3];

	public Vector2 Size => m_Size;

	public float TileSize => m_TileSize;

	public int SubdivisionsPerTile => m_SubdivisionsPerTile;

	public float BoundsWaveHeight => m_BoundsWaveHeight;

	public bool EnableLOD => m_EnableLOD;

	public Material WaterMaterial => m_WaterMaterial;

	public bool DrawGizmos => m_DrawGizmos;

	public Color GizmoColor => m_GizmoColor;

	private void OnEnable()
	{
		ClampValues();
		RebuildTiles();
	}

	private void OnValidate()
	{
		ClampValues();
		if (isActiveAndEnabled && m_AutoRebuild)
		{
			RebuildTiles();
		}
	}

	private void OnDestroy()
	{
		ReleaseSharedMeshes();
	}

	private void ClampValues()
	{
		m_Size.x = Mathf.Max(0.01f, m_Size.x);
		m_Size.y = Mathf.Max(0.01f, m_Size.y);
		m_TileSize = Mathf.Max(0.01f, m_TileSize);
		m_SubdivisionsPerTile = Mathf.Clamp(m_SubdivisionsPerTile, 1, 128);
		m_BoundsWaveHeight = Mathf.Max(0.01f, m_BoundsWaveHeight);
		m_LOD0ScreenRelativeHeight = Mathf.Clamp(m_LOD0ScreenRelativeHeight, 0.01f, 1f);
		m_LOD1ScreenRelativeHeight = Mathf.Clamp(m_LOD1ScreenRelativeHeight, 0.01f, m_LOD0ScreenRelativeHeight);
		m_LOD2ScreenRelativeHeight = Mathf.Clamp(m_LOD2ScreenRelativeHeight, 0.01f, m_LOD1ScreenRelativeHeight);
		m_LOD1SubdivisionScale = Mathf.Clamp01(m_LOD1SubdivisionScale);
		m_LOD2SubdivisionScale = Mathf.Clamp01(m_LOD2SubdivisionScale);
	}

	public void SetSize(Vector2 size, bool rebuild)
	{
		m_Size = size;
		ClampValues();
		if (rebuild)
		{
			RebuildTiles();
		}
	}

	public void RebuildTiles()
	{
		ClampValues();
		ClearGeneratedTiles();
		int num = Mathf.Max(1, Mathf.CeilToInt(m_Size.x / m_TileSize));
		int num2 = Mathf.Max(1, Mathf.CeilToInt(m_Size.y / m_TileSize));
		float num3 = (0f - m_Size.x) * 0.5f;
		float num4 = (0f - m_Size.y) * 0.5f;
		for (int i = 0; i < num2; i++)
		{
			float num5 = num4 + (float)i * m_TileSize;
			float tileLength = Mathf.Min(m_TileSize, num4 + m_Size.y - num5);
			for (int j = 0; j < num; j++)
			{
				float num6 = num3 + (float)j * m_TileSize;
				float tileWidth = Mathf.Min(m_TileSize, num3 + m_Size.x - num6);
				CreateTile(j, i, num6, num5, tileWidth, tileLength);
			}
		}
	}

	public void ClearGeneratedTiles()
	{
		s_TilesToRemove.Clear();
		for (int num = transform.childCount - 1; num >= 0; num--)
		{
			Transform child = transform.GetChild(num);
			WaterTileSurfaceTile component = child.GetComponent<WaterTileSurfaceTile>();
			if ((component != null && component.Owner == this) || child.name.StartsWith("__WaterTileSurface_Tile_"))
			{
				s_TilesToRemove.Add(child);
			}
		}
		for (int i = 0; i < s_TilesToRemove.Count; i++)
		{
			DestroyTileObject(s_TilesToRemove[i].gameObject);
		}
		s_TilesToRemove.Clear();
	}

	private void CreateTile(int xIndex, int zIndex, float tileStartX, float tileStartZ, float tileWidth, float tileLength)
	{
		GameObject gameObject = new GameObject("__WaterTileSurface_Tile_" + xIndex + "_" + zIndex);
		gameObject.layer = base.gameObject.layer;
		gameObject.transform.SetParent(transform, worldPositionStays: false);
		gameObject.transform.localPosition = new Vector3(tileStartX + tileWidth * 0.5f, 0f, tileStartZ + tileLength * 0.5f);
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localScale = Vector3.one;
		gameObject.AddComponent<WaterTileSurfaceTile>().Initialize(this);
		MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
		MeshRenderer meshRenderer = gameObject.AddComponent<MeshRenderer>();
		meshRenderer.sharedMaterial = m_WaterMaterial;
		meshFilter.sharedMesh = GetSharedLODMesh(0);
		gameObject.transform.localScale = new Vector3(tileWidth, 1f, tileLength);
		if (m_EnableLOD)
		{
			CreateLODRenderers(gameObject, meshRenderer, meshFilter);
		}
	}

	private void CreateLODRenderers(GameObject tileObject, MeshRenderer rootRenderer, MeshFilter rootFilter)
	{
		rootRenderer.enabled = false;
		LODGroup lODGroup = tileObject.AddComponent<LODGroup>();
		LOD[] array = new LOD[3];
		for (int i = 0; i < 3; i++)
		{
			GameObject gameObject = new GameObject("__WaterTileSurface_LOD_" + i);
			gameObject.layer = tileObject.layer;
			gameObject.transform.SetParent(tileObject.transform, worldPositionStays: false);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = Vector3.one;
			MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
			MeshRenderer meshRenderer = gameObject.AddComponent<MeshRenderer>();
			meshFilter.sharedMesh = GetSharedLODMesh(i);
			meshRenderer.sharedMaterial = m_WaterMaterial;
			float screenRelativeTransitionHeight = i switch
			{
				1 => m_LOD1ScreenRelativeHeight, 
				0 => m_LOD0ScreenRelativeHeight, 
				_ => m_LOD2ScreenRelativeHeight, 
			};
			array[i] = new LOD(screenRelativeTransitionHeight, new Renderer[1] { meshRenderer });
		}
		rootFilter.sharedMesh = null;
		lODGroup.SetLODs(array);
		lODGroup.RecalculateBounds();
	}

	private Mesh GetSharedLODMesh(int lodIndex)
	{
		lodIndex = Mathf.Clamp(lodIndex, 0, 2);
		int lODSubdivisions = GetLODSubdivisions(lodIndex);
		Mesh mesh = m_SharedLODMeshes[lodIndex];
		if (mesh != null && m_SharedLODSubdivisions[lodIndex] == lODSubdivisions && Mathf.Approximately(m_SharedLODBoundsWaveHeights[lodIndex], m_BoundsWaveHeight))
		{
			return mesh;
		}
		DestroySharedMesh(lodIndex);
		mesh = BuildUnitTileMesh(lODSubdivisions);
		mesh.name = "Water Tile Shared LOD" + lodIndex + " Mesh";
		m_SharedLODMeshes[lodIndex] = mesh;
		m_SharedLODSubdivisions[lodIndex] = lODSubdivisions;
		m_SharedLODBoundsWaveHeights[lodIndex] = m_BoundsWaveHeight;
		return mesh;
	}

	private int GetLODSubdivisions(int lodIndex)
	{
		float num;
		switch (lodIndex)
		{
		case 0:
			return m_SubdivisionsPerTile;
		default:
			num = m_LOD2SubdivisionScale;
			break;
		case 1:
			num = m_LOD1SubdivisionScale;
			break;
		}
		float num2 = num;
		return Mathf.Clamp(Mathf.RoundToInt((float)m_SubdivisionsPerTile * num2), 1, m_SubdivisionsPerTile);
	}

	private Mesh BuildUnitTileMesh(int subdivisions)
	{
		int num = Mathf.Max(1, subdivisions);
		int num2 = Mathf.Max(1, subdivisions);
		int num3 = (num + 1) * (num2 + 1);
		Vector3[] array = new Vector3[num3];
		Vector3[] array2 = new Vector3[num3];
		Vector4[] array3 = new Vector4[num3];
		Vector2[] array4 = new Vector2[num3];
		int[] array5 = new int[num * num2 * 6];
		int num4 = 0;
		for (int i = 0; i <= num2; i++)
		{
			float num5 = (float)i / (float)num2;
			float z = num5 - 0.5f;
			for (int j = 0; j <= num; j++)
			{
				float num6 = (float)j / (float)num;
				float x = num6 - 0.5f;
				array[num4] = new Vector3(x, 0f, z);
				array2[num4] = Vector3.up;
				array3[num4] = new Vector4(1f, 0f, 0f, 1f);
				array4[num4] = new Vector2(num6, num5);
				num4++;
			}
		}
		int num7 = 0;
		int num8 = num + 1;
		for (int k = 0; k < num2; k++)
		{
			for (int l = 0; l < num; l++)
			{
				int num9 = k * num8 + l;
				int num10 = num9 + 1;
				int num11 = num9 + num8;
				int num12 = num11 + 1;
				array5[num7++] = num9;
				array5[num7++] = num11;
				array5[num7++] = num10;
				array5[num7++] = num10;
				array5[num7++] = num11;
				array5[num7++] = num12;
			}
		}
		Mesh mesh = new Mesh();
		mesh.name = "Water Tile Mesh";
		if (num3 > 65535)
		{
			mesh.indexFormat = IndexFormat.UInt32;
		}
		mesh.vertices = array;
		mesh.normals = array2;
		mesh.tangents = array3;
		mesh.uv = array4;
		mesh.triangles = array5;
		mesh.bounds = new Bounds(Vector3.zero, new Vector3(1f, m_BoundsWaveHeight * 2f, 1f));
		return mesh;
	}

	private void ReleaseSharedMeshes()
	{
		for (int i = 0; i < m_SharedLODMeshes.Length; i++)
		{
			DestroySharedMesh(i);
		}
	}

	private void DestroySharedMesh(int lodIndex)
	{
		Mesh mesh = m_SharedLODMeshes[lodIndex];
		if (!(mesh == null))
		{
			if (Application.isPlaying)
			{
				Object.Destroy(mesh);
			}
			else
			{
				Object.DestroyImmediate(mesh);
			}
			m_SharedLODMeshes[lodIndex] = null;
			m_SharedLODSubdivisions[lodIndex] = 0;
			m_SharedLODBoundsWaveHeights[lodIndex] = 0f;
		}
	}

	private static void DestroyTileObject(GameObject tileObject)
	{
		if (!(tileObject == null))
		{
			if (Application.isPlaying)
			{
				Object.Destroy(tileObject);
			}
			else
			{
				Object.DestroyImmediate(tileObject);
			}
		}
	}

	private void OnDrawGizmos()
	{
		if (m_DrawGizmos)
		{
			DrawTileGizmos();
		}
	}

	private void DrawTileGizmos()
	{
		ClampValues();
		Matrix4x4 matrix = Gizmos.matrix;
		Color color = Gizmos.color;
		Gizmos.matrix = transform.localToWorldMatrix;
		Gizmos.color = m_GizmoColor;
		float num = m_Size.x * 0.5f;
		float num2 = m_Size.y * 0.5f;
		Vector3 vector = new Vector3(0f - num, 0f, 0f - num2);
		Vector3 vector2 = new Vector3(num, 0f, 0f - num2);
		Vector3 vector3 = new Vector3(num, 0f, num2);
		Vector3 vector4 = new Vector3(0f - num, 0f, num2);
		Gizmos.DrawLine(vector, vector2);
		Gizmos.DrawLine(vector2, vector3);
		Gizmos.DrawLine(vector3, vector4);
		Gizmos.DrawLine(vector4, vector);
		int num3 = Mathf.Max(1, Mathf.CeilToInt(m_Size.x / m_TileSize));
		int num4 = Mathf.Max(1, Mathf.CeilToInt(m_Size.y / m_TileSize));
		for (int i = 1; i < num3; i++)
		{
			float x = 0f - num + (float)i * m_TileSize;
			Gizmos.DrawLine(new Vector3(x, 0f, 0f - num2), new Vector3(x, 0f, num2));
		}
		for (int j = 1; j < num4; j++)
		{
			float z = 0f - num2 + (float)j * m_TileSize;
			Gizmos.DrawLine(new Vector3(0f - num, 0f, z), new Vector3(num, 0f, z));
		}
		Gizmos.color = color;
		Gizmos.matrix = matrix;
	}
}
