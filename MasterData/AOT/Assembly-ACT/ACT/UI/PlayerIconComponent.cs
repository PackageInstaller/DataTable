using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class PlayerIconComponent : LoopScrollBaseItem, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public BImage icon;

	public BImage upperIcon;

	public PublicToggle toggle;

	public GameObject usingImage;

	public GameObject lockNode;

	[SerializeField]
	private GameObject highLightImage;

	[SerializeField]
	private RedDotItem redDotItem;

	public UnityEvent<PlayerIconComponent> onScroll;

	public void Init()
	{
		toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		upperIcon?.UnLoad();
		SetUpperIconVisible(visible: false);
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

	public void SetUpperIconVisible(bool visible)
	{
		if (upperIcon != null)
		{
			if (upperIcon.isRawImage)
			{
				upperIcon.rawIcon?.gameObject.SetActive(visible);
			}
			else
			{
				upperIcon.icon?.gameObject.SetActive(visible);
			}
		}
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
