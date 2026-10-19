using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class TitleIconComponent : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public BImage icon;

	public PublicToggle toggle;

	public GameObject usingImage;

	public GameObject lockNode;

	[SerializeField]
	private GameObject highLightImage;

	[SerializeField]
	private RedDotItem redDotItem;

	public TextMeshProUGUI titleText;

	public UnityEvent<TitleIconComponent> onScroll;

	public void Init()
	{
		toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		usingImage.SetActive(value: false);
		SetHighLightActive(active: false);
		redDotItem?.gameObject.SetActive(value: false);
		if (lockNode != null)
		{
			lockNode.SetActive(value: false);
		}
	}

	public override void ScrollCellIndex(int idx)
	{
		index = idx;
		onScroll.Invoke(this);
	}

	public void SetUsing()
	{
		usingImage.SetActive(value: true);
	}

	public void SetLocked(bool locked)
	{
		if (lockNode != null)
		{
			lockNode.SetActive(locked);
		}
	}

	public void InitRedDot(string path)
	{
		if (!(redDotItem == null) && !string.IsNullOrEmpty(path))
		{
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(path))
			{
				redDotItem.gameObject.SetActive(value: false);
			}
			else
			{
				redDotItem.InitRedDot(path, RedDotType.New);
			}
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		SetHighLightActive(active: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		SetHighLightActive(active: false);
	}

	private void SetHighLightActive(bool active)
	{
		if (highLightImage != null)
		{
			highLightImage.SetActive(active);
		}
	}
}
