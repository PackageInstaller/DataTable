using UnityEngine;
using UnityEngine.EventSystems;

public class ChessUICameraCtrl : MonoBehaviour, IDragHandler, IEventSystemHandler
{
	private IChessCameraCtrlGameLogic updateGameLogic;

	private bool inited;

	private Vector2 dragDelta = Vector2.zero;

	public float speed = 1f;

	public void Init(IChessCameraCtrlGameLogic updateGameLogic)
	{
		this.updateGameLogic = updateGameLogic;
		inited = true;
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragDelta = eventData.delta;
	}

	private void Update()
	{
		if (inited && Input.touchCount <= 1)
		{
			if (updateGameLogic != null)
			{
				updateGameLogic.UpdateLogic(dragDelta * speed * Time.deltaTime * 0.5f);
			}
			dragDelta = Vector2.zero;
		}
	}

	private void OnDisable()
	{
	}
}
