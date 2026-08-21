using UnityEngine;
using UnityEngine.UI;

public class HPSlowSliderEffect : BaseMeshEffect
{
	private UIVertex vertex;

	public float min;

	public float max;

	private Vector4 border = Vector4.zero;

	private bool isDirty;

	protected override void Awake()
	{
		Image component = GetComponent<Image>();
		border = component.sprite.border;
		if (component == null || component.type != Image.Type.Sliced)
		{
			Debug.LogError("HPSlowSliderEffect 只能用于 Image.Type.Sliced 类型的 Image");
		}
	}

	public void SetRectPos(VertexHelper vh, int rectIndex, float minX, float maxX)
	{
		vh.PopulateUIVertex(ref vertex, 4 * rectIndex);
		Vector3 position = vertex.position;
		position.x = minX;
		vertex.position = position;
		vh.SetUIVertex(vertex, 4 * rectIndex);
		vh.PopulateUIVertex(ref vertex, 4 * rectIndex + 1);
		position = vertex.position;
		position.x = minX;
		vertex.position = position;
		vh.SetUIVertex(vertex, 4 * rectIndex + 1);
		vh.PopulateUIVertex(ref vertex, 4 * rectIndex + 2);
		position = vertex.position;
		position.x = maxX;
		vertex.position = position;
		vh.SetUIVertex(vertex, 4 * rectIndex + 2);
		vh.PopulateUIVertex(ref vertex, 4 * rectIndex + 3);
		position = vertex.position;
		position.x = maxX;
		vertex.position = position;
		vh.SetUIVertex(vertex, 4 * rectIndex + 3);
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		if (!IsActive() || !isDirty)
		{
			return;
		}
		float width = (base.transform as RectTransform).rect.width;
		width = width - border.z - border.x;
		float num = width * min - 0.5f * width;
		float num2 = width * max - 0.5f * width;
		if (vh.currentVertCount != 36 && vh.currentVertCount != 24 && vh.currentVertCount != 12)
		{
			Debug.LogError("HPSlowSliderEffect 只能用于 Sliced 类型且九宫切分之后至少有3份的 Image,需要把ui拉长一点 当前顶点数: " + vh.currentVertCount);
			return;
		}
		int num3 = vh.currentVertCount / 4 / 3;
		for (int i = 0; i < num3; i++)
		{
			SetRectPos(vh, i, num - border.x, num);
		}
		for (int j = num3; j < num3 * 2; j++)
		{
			SetRectPos(vh, j, num, num2);
		}
		for (int k = num3 * 2; k < num3 * 3; k++)
		{
			SetRectPos(vh, k, num2, num2 + border.z);
		}
		isDirty = false;
	}

	public void SetDuration(float min, float max)
	{
		bool flag = false;
		min = Mathf.Clamp01(min);
		max = Mathf.Clamp01(max);
		if (Mathf.Abs(min - this.min) > 0.001f)
		{
			this.min = min;
			flag = true;
		}
		if (Mathf.Abs(max - this.max) > 0.001f)
		{
			this.max = max;
			flag = true;
		}
		if (flag)
		{
			SetDirty();
		}
	}

	public void SetDirty()
	{
		isDirty = true;
		base.graphic.SetVerticesDirty();
	}

	protected override void OnEnable()
	{
		isDirty = true;
	}
}
