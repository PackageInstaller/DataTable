using System;
using Ase.ECS;
using DG.Tweening;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapItemDialogueButton : MonoBehaviour
{
	public CanvasGroup canvasGroup;

	public Text content;

	public Text indextText;

	public void DoShow(Sequence sequence, int index, DialogChainComponent.DialogButton dialogButton)
	{
		content.text = dialogButton.Text;
		indextText.text = index.ToString();
		canvasGroup.alpha = 0f;
		sequence.Append(DOTweenModuleUI.DOFade(canvasGroup, 1f, 0.1f));
	}

	public void DoHide(Sequence sequence)
	{
		sequence.Append(DOTweenModuleUI.DOFade(canvasGroup, 0f, 0.1f).OnComplete(delegate
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}));
	}

	public void RegitsterClickEvent(Action action)
	{
		GetComponent<Button>()?.onClick.AddListener(delegate
		{
			action();
		});
	}
}
