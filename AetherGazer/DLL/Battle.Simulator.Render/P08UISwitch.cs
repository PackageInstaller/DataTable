using UnityEngine;

public class P08UISwitch
{
	public CanvasGroup canvasGroup;

	public GameObject gameObject;

	private uint hideTags;

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		bool flag = hideTags == 0;
		if (isActive)
		{
			hideTags &= (uint)(~reason);
		}
		else
		{
			hideTags |= (uint)reason;
		}
		if (flag && hideTags != 0)
		{
			SetActive(isActive: false);
		}
		else if (!flag && hideTags == 0)
		{
			SetActive(isActive: true);
		}
	}

	private void SetActive(bool isActive)
	{
		if (canvasGroup == null)
		{
			gameObject.SetActive(isActive);
			return;
		}
		canvasGroup.alpha = (isActive ? 1 : 0);
		canvasGroup.interactable = isActive;
		canvasGroup.blocksRaycasts = isActive;
	}
}
