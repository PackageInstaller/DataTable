using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class CombineGameMouse : MonoBehaviour
{
	public CombineGameBlock block;

	public Transform information;

	public RectTransform prefabRect;

	private void Start()
	{
		block = base.transform.Find("block/empty").GetComponent<CombineGameBlock>();
		prefabRect = base.transform.parent.parent.transform.GetComponent<RectTransform>();
	}

	private void Update()
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(prefabRect, Input.mousePosition, CanvasManager.Instance.uiCamera, out var localPoint);
		base.transform.localPosition = localPoint;
	}
}
