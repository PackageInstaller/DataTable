using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class CurveTestScript : MonoBehaviour
{
	public List<GameObject> _CurvePoints = new List<GameObject>();

	public int MeshResolution = 4;

	public int CurveSubdivide = 4;

	public bool DoNotRefresh;

	[ColorUsage(true, true)]
	public Color color = Color.white;

	[Range(0f, 1f)]
	public float alpha = 1f;

	private ACTCurveRenderer _CurveRenderer;

	private ACTCurveRenderer.CurveData _CurveData;

	private void Start()
	{
		_CurveRenderer = gameObject.GetComponent<ACTCurveRenderer>();
		_CurveData = new ACTCurveRenderer.CurveData();
	}

	private void Update()
	{
		_CurveData.pointCount = _CurvePoints.Count;
		_CurveData.meshResolution = MeshResolution;
		_CurveData.subDivide = CurveSubdivide;
		ACTCurveRenderer.CurveData.CurvePoint[] array = new ACTCurveRenderer.CurveData.CurvePoint[_CurvePoints.Count];
		Bounds bounds = default;
		float num = 0f;
		ACTCurveRenderer.CurveData.CurvePoint curvePoint = default;
		for (int i = 0; i < _CurvePoints.Count; i++)
		{
			Transform transform = _CurvePoints[i].transform;
			curvePoint.position = transform.position;
			curvePoint.normal = transform.up;
			curvePoint.direction = transform.right;
			curvePoint.radius = transform.lossyScale.x;
			if (i == 0)
			{
				bounds = new Bounds(transform.position, transform.lossyScale);
			}
			else
			{
				bounds.Encapsulate(new Bounds(transform.position, transform.lossyScale));
			}
			if (i > 0)
			{
				num += (transform.position - array[i - 1].position).magnitude;
			}
			curvePoint.factor = num;
			curvePoint.color = color;
			array[i] = curvePoint;
		}
		_CurveData.points = array;
		_CurveData.FactorScale = num;
		_CurveData.bounds = bounds;
		_CurveData.alpha = alpha;
		_CurveRenderer.curveData = _CurveData;
	}

	private void OnValidate()
	{
		Update();
		_CurveRenderer.setDirt();
	}
}
