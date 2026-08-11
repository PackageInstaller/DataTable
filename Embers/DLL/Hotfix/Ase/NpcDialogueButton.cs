using System;
using Ase.ECS;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class NpcDialogueButton : MonoBehaviour
{
	public CanvasGroup canvasGroup;

	public Text content;

	public GameObject lockMask;

	public GameObject typeIconBg;

	public Image typeIcon;

	public bool isClick;

	public void DoShow(DialogChainComponent.DialogButton dialogButton)
	{
		IConverter converter = Context.GetApplicationContext().GetContainer().Resolve<IConverterRegistry>()
			.Find("ItemIcon");
		typeIcon.sprite = (Sprite)converter.Convert(dialogButton.IconType);
		if (typeIcon.sprite == null)
		{
			typeIconBg.SetActive(value: false);
		}
		else
		{
			typeIconBg.SetActive(value: true);
			typeIcon.SetNativeSize();
		}
		content.text = StoryUtility.ReplaceUsersName(dialogButton.Text);
		lockMask.SetActive(dialogButton.State == "lock");
		isClick = false;
	}

	public void DoHide()
	{
		if (isClick)
		{
			Sequence sequence = DOTween.Sequence();
			sequence.Append(((Component)(object)canvasGroup).GetComponent<RectTransform>().DOScale(1.07f, 0.1f));
			sequence.Append(DOTweenModuleUI.DOFade(canvasGroup, 1f, 0.1f));
			sequence.Append(DOTweenModuleUI.DOFade(canvasGroup, 0f, 0.1f).OnComplete(delegate
			{
				UnityEngine.Object.Destroy(base.gameObject);
			}));
			sequence.SetUpdate(isIndependentUpdate: true);
		}
		else
		{
			DOTweenModuleUI.DOFade(canvasGroup, 0f, 0.15f).SetUpdate(isIndependentUpdate: true).OnComplete(delegate
			{
				UnityEngine.Object.Destroy(base.gameObject);
			});
		}
	}

	public void RegitsterClickEvent(Action action)
	{
		GetComponent<Button>()?.onClick.AddListener(delegate
		{
			isClick = true;
			action();
		});
	}
}
