using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[AddComponentMenu("UI/Effects/TextSpacing")]
public class TextSpacing : BaseMeshEffect
{
	public enum HorizontalAligmentType
	{
		Left,
		Center,
		Right
	}

	public class Line
	{
		private int _startVertexIndex;

		private int _endVertexIndex;

		private int _vertexCount;

		public int StartVertexIndex => _startVertexIndex;

		public int EndVertexIndex => _endVertexIndex;

		public int VertexCount => _vertexCount;

		public Line(int startVertexIndex, int length)
		{
			_startVertexIndex = startVertexIndex;
			_endVertexIndex = length * 6 - 1 + startVertexIndex;
			_vertexCount = length * 6;
		}
	}

	public float Spacing = 1f;

	public override void ModifyMesh(VertexHelper vh)
	{
		if (!IsActive() || vh.currentVertCount == 0)
		{
			return;
		}
		Text component = GetComponent<Text>();
		if (component == null)
		{
			Debug.LogError("Missing Text component");
			return;
		}
		HorizontalAligmentType horizontalAligmentType = ((component.alignment != TextAnchor.LowerLeft && component.alignment != TextAnchor.MiddleLeft && component.alignment != TextAnchor.UpperLeft) ? ((component.alignment == TextAnchor.LowerCenter || component.alignment == TextAnchor.MiddleCenter || component.alignment == TextAnchor.UpperCenter) ? HorizontalAligmentType.Center : HorizontalAligmentType.Right) : HorizontalAligmentType.Left);
		List<UIVertex> list = new List<UIVertex>();
		vh.GetUIVertexStream(list);
		string[] array = component.text.Split('\n');
		Line[] array2 = new Line[array.Length];
		for (int i = 0; i < array2.Length; i++)
		{
			if (i == 0)
			{
				array2[i] = new Line(0, array[i].Length + 1);
			}
			else if (i > 0 && i < array2.Length - 1)
			{
				array2[i] = new Line(array2[i - 1].EndVertexIndex + 1, array[i].Length + 1);
			}
			else
			{
				array2[i] = new Line(array2[i - 1].EndVertexIndex + 1, array[i].Length);
			}
		}
		for (int j = 0; j < array2.Length; j++)
		{
			for (int k = array2[j].StartVertexIndex; k <= array2[j].EndVertexIndex; k++)
			{
				if (k >= 0 && k < list.Count)
				{
					UIVertex uIVertex = list[k];
					int num = array2[j].EndVertexIndex - array2[j].StartVertexIndex;
					if (j == array2.Length - 1)
					{
						num += 6;
					}
					switch (horizontalAligmentType)
					{
					case HorizontalAligmentType.Left:
						uIVertex.position += new Vector3(Spacing * (float)((k - array2[j].StartVertexIndex) / 6), 0f, 0f);
						break;
					case HorizontalAligmentType.Right:
						uIVertex.position += new Vector3(Spacing * (float)(-(num - k + array2[j].StartVertexIndex) / 6 + 1), 0f, 0f);
						break;
					case HorizontalAligmentType.Center:
					{
						float num2 = ((num / 6 % 2 == 0) ? 0.5f : 0f);
						uIVertex.position += new Vector3(Spacing * ((float)((k - array2[j].StartVertexIndex) / 6 - num / 12) + num2), 0f, 0f);
						break;
					}
					}
					list[k] = uIVertex;
					if (k % 6 <= 2)
					{
						vh.SetUIVertex(uIVertex, k / 6 * 4 + k % 6);
					}
					if (k % 6 == 4)
					{
						vh.SetUIVertex(uIVertex, k / 6 * 4 + k % 6 - 1);
					}
				}
			}
		}
	}
}
