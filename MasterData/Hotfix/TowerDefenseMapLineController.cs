using UnityEngine;

public class TowerDefenseMapLineController : MonoBehaviour
{
	private LineRenderer lineRenderer;

	private GameObject arrow;

	private bool show;

	private float duration = 1f;

	private int showCount = 1;

	private float showSpeed = 1f;

	private Material mat;

	private float start = 1f;

	private float end = -1f;

	private MaterialPropertyBlock mpb;

	private static string texName = "_MainTex_ST";

	private float curValue;

	public int id { get; private set; }

	public void Init(int id, GameObject lineObj, GameObject arrowObj)
	{
		this.id = id;
		lineRenderer = lineObj.GetComponentInChildren<LineRenderer>();
		arrow = arrowObj;
		lineObj.transform.SetParent(transform);
		arrow.transform.SetParent(transform);
		arrow.SetActive(value: false);
		mpb = new MaterialPropertyBlock();
		lineRenderer.GetPropertyBlock(mpb);
	}

	public void Hide()
	{
		mpb.SetVector(texName, new Vector4(1f, 1f, end, 0f));
		lineRenderer.SetPropertyBlock(mpb);
		gameObject.SetActive(value: false);
		show = false;
	}

	public void Show(float duration = 1f, int showCount = 1)
	{
		if (!show)
		{
			gameObject.SetActive(value: true);
			show = true;
			this.duration = duration;
			this.showCount = showCount;
			showSpeed = (start - end) * Time.fixedDeltaTime / duration;
			curValue = start;
			if (null != lineRenderer)
			{
				mat = lineRenderer.sharedMaterial;
				mpb.SetVector(texName, new Vector4(1f, 1f, curValue, 0f));
				lineRenderer.SetPropertyBlock(mpb);
			}
		}
	}

	public void RefreshLine(Vector3[] points)
	{
		if (points != null && points.Length > 2)
		{
			lineRenderer.positionCount = points.Length;
			for (int i = 0; i < points.Length; i++)
			{
				lineRenderer.SetPosition(i, points[i]);
			}
			Vector3 vector = points[points.Length - 2];
			Vector3 vector2 = points[points.Length - 1];
			Vector3 forward = vector2 - vector;
			arrow.transform.position = vector2;
			arrow.transform.forward = forward;
		}
	}

	private void FixedUpdate()
	{
		if (show && !(null == mat) && showCount > 0)
		{
			if (curValue > end)
			{
				curValue -= showSpeed;
			}
			if (curValue <= end)
			{
				showCount--;
				curValue = end;
			}
			mpb.SetVector(texName, new Vector4(1f, 1f, curValue, 0f));
			lineRenderer.SetPropertyBlock(mpb);
			if (curValue <= end)
			{
				curValue = start;
			}
			if (showCount <= 0)
			{
				Hide();
			}
		}
	}
}
