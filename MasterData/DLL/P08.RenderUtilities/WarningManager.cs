using UnityEngine;

[ExecuteInEditMode]
public class WarningManager : MonoBehaviour
{
	public enum Shape
	{
		Fanshape,
		Circle,
		Rectangle
	}

	[SerializeField]
	private Shape _Shape;

	[SerializeField]
	[Range(0f, 2f)]
	private float _Angle = 2f;

	[SerializeField]
	[Range(0f, 1f)]
	private float _Scale = 1f;

	[SerializeField]
	[Range(0f, 1f)]
	private float _InnerRadius;

	[SerializeField]
	[ColorUsage(true, true)]
	private Color _EdgeCOL;

	[SerializeField]
	[ColorUsage(true, true)]
	private Color _StaticCol;

	[SerializeField]
	[ColorUsage(true, true)]
	private Color _Color;

	[SerializeField]
	[Range(1f, 1000f)]
	private float _EdgeSmoothFactor = 27f;

	private MaterialPropertyBlock _propBlock;

	private int meshNum = 8;

	private int _PrevMeshNum = -1;

	private Mesh warningMesh;

	[SerializeField]
	private int[] originalMeshTriangles;

	[SerializeField]
	private Vector2[] originalMeshUV;

	[SerializeField]
	private Vector3[] originalMeshVert;

	[SerializeField]
	private bool ini;

	private Renderer renderer;

	public Shape shape
	{
		get
		{
			_ = _Shape;
			return _Shape;
		}
		set
		{
			_Shape = value;
		}
	}

	public float Angle
	{
		get
		{
			return Mathf.Clamp(_Angle, 0f, 2f);
		}
		set
		{
			_Angle = value;
		}
	}

	public float Scale
	{
		get
		{
			return Mathf.Clamp(_Scale, 1f, 15f);
		}
		set
		{
			_Scale = value;
		}
	}

	public Color EdgeCOL
	{
		get
		{
			return _EdgeCOL;
		}
		set
		{
			_EdgeCOL = value;
		}
	}

	public Color StaticCol
	{
		get
		{
			return _StaticCol;
		}
		set
		{
			_StaticCol = value;
		}
	}

	public Color Color
	{
		get
		{
			return _Color;
		}
		set
		{
			_Color = value;
		}
	}

	public float EdgeSmoothFactor
	{
		get
		{
			return _EdgeSmoothFactor;
		}
		set
		{
			_EdgeSmoothFactor = value;
		}
	}

	public float InnerRadius
	{
		get
		{
			return _InnerRadius;
		}
		set
		{
			_InnerRadius = value;
		}
	}

	public void Hide(bool hide)
	{
		if (renderer != null)
		{
			renderer.enabled = !hide;
		}
	}

	private void FanShapeFunction()
	{
		if (!ini)
		{
			warningMesh = GetComponent<MeshFilter>().sharedMesh;
			originalMeshVert = warningMesh.vertices;
			originalMeshUV = warningMesh.uv;
			originalMeshTriangles = warningMesh.triangles;
			ini = true;
		}
		if (warningMesh != null)
		{
			meshNum = (int)Mathf.Ceil(_Angle * 4f);
			meshNum = ((meshNum >= 0) ? meshNum : 0);
			meshNum = ((meshNum > originalMeshTriangles.Length / 3) ? (originalMeshTriangles.Length / 3) : meshNum);
			if (_PrevMeshNum != meshNum)
			{
				_PrevMeshNum = meshNum;
				int[] array = new int[meshNum * 3];
				for (int i = 0; i < meshNum * 3; i++)
				{
					array[i] = originalMeshTriangles[i];
				}
				warningMesh.SetIndices(array, MeshTopology.Triangles, 0);
			}
			_propBlock.SetFloat("_ValidAng", _Angle);
			_propBlock.SetFloat("_ValidAng", _Angle);
			_propBlock.SetFloat("_Scale", _Scale);
			_propBlock.SetColor("_StaticCol02", _EdgeCOL);
			_propBlock.SetColor("_StaticCol", _StaticCol);
			_propBlock.SetColor("_Color", _Color);
			_propBlock.SetFloat("_SmoothFactor", _EdgeSmoothFactor);
			_propBlock.SetFloat("_InnerRadius", _InnerRadius);
		}
		else if (ini)
		{
			warningMesh = new Mesh();
			warningMesh.vertices = originalMeshVert;
			warningMesh.uv = originalMeshUV;
			warningMesh.triangles = originalMeshTriangles;
			GetComponent<MeshFilter>().mesh = warningMesh;
		}
		else
		{
			warningMesh = GetComponent<MeshFilter>().sharedMesh;
		}
	}

