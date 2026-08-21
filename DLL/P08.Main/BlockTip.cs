using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BlockTip : MonoBehaviour
{
	[SerializeField]
	private Button _btn;

	[SerializeField]
	private GameObject _tipGameObject;

	[SerializeField]
	private bool clickThrough;

	private GameObject m_Blocker;

	private List<Canvas> _canvasList;

	private bool hideFlag;

	private void Awake()
	{
		_canvasList = new List<Canvas>();
		if (_btn != null)
		{
			_btn.onClick.AddListener(Show);
		}
	}

	public void Show()
	{
		if (!hideFlag)
		{
			_tipGameObject.SetActive(value: true);
			base.gameObject.GetComponentsInParent(includeInactive: false, _canvasList);
			if (_canvasList.Count != 0)
			{
				Canvas rootCanvas = _canvasList[0];
				m_Blocker = CreateBlocker(rootCanvas);
			}
		}
	}

	private void LateUpdate()
	{
		if (hideFlag)
		{
			Hide();
			hideFlag = false;
		}
	}

	public void SetHideFlag()
	{
		if (m_Blocker != null)
		{
			GameObject blocker = m_Blocker;
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				if (blocker != null)
				{
					Object.Destroy(blocker);
				}
			}, 0.1f, 1);
			m_Blocker = null;
			hideFlag = true;
		}
		else
		{
			m_Blocker = null;
			hideFlag = true;
		}
	}

	public void Hide()
	{
		_tipGameObject.SetActive(value: false);
	}

	protected GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject obj = new GameObject("Blocker");
		RectTransform rectTransform = obj.AddComponent<RectTransform>();
		rectTransform.SetParent(rootCanvas.transform, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		Canvas canvas = obj.AddComponent<Canvas>();
		canvas.overrideSorting = true;
		canvas.sortingLayerID = 1;
		canvas.sortingOrder = 30000;
		obj.AddComponent<GraphicRaycaster>();
		obj.AddComponent<Image>().color = Color.clear;
		obj.AddComponent<Button>().onClick.AddListener(SetHideFlag);
		obj.AddComponent<EventTriggerListener>().isPassEvent = clickThrough;
		return obj;
	}

	protected virtual void DestroyBlocker(GameObject blocker)
	{
		Object.Destroy(blocker);
	}

	private void OnDestroy()
	{
		if (m_Blocker != null)
		{
			Object.Destroy(m_Blocker);
		}
	}
}
