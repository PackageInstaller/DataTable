using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestGraphicIndicator : MonoBehaviour
{
	public CircleGraphicIndicator circleGraphicInspector;

	public FanGraphicIndicator fanGraphicInspector;

	public RectangleGraphicIndicator rectangleGraphicInspector;

	public RingGraphicIndicator ringGraphicInspector;

	public LineGraphicIndicator lineGraphicInspector;

	private float dt;

	private float t;

	private float r;

	private float s;

	private float p;

	private float a;

	private Color c1;

	private Color c2;

	private bool _runOnce;

	private void TestCircleGraphicInspector()
	{
		circleGraphicInspector.rotation = r;
		circleGraphicInspector.size = s;
		circleGraphicInspector.progress = p;
		circleGraphicInspector.baseColor = c1;
		circleGraphicInspector.progressColor = c2;
	}

	private void TestFanGraphicInspector()
	{
		fanGraphicInspector.rotation = r;
		fanGraphicInspector.size = s;
		fanGraphicInspector.progress = p;
		fanGraphicInspector.angle = a;
		fanGraphicInspector.baseColor = c1;
		fanGraphicInspector.progressColor = c2;
	}

	private void TestRectangleGraphicInspector()
	{
		rectangleGraphicInspector.rotation = r;
		rectangleGraphicInspector.width = 0.5f + (1f - p);
		rectangleGraphicInspector.height = s;
		rectangleGraphicInspector.progress = p;
		rectangleGraphicInspector.baseColor = c1;
		rectangleGraphicInspector.progressColor = c2;
	}

	private void TestRingGraphicInspector()
	{
		ringGraphicInspector.rotation = r;
		ringGraphicInspector.size = s;
		ringGraphicInspector.thickness = s * 0.25f;
		ringGraphicInspector.progress = p;
		ringGraphicInspector.baseColor = c1;
		ringGraphicInspector.progressColor = c2;
	}

	private IEnumerator TestLineGraphicInspector()
	{
		while (true)
		{
			lineGraphicInspector.rotation = r;
			lineGraphicInspector.thickness = 0.1f + s * 0.1f;
			lineGraphicInspector.progress = p;
			lineGraphicInspector.baseColor = c1;
			lineGraphicInspector.progressColor = c2;
			Vector3 vector = new Vector3(4f, 0.5f, 0f);
			Vector3 vector2 = Quaternion.Euler(0f, r * 2f, 0f) * Vector3.forward;
			List<Vector3> list = new List<Vector3>();
			list.Add(vector);
			for (int i = 0; i < 4; i++)
			{
				if (Physics.Raycast(vector, vector2, out var hitInfo, 1000f, -5, QueryTriggerInteraction.UseGlobal))
				{
					Vector3 point = hitInfo.point;
					Vector3 normal = hitInfo.normal;
					normal.y = 0f;
					normal.Normalize();
					list.Add(point);
					vector = point;
					vector2 = Vector3.Reflect(vector2, normal);
					vector2.y = 0f;
					vector2.Normalize();
				}
			}
			lineGraphicInspector.SetWorldPositionPoints(list);
			yield return new WaitForSeconds(0.1f);
		}
	}

	private void Update()
	{
		dt = Time.deltaTime;
		t = Time.time;
		r = (0.5f + Mathf.Sin(t) * 0.5f) * 90f;
		s = 1f + Mathf.Sin(t);
		p = 0.5f + Mathf.Sin(t) * 0.5f;
		a = (0.5f + Mathf.Sin(t) * 0.5f) * 360f;
		c1 = Color.Lerp(Color.blue, Color.red, p);
		c2 = Color.Lerp(Color.cyan, Color.green, p);
		TestCircleGraphicInspector();
		TestFanGraphicInspector();
		TestRectangleGraphicInspector();
		TestRingGraphicInspector();
		if (!_runOnce)
		{
			StartCoroutine(TestLineGraphicInspector());
			_runOnce = true;
		}
	}
}
