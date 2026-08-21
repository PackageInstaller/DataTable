using System;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillDescAutoFit : MonoBehaviour
{
	public float otherHeight;

	[SerializeField]
	private RectTransform rect;

	[SerializeField]
	private Transform parentRoot;

	[SerializeField]
	private RectTransform descText;

	private bool hasCal;

	private bool showDesc;

	private Action onShowAction;

	private void Start()
	{
		parentRoot = UnityEngine.Object.FindObjectOfType<TouchInputWindow>()?.transform;
	}

	public void UpdateDesc()
	{
		showDesc = true;
		hasCal = false;
	}

	private void Update()
	{
		if (hasCal && !showDesc)
		{
			float y = otherHeight + descText.sizeDelta.y;
			rect.sizeDelta = new Vector2(rect.sizeDelta.x, y);
			LayoutRebuilder.ForceRebuildLayoutImmediate(rect);
			showDesc = true;
			if (parentRoot != null)
			{
				base.transform.SetParent(parentRoot);
			}
			onShowAction();
		}
		if (!hasCal && showDesc)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(descText);
			showDesc = false;
			hasCal = true;
		}
	}

	public void AddOnShow(Action onShow)
	{
		onShowAction = onShow;
	}
}
