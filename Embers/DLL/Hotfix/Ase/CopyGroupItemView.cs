using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyGroupItemView : CopyPlayUnlockEffectItemView
{
	public bool isMiniTab;

	public RectTransform pos1;

	public RectTransform pos2;

	public RectTransform root;

	public Button btnOpen;

	public TextMeshProUGUI index;

	public new TextMeshProUGUI name;

	public GameObject lockRoot;

	public Button btnLock;

	public GameObject activeRoot;

	public GameObject redRoot;

	public LoadUISprite icon1;

	public LoadUISprite icon2;

	public TextMeshProUGUI name2;

	public GameObject select;

	public ItemSOConfig soConfig;

	private int curIndex;

	private CopyGroupItemViewModel viewModel;

	public int CurIndex
	{
		get
		{
			return curIndex;
		}
		set
		{
			curIndex = value;
			((TMP_Text)index).text = $"{viewModel.Data.CopyIndex}";
			if (!isMiniTab)
			{
				if (viewModel.Data.CopyIndex % 2 == 0)
				{
					root.anchoredPosition = pos2.anchoredPosition;
				}
				else
				{
					root.anchoredPosition = pos1.anchoredPosition;
				}
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyGroupItemViewModel>(userData);
		BindingSet<CopyGroupItemView, CopyGroupItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (isMiniTab)
		{
			bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyGroupItemViewModel vm) => vm.Data.CopyMainName);
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyGroupItemViewModel vm) => vm.Data.CopyMainName);
			bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((CopyGroupItemViewModel vm) => vm.IsSelect);
			bindingSet.Bind(btnOpen).For((Button v) => v.onClick).To((CopyGroupItemViewModel vm) => vm.OptCommand);
			bindingSet.Bind(((Component)(object)name).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyGroupItemViewModel vm) => !vm.IsSelect);
			bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyGroupItemViewModel vm) => vm.Data.HasNew);
		}
		else
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyGroupItemViewModel vm) => vm.Data.CopyMainName);
			bindingSet.Bind(btnOpen).For((Button v) => v.onClick).To((CopyGroupItemViewModel vm) => vm.OptCommand);
			bindingSet.Bind().For((CopyGroupItemView v) => v.OnOpt).To((CopyGroupItemViewModel vm) => vm.OptRequest);
			bindingSet.Bind(this).For((CopyGroupItemView v) => v.CurIndex).To((CopyGroupItemViewModel vm) => vm.Data.CopyIndex);
			bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyGroupItemViewModel vm) => vm.Data.IsLock || !vm.Data.HasPlayUnlock);
			bindingSet.Bind(activeRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyGroupItemViewModel vm) => !vm.Data.IsLock && vm.Data.HasPlayUnlock);
			bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyGroupItemViewModel vm) => vm.Data.HasNew);
			bindingSet.Bind(icon1).For((LoadUISprite v) => v.Path).ToExpression((CopyGroupItemViewModel vm) => $"Copy/CopySelect/{vm.Data.Icon}");
			bindingSet.Bind(icon2).For((LoadUISprite v) => v.Path).ToExpression((CopyGroupItemViewModel vm) => $"Copy/CopySelect/{vm.Data.Icon}");
		}
		bindingSet.Build();
		if (viewModel.ServiceId != 0 && soConfig != null)
		{
			soConfig.SetServiceId(viewModel.ServiceId);
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyGroupItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	public void AddSOControl(ViewSOControl soControl)
	{
		if (!(soControl == null) && !(soConfig == null))
		{
			soControl.AddItems(soConfig);
		}
	}
}
