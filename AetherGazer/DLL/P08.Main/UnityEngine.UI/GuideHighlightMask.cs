using System;

namespace UnityEngine.UI;

public class GuideHighlightMask : MaskableGraphic, ICanvasRaycastFilter
{
	public RectTransform target;

	public int style = 1;

	private Vector2 size = new Vector2(100f, 100f);

	private Vector3 pos = Vector3.zero;

	private Vector2 sizeDetla = Vector2.one;

	private Vector3 scale = Vector3.one;

	private Vector3 euler = Vector3.zero;

	public void DoUpdate()
	{
		if (!(target == null))
		{
			Vector3 lossyScale = target.lossyScale;
			Vector3 lossyScale2 = base.transform.lossyScale;
			Vector3 vector = new Vector3(lossyScale.x / lossyScale2.x, lossyScale.y / lossyScale2.y, lossyScale.z / lossyScale2.z);
			if (((bool)target && pos != target.position) || size != target.sizeDelta || scale != vector || euler != target.localEulerAngles)
			{
				pos = target.position;
				scale = vector;
				euler = target.localEulerAngles;
				base.rectTransform.position = pos;
				base.rectTransform.localEulerAngles = euler;
				size = new Vector2(target.sizeDelta.x * Mathf.Abs(scale.x), target.sizeDelta.y * Mathf.Abs(scale.y));
				SetAllDirty();
			}
		}
	}

	public bool IsRaycastLocationValid(Vector2 sp, Camera eventCamera)
	{
		return !RectTransformUtility.RectangleContainsScreenPoint(target, sp, eventCamera);
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		if (target == null)
		{
			return;
		}
		vh.Clear();
		Vector4 vector = new Vector4((0f - base.rectTransform.pivot.x) * base.rectTransform.rect.width, (0f - base.rectTransform.pivot.y) * base.rectTransform.rect.height, (1f - base.rectTransform.pivot.x) * base.rectTransform.rect.width, (1f - base.rectTransform.pivot.y) * base.rectTransform.rect.height);
		Vector4 vector2 = new Vector4((0f - size.x) / 2f, (0f - size.y) / 2f, size.x * 0.5f, size.y * 0.5f);
		UIVertex simpleVert = UIVertex.simpleVert;
		if (style == 1)
		{
			simpleVert.position = new Vector2(vector.x, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.x, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x, vector2.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.z, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.z, vector2.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.z, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x, vector2.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.z, vector2.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			vh.AddTriangle(0, 1, 2);
			vh.AddTriangle(2, 3, 0);
			vh.AddTriangle(4, 2, 5);
			vh.AddTriangle(5, 6, 4);
			vh.AddTriangle(7, 5, 8);
			vh.AddTriangle(8, 7, 9);
			vh.AddTriangle(3, 10, 11);
			vh.AddTriangle(11, 7, 3);
		}
		else if (style == 2)
		{
			simpleVert.position = new Vector2(vector.x, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.x, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			float num = Mathf.Max(size.x, size.y) / 2f;
			int num2 = 28;
			float num3 = 360f;
			float num5;
			float num4 = (num5 = MathF.PI / 180f * num3) / (float)num2;
			for (int i = 1; i < num2 + 1; i++)
			{
				float num6 = Mathf.Cos(num5);
				float num7 = Mathf.Sin(num5);
				simpleVert.position = new Vector2(num * num6, num * num7);
				simpleVert.color = color;
				vh.AddVert(simpleVert);
				num5 -= num4;
			}
			int num8 = num2 / 4;
			vh.AddTriangle(2, 4, 3);
			vh.AddTriangle(0, 4 + num8, 3);
			vh.AddTriangle(1, 4 + num8 * 2, 0);
			vh.AddTriangle(1, 4 + num8 * 3, 2);
			for (int j = 4; j < 4 + num8; j++)
			{
				vh.AddTriangle(3, j, j + 1);
			}
			for (int k = 4 + num8; k < 4 + num8 * 2; k++)
			{
				vh.AddTriangle(0, k, k + 1);
			}
			for (int l = 4 + num8 * 2; l < 4 + num8 * 3; l++)
			{
				vh.AddTriangle(1, l, l + 1);
			}
			for (int m = 4 + num8 * 3; m < 4 + num8 * 4 - 1; m++)
			{
				vh.AddTriangle(2, m, m + 1);
			}
			vh.AddTriangle(2, 4 + num8 * 4 - 1, 4);
		}
		else if (style == 3)
		{
			simpleVert.position = new Vector2(vector.x, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.x, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x - size.x / 2f, vector2.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.z + size.x / 2f, vector2.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector2.x + size.x / 2f, vector2.w + size.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			vh.AddTriangle(1, 4, 0);
			vh.AddTriangle(0, 4, 3);
			vh.AddTriangle(4, 5, 3);
			vh.AddTriangle(3, 5, 2);
			vh.AddTriangle(2, 6, 5);
			vh.AddTriangle(6, 2, 1);
			vh.AddTriangle(1, 4, 6);
		}
		else if (style == 4)
		{
			simpleVert.position = new Vector2(vector.x, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.x, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.w);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			simpleVert.position = new Vector2(vector.z, vector.y);
			simpleVert.color = color;
			vh.AddVert(simpleVert);
			float num9 = size.x / 2f;
			float num10 = size.y / 2f;
			int num11 = 28;
			float num12 = 360f;
			float num14;
			float num13 = (num14 = MathF.PI / 180f * num12) / (float)num11;
			for (int n = 1; n < num11 + 1; n++)
			{
				float num15 = Mathf.Cos(num14);
				float num16 = Mathf.Sin(num14);
				simpleVert.position = new Vector2(num9 * num15, num10 * num16);
				simpleVert.color = color;
				vh.AddVert(simpleVert);
				num14 -= num13;
			}
			int num17 = num11 / 4;
			vh.AddTriangle(2, 4, 3);
			vh.AddTriangle(0, 4 + num17, 3);
			vh.AddTriangle(1, 4 + num17 * 2, 0);
			vh.AddTriangle(1, 4 + num17 * 3, 2);
			for (int num18 = 4; num18 < 4 + num17; num18++)
			{
				vh.AddTriangle(3, num18, num18 + 1);
			}
			for (int num19 = 4 + num17; num19 < 4 + num17 * 2; num19++)
			{
				vh.AddTriangle(0, num19, num19 + 1);
			}
			for (int num20 = 4 + num17 * 2; num20 < 4 + num17 * 3; num20++)
			{
				vh.AddTriangle(1, num20, num20 + 1);
			}
			for (int num21 = 4 + num17 * 3; num21 < 4 + num17 * 4 - 1; num21++)
			{
				vh.AddTriangle(2, num21, num21 + 1);
			}
			vh.AddTriangle(2, 4 + num17 * 4 - 1, 4);
		}
	}

	private void Update()
	{
		DoUpdate();
	}
}
