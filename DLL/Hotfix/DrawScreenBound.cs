using System;
using UnityEngine;

public class DrawScreenBound : MonoBehaviour
{
	private Material _lineMaterial;

	private BoundingSphere _heroBound;

	private BoundingSphere _monsterBound;

	public bool isDraw;

	private Vector3 _adsorptionPointPosition;

	private float _heroActivitiesRadius;

	private void CreateLineMaterial()
	{
		if (!_lineMaterial)
		{
			Shader shader = Shader.Find("Hidden/Internal-Colored");
			_lineMaterial = new Material(shader);
			_lineMaterial.hideFlags = HideFlags.HideAndDontSave;
			_lineMaterial.SetInt("_SrcBlend", 5);
			_lineMaterial.SetInt("_DstBlend", 10);
			_lineMaterial.SetInt("_Cull", 0);
			_lineMaterial.SetInt("_ZWrite", 0);
		}
	}

	public void UpdateBound(Vector3 heroPositionCenter, Vector3 monsterPositionCenter, float heroRadius3D, float monsterRadius3D, float heroActivitiesRadius, Vector3 adsorptionPointPosition)
	{
		_heroBound = new BoundingSphere(heroPositionCenter, heroRadius3D);
		_monsterBound = new BoundingSphere(monsterPositionCenter, monsterRadius3D);
		_heroActivitiesRadius = heroActivitiesRadius;
		_adsorptionPointPosition = adsorptionPointPosition;
	}

	public void Update()
	{
		if (isDraw)
		{
			DrawDebugTools.DrawSphere(_heroBound.position, Quaternion.identity, _heroBound.radius, 10, Color.cyan, 0f);
			DrawDebugTools.DrawSphere(_monsterBound.position, Quaternion.identity, _monsterBound.radius, 10, Color.cyan, 0f);
		}
	}

	public void OnRenderObject()
	{
		if (isDraw)
		{
			CreateLineMaterial();
			_lineMaterial.SetPass(0);
			GL.PushMatrix();
			GL.LoadPixelMatrix(0f, Screen.width, 0f, Screen.height);
			DrawSphere(_heroActivitiesRadius, _adsorptionPointPosition, Color.yellow);
			DrawTriangle(new Vector2((float)Screen.width * 1f / 2f, (float)Screen.height * 1f / 2f), new Vector2(10f, 10f), Color.magenta);
			GL.PopMatrix();
		}
	}

	private void DrawSphere(float circleRadius, Vector2 position, Color color)
	{
		float num = MathF.PI / 50f;
		GL.Begin(1);
		GL.Color(color);
		for (int i = 0; i < 100; i++)
		{
			float num2 = num * (float)i;
			float f = num2 + num;
			Vector2 vector = new Vector2(position.x + Mathf.Cos(num2) * circleRadius, position.y + Mathf.Sin(num2) * circleRadius);
			Vector2 vector2 = new Vector2(position.x + Mathf.Cos(f) * circleRadius, position.y + Mathf.Sin(f) * circleRadius);
			GL.Vertex3(vector.x, vector.y, 0f);
			GL.Vertex3(vector2.x, vector2.y, 0f);
		}
		GL.End();
	}

	private void DrawLine(Vector2 positionOne, Vector2 positionTwo, Color color)
	{
		GL.Begin(1);
		GL.Color(color);
		GL.Vertex3(positionOne.x, positionOne.y, 0f);
		GL.Vertex3(positionTwo.x, positionTwo.y, 0f);
		GL.End();
	}

	private void DrawTriangle(Vector2 positionOne, Vector2 size, Color color)
	{
		GL.Begin(1);
		GL.Color(color);
		GL.Vertex3(positionOne.x, positionOne.y + size.y, 0f);
		GL.Vertex3(positionOne.x + size.x, positionOne.y - size.y, 0f);
		GL.Vertex3(positionOne.x + size.x, positionOne.y - size.y, 0f);
		GL.Vertex3(positionOne.x - size.x, positionOne.y - size.y, 0f);
		GL.Vertex3(positionOne.x - size.x, positionOne.y - size.y, 0f);
		GL.Vertex3(positionOne.x, positionOne.y + size.y, 0f);
		GL.End();
	}

	private void DrawScreenGrid(Rect rect, Color color)
	{
		GL.Begin(1);
		GL.Color(color);
		GL.Vertex3(rect.xMin, rect.yMin, 0f);
		GL.Vertex3(rect.xMin, rect.yMax, 0f);
		GL.Vertex3(rect.xMin, rect.yMax, 0f);
		GL.Vertex3(rect.xMax, rect.yMax, 0f);
		GL.Vertex3(rect.xMax, rect.yMax, 0f);
		GL.Vertex3(rect.xMax, rect.yMin, 0f);
		GL.Vertex3(rect.xMax, rect.yMin, 0f);
		GL.Vertex3(rect.xMin, rect.yMin, 0f);
		GL.End();
	}
}