	private void CircleFunction()
	{
		if (warningMesh != null)
		{
			_propBlock.SetFloat("_Scale", _Scale);
			_propBlock.SetFloat("_ValidAng", 2f);
			_propBlock.SetColor("_StaticCol02", _EdgeCOL);
			_propBlock.SetColor("_StaticCol", _StaticCol);
			_propBlock.SetColor("_Color", _Color);
			_propBlock.SetFloat("_SmoothFactor", _EdgeSmoothFactor);
			_propBlock.SetFloat("_InnerRadius", _InnerRadius);
		}
		else
		{
			warningMesh = GetComponent<MeshFilter>().sharedMesh;
			warningMesh.SetIndices(originalMeshTriangles, MeshTopology.Triangles, 0);
		}
	}

	private void RectangleFunction()
	{
		if (warningMesh != null)
		{
			_propBlock.SetFloat("_Scale", _Scale);
			_propBlock.SetFloat("_ValidAng", 2f);
			_propBlock.SetColor("_StaticCol02", _EdgeCOL);
			_propBlock.SetColor("_StaticCol", _StaticCol);
			_propBlock.SetColor("_Color", _Color);
			_propBlock.SetFloat("_SmoothFactor", _EdgeSmoothFactor);
			_propBlock.SetFloat("_InnerRadius", _InnerRadius);
		}
		else
		{
			warningMesh = GetComponent<MeshFilter>().sharedMesh;
		}
	}

	private void UpdateMaterials()
	{
		if (_propBlock == null)
		{
			_propBlock = new MaterialPropertyBlock();
		}
	}

	public void changeShape(Shape value)
	{
		if (null == renderer)
		{
			renderer = GetComponent<MeshRenderer>();
			if (renderer != null && !renderer.enabled)
			{
				renderer.enabled = true;
			}
		}
		shape = value;
		switch (value)
		{
		case Shape.Fanshape:
			renderer.sharedMaterial.EnableKeyword("WARNING_FANSHAPE");
			renderer.sharedMaterial.DisableKeyword("WARNING_CIRCLE");
			renderer.sharedMaterial.DisableKeyword("WARNING_RECTANGLE");
			break;
		case Shape.Circle:
			renderer.sharedMaterial.EnableKeyword("WARNING_CIRCLE");
			renderer.sharedMaterial.DisableKeyword("WARNING_RECTANGLE");
			renderer.sharedMaterial.DisableKeyword("WARNING_FANSHAPE");
			break;
		case Shape.Rectangle:
			renderer.sharedMaterial.EnableKeyword("WARNING_RECTANGLE");
			renderer.sharedMaterial.DisableKeyword("WARNING_CIRCLE");
			renderer.sharedMaterial.DisableKeyword("WARNING_FANSHAPE");
			break;
		}
	}

	private void Start()
	{
	}

	private void Update()
	{
		UpdateMaterials();
		if (shape == Shape.Fanshape)
		{
			FanShapeFunction();
		}
		else if (shape == Shape.Circle)
		{
			CircleFunction();
		}
		else if (shape == Shape.Rectangle)
		{
			RectangleFunction();
		}
		if (null == renderer)
		{
			renderer = GetComponent<MeshRenderer>();
		}
		renderer.SetPropertyBlock(_propBlock);
	}
}
