using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PopDialogFitter : MonoBehaviour
{
	public AutoDispose autoDispose;

	public Vector2 padding;

	public float maxWidth;

	public ContentSizeFitter csFitter;

	public TextMeshProUGUI dialogText;

	public LoadUISprite icon;

	public RectTransform stickerRoot;

	public RectTransform textRoot;

	public GameObject lastGo;

	private Action disposeAction;

	private string dialog;

	private Vector2 pos;

	private NPCDialogData data;

	private bool needfitDialog;

	private void Start()
	{
		autoDispose.AddDisposeAction((Action<GameObject>)delegate
		{
			RefreshDialog();
		});
	}

	public void UpdatePos()
	{
		GetComponent<RectTransform>().localPosition = data.pos;
	}

	private void Update()
	{
		if (needfitDialog && base.gameObject.activeSelf)
		{
			FitterText();
			needfitDialog = false;
		}
	}

	private void SetDialog(string s, bool isSticker)
	{
		lastGo.gameObject.SetActive(value: false);
		textRoot.gameObject.SetActive(!isSticker);
		stickerRoot.gameObject.SetActive(isSticker);
		if (isSticker)
		{
			icon.Path = s;
			return;
		}
		((TMP_Text)dialogText).text = s;
		if (base.gameObject.activeSelf)
		{
			FitterText();
		}
		else
		{
			needfitDialog = true;
		}
	}

	private void FitterText()
	{
		((TMP_Text)dialogText).rectTransform.sizeDelta = new Vector2(0f, 0f);
		csFitter.horizontalFit = ContentSizeFitter.FitMode.PreferredSize;
		csFitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;
		LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)dialogText).rectTransform);
		if (((TMP_Text)dialogText).rectTransform.sizeDelta.x > maxWidth)
		{
			((TMP_Text)dialogText).rectTransform.sizeDelta = new Vector2(maxWidth, 0f);
			csFitter.horizontalFit = ContentSizeFitter.FitMode.Unconstrained;
			csFitter.verticalFit = ContentSizeFitter.FitMode.PreferredSize;
			LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)dialogText).rectTransform);
		}
		textRoot.sizeDelta = ((TMP_Text)dialogText).rectTransform.sizeDelta + padding;
		((TMP_Text)dialogText).rectTransform.anchoredPosition = Vector2.zero;
		lastGo.SetActive(data.texts.Count > 1);
	}

	private void RefreshDialog()
	{
		if (data != null && data.texts.Count > 0)
		{
			SetDialog(data.texts[0], data.isSticker[0]);
			if (data.duratime.Count > 0)
			{
				autoDispose.ResetTime(data.duratime[0]);
			}
			data.texts.RemoveAt(0);
			data.isSticker.RemoveAt(0);
			data.duratime.RemoveAt(0);
		}
		else
		{
			base.gameObject.SetActive(value: false);
			disposeAction?.Invoke();
		}
	}

	public void Init(NPCDialogData data, Action disposeAction)
	{
		this.data = data;
		RefreshDialog();
		this.disposeAction = disposeAction;
	}
}
