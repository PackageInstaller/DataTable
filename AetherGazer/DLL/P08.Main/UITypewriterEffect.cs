using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class UITypewriterEffect : BaseMeshEffect
{
	[Range(0f, 1f)]
	public float percent;

	public RectTransform scRect;

	public RectTransform content;

	public Scrollbar sliderDrag;

	private Text text;

	public bool needAutoScroll = true;

	private float distance;

	private uint line;

	private int lastSpacing = -1;

	private UIVertex vertex;

	private UIVertex firstVertex;

	private UIVertex indexVertex;

	private float scLowHeight;

	protected override void Awake()
	{
		if (!scRect)
		{
			ScrollRect componentInParent = GetComponentInParent<ScrollRect>();
			if (componentInParent != null)
			{
				scRect = componentInParent.GetComponent<RectTransform>();
			}
		}
		if (!sliderDrag && (bool)scRect)
		{
			Transform transform = scRect.gameObject.transform.Find("Scrollbar Vertical");
			if ((bool)transform)
			{
				sliderDrag = transform.GetComponent<Scrollbar>();
			}
		}
		if ((bool)scRect)
		{
			scLowHeight = scRect.sizeDelta.y;
		}
		if (!content)
		{
			content = base.transform.parent.GetComponent<RectTransform>();
		}
		text = base.transform.GetComponent<Text>();
		distance = 0f;
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		if (vh.currentIndexCount == 0)
		{
			return;
		}
		if ((bool)scRect)
		{
			scLowHeight = scRect.sizeDelta.y;
		}
		int num = vh.currentVertCount / 4;
		int num2 = Mathf.RoundToInt((float)num * percent);
		if (num2 == 0)
		{
			distance = 0f;
		}
		if (num > 0 && num2 < num)
		{
			vh.PopulateUIVertex(ref firstVertex, 1);
			vh.PopulateUIVertex(ref indexVertex, num2 * 4);
		}
		for (int i = num2; i < num; i++)
		{
			for (int j = 0; j < 4; j++)
			{
				vh.PopulateUIVertex(ref vertex, i * 4 + j);
				Color32 color = vertex.color;
				color.a = 0;
				vertex.color = color;
				vh.SetUIVertex(vertex, i * 4 + j);
			}
		}
		if (!scRect || !content || !needAutoScroll || !text || num2 > num || num <= 0)
		{
			return;
		}
		float num3 = 0f;
		UIVertex uIVertex = default(UIVertex);
		if (num2 == num)
		{
			for (int k = 0; k < 4; k++)
			{
				vh.PopulateUIVertex(ref uIVertex, num2 * 4 - 1 - k);
				if (uIVertex.position.y < num3)
				{
					num3 = uIVertex.position.y;
				}
			}
		}
		else
		{
			for (int l = 0; l < 4; l++)
			{
				vh.PopulateUIVertex(ref uIVertex, num2 * 4 + l);
				if (uIVertex.position.y < num3)
				{
					num3 = uIVertex.position.y;
				}
			}
		}
		float num4 = num3 + scRect.rect.height - text.lineSpacing;
		if (num4 < distance)
		{
			distance = num4;
			content.localPosition = new Vector3(0f, distance * -1f, 0f);
		}
	}

	public void SetDirty()
	{
		base.graphic.SetVerticesDirty();
	}

	public void ResetContent()
	{
		if ((bool)sliderDrag)
		{
			Debug.Log("<color=#00ff00>ResetContent</color>");
		}
	}

	private IEnumerator DownSlider(float value)
	{
		yield return null;
		if ((bool)sliderDrag)
		{
			sliderDrag.value = value;
		}
	}
}
