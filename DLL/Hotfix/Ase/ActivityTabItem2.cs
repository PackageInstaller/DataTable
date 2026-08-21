using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityTabItem2 : UGuiView
{
	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private TextMeshProUGUI normalText;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private TextMeshProUGUI selectText;

	[SerializeField]
	private GameObject redPointObj;

	[SerializeField]
	private GameObject finishObj;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private Button button;

	[SerializeField]
	private Button[] otherBtns;

	[SerializeField]
	private GameObject activeObj;

	[SerializeField]
	private GameObject timeIcon;

	[SerializeField]
	private TextMeshProUGUI lockDes;

	[SerializeField]
	private TextMeshProUGUI finishProportion;

	[SerializeField]
	private GameObject passAllLevelObj;

	[SerializeField]
	private GameObject areaRedPoint;

	private ActivityTabItemData2 viewModel;

	public virtual void Init(ActivityTabItemData2 viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ActivityTabItem2, ActivityTabItemData2> bindingSet = this.CreateBindingSet(viewModel);
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData2 vm) => !vm.IsSelect);
		}
		if ((UnityEngine.Object)(object)normalText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(normalText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTabItemData2 vm) => vm.TagName);
		}
		if (select != null)
		{
			bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((ActivityTabItemData2 vm) => vm.IsSelect);
		}
		if ((UnityEngine.Object)(object)selectText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(selectText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTabItemData2 vm) => vm.TagName);
		}
		if (redPointObj != null)
		{
			bindingSet.Bind(redPointObj).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData2 vm) => (int)vm.StateEnum == 2);
		}
		if (finishObj != null)
		{
			bindingSet.Bind(finishObj).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData2 vm) => (int)vm.StateEnum == 1);
		}
		if (lockObj != null)
		{
			bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData2 vm) => (int)vm.StateEnum == 3);
		}
		if ((UnityEngine.Object)(object)lockDes != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(lockDes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTabItemData2 vm) => vm.LockDes);
		}
		if ((UnityEngine.Object)(object)finishProportion != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(finishProportion).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTabItemData2 vm) => vm.ActivityfinishDes);
		}
		if (activeObj != null)
		{
			bindingSet.Bind(activeObj).For((GameObject v) => v.activeSelf).ToExpression((ActivityTabItemData2 vm) => (int)vm.StateEnum != 3);
		}
		if (passAllLevelObj != null)
		{
			bindingSet.Bind(passAllLevelObj).For((GameObject v) => v.activeSelf).To((ActivityTabItemData2 vm) => vm.PassAllLevel);
		}
		if (timeIcon != null)
		{
			bindingSet.Bind(timeIcon).For((GameObject v) => v.activeSelf).To((ActivityTabItemData2 vm) => vm.TimeLock);
		}
		if (areaRedPoint != null)
		{
			bindingSet.Bind(areaRedPoint).For((GameObject v) => v.activeSelf).To((ActivityTabItemData2 vm) => vm.AreaRedPoint);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((ActivityTabItemData2 vm) => vm.BtnOnClick);
		}
		if (otherBtns != null)
		{
			for (int num = 0; num < otherBtns.Length; num++)
			{
				if (otherBtns[num] != null)
				{
					bindingSet.Bind(otherBtns[num]).For((Button v) => v.onClick).To((ActivityTabItemData2 vm) => vm.BtnOnClick);
				}
			}
		}
		bindingSet.Build();
	}

	public void RefreshData(ActivityTabItemData2 viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
