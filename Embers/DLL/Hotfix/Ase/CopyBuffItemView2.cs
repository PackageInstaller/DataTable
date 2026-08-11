using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyBuffItemView2 : UGuiView
{
	public Button btn;

	public GameObject activeIcon;

	public GameObject disactiveIcon;

	public GameObject selActiveRoot;

	public GameObject selDisactiveRoot;

	public GameObject descRoot;

	public RectTransform descBG;

	public TextMeshProUGUI descText;

	public float outerSize;

	public List<string> color;

	private CopyBuffItemViewModel2 viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyBuffItemViewModel2>(userData);
		btn.onClick.AddListener(OnBtnClick);
		SetCopy2Buff();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		SetCopy2Buff();
	}

	private void SetCopy2Buff()
	{
		if (descRoot != null)
		{
			descRoot.gameObject.SetActive(value: false);
			selActiveRoot.gameObject.SetActive(value: false);
			selDisactiveRoot.gameObject.SetActive(value: false);
			activeIcon.gameObject.SetActive(viewModel.IsActive);
			disactiveIcon.gameObject.SetActive(!viewModel.IsActive);
		}
	}

	private void OnBtnClick()
	{
		if (descRoot != null)
		{
			viewModel.SetSelect(!viewModel.IsSelect);
			descRoot.gameObject.SetActive(viewModel.IsSelect);
			((TMP_Text)descText).text = "<color=#" + (viewModel.IsActive ? color[0] : color[1]) + "> ■ </color>" + viewModel.Desc + "<color=#" + (viewModel.IsActive ? color[0] : color[1]) + ">(" + (viewModel.IsActive ? "已激活" : "完成首通后激活") + ")</color>";
			LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)descText).rectTransform);
			descBG.sizeDelta = new Vector2(((TMP_Text)descText).rectTransform.sizeDelta.x + outerSize, descBG.sizeDelta.y);
			selActiveRoot.gameObject.SetActive(viewModel.IsActive && viewModel.IsSelect);
			selDisactiveRoot.gameObject.SetActive(!viewModel.IsActive && viewModel.IsSelect);
			activeIcon.gameObject.SetActive(viewModel.IsActive && !viewModel.IsSelect);
			disactiveIcon.gameObject.SetActive(!viewModel.IsActive && !viewModel.IsSelect);
		}
	}
}
