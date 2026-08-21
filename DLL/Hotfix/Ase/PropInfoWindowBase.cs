using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropInfoWindowBase : UGuiWindow
{
	[SerializeField]
	protected List<Button> btnCloseList;

	[SerializeField]
	protected RectTransform mainRect;

	[SerializeField]
	protected Image qualityTitleImg;

	[SerializeField]
	protected Image qualityImg;

	[SerializeField]
	protected Image propIcon;

	[SerializeField]
	protected GameObject rectIconRoot;

	[SerializeField]
	protected Image propRecIcon;

	[SerializeField]
	protected TextMeshProUGUI propName;

	[SerializeField]
	protected TextMeshProUGUI propDesc;

	[SerializeField]
	protected GameObject ownCountPart;

	[SerializeField]
	protected TextMeshProUGUI curHasText;

	[SerializeField]
	protected GameObject timeLimitObj;

	[SerializeField]
	protected TextMeshProUGUI timeLimitText;

	private PropInfoViewModelBase _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropInfoViewModelBase>();
		BindingSet<PropInfoWindowBase, PropInfoViewModelBase> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((PropInfoWindowBase v) => v.OnDismissRequest).To((PropInfoViewModelBase vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((PropInfoWindowBase v) => v.OpenUguiWindow).To((PropInfoViewModelBase vm) => vm.OpenWindowRequest);
		if (btnCloseList != null)
		{
			foreach (Button btnClose in btnCloseList)
			{
				if (btnClose != null)
				{
					bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PropInfoViewModelBase vm) => ((OptionBase)vm).Close);
					bindingSet.Bind(btnClose.gameObject).For((GameObject v) => v.activeSelf).To((PropInfoViewModelBase vm) => vm.ShowOutsideMask);
				}
			}
		}
		bindingSet.Bind<TextMeshProUGUI>(propName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropInfoViewModelBase vm) => vm.Data.Name);
		if (propIcon != null)
		{
			bindingSet.Bind(propIcon).For((Image v) => v.sprite).ToExpression((PropInfoViewModelBase vm) => vm.Data.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(propIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropInfoViewModelBase vm) => string.IsNullOrEmpty(vm.Data.RectIcon) && !string.IsNullOrEmpty(vm.Data.Icon));
		}
		if (propRecIcon != null && rectIconRoot != null)
		{
			bindingSet.Bind(propRecIcon).For((Image v) => v.sprite).ToExpression((PropInfoViewModelBase vm) => vm.Data.RectIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(rectIconRoot).For((GameObject v) => v.activeSelf).ToExpression((PropInfoViewModelBase vm) => !string.IsNullOrEmpty(vm.Data.RectIcon));
		}
		bindingSet.Bind(qualityTitleImg).For((Image v) => v.sprite).ToExpression((PropInfoViewModelBase vm) => $"Prop_Title_{vm.Data.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityImg).For((Image v) => v.sprite).ToExpression((PropInfoViewModelBase vm) => $"Prop_Bg_{vm.Data.Quality}")
			.WithConversion("ItemIcon");
		if (timeLimitObj != null && (UnityEngine.Object)(object)timeLimitText != null)
		{
			bindingSet.Bind(timeLimitObj).For((GameObject v) => v.activeSelf).ToExpression((PropInfoViewModelBase vm) => (int)vm.Data.PropTimeLimitEnum != 0);
			bindingSet.Bind<TextMeshProUGUI>(timeLimitText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropInfoViewModelBase vm) => string.IsNullOrEmpty(vm.Data.TimeLimitText) ? "限时道具" : $"有效期限:{vm.Data.TimeLimitText}");
		}
		bindingSet.Bind().For((PropInfoWindowBase v) => v.Refresh).To((PropInfoViewModelBase vm) => vm.RefreshRst);
		bindingSet.Bind().For((PropInfoWindowBase v) => v.SetRectInfo).To((PropInfoViewModelBase vm) => vm.RectInfoChangeRst);
		bindingSet.Build();
		Refresh();
	}

	public virtual void RefreshData(PropInfoViewModelBase newVm)
	{
		if (newVm != null)
		{
			_viewModel = newVm;
			this.SetDataContext(newVm);
			Refresh();
		}
	}

	protected virtual void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel != null)
		{
			SetRectInfo();
			RefreshDesc();
			RefreshCurHasCount();
		}
	}

	protected virtual void SetRectInfo(object sender = null, InteractionEventArgs e = null)
	{
		if (!(mainRect == null))
		{
			mainRect.anchoredPosition = _viewModel.Pos;
			mainRect.anchorMin = _viewModel.AnchorMin;
			mainRect.anchorMax = _viewModel.AnchorMax;
			mainRect.pivot = _viewModel.Pivot;
		}
	}

	protected void RefreshDesc()
	{
		if (!((UnityEngine.Object)(object)propDesc == null))
		{
			if (_viewModel.Data.Empty)
			{
				((Component)(object)propDesc).gameObject.SetActive(value: false);
				return;
			}
			((TMP_Text)propDesc).text = _viewModel.Data.Description.Replace("\\n", "\n");
			((Component)(object)propDesc).gameObject.SetActive(value: true);
		}
	}

	protected void RefreshCurHasCount()
	{
		if (ownCountPart == null || (UnityEngine.Object)(object)curHasText == null)
		{
			return;
		}
		if (!_viewModel.ShowOwnCount)
		{
			ownCountPart.SetActive(value: false);
			return;
		}
		PropDataBase data = _viewModel.Data;
		if (data.Empty)
		{
			ownCountPart.SetActive(value: false);
			return;
		}
		int propOwnedCount = PropHelper.GetPropOwnedCount(data.Id);
		((TMP_Text)curHasText).text = $"当前拥有 {propOwnedCount}";
		ownCountPart.SetActive(value: true);
	}
}
