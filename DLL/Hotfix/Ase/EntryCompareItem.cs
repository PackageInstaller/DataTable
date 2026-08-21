using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EntryCompareItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject bg;

	[SerializeField]
	private GameObject speBg;

	[SerializeField]
	private GameObject fixBg;

	[SerializeField]
	private TextMeshProUGUI entryName;

	[SerializeField]
	private TextMeshProUGUI entryValue;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private RectTransform gridBgRoot;

	[SerializeField]
	private GameObject gridBgTpl;

	[SerializeField]
	private RectTransform gridRoot;

	[SerializeField]
	private GameObject gridTpl;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private List<GameObject> newGos;

	[SerializeField]
	private List<GameObject> disappearGos;

	[SerializeField]
	private List<GameObject> upGos;

	[SerializeField]
	private List<GameObject> downGos;

	[SerializeField]
	private Color normalColor;

	[SerializeField]
	private Color upColor;

	[SerializeField]
	private Color downColor;

	private GameObjectPool _gridBgPool;

	private GameObjectPool _gridPool;

	private EntryCompareItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<EntryCompareItemData>(userData);
		BindingSet<EntryCompareItem, EntryCompareItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((EntryCompareItemData vm) => vm.OnClick);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((EntryCompareItemData vm) => vm.IsSelected);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((EntryCompareItemData vm) => vm.EntryChangeData.EntryData.IconPath)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)entryName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((EntryCompareItemData vm) => vm.EntryChangeData.EntryData.Name);
		}
		if ((UnityEngine.Object)(object)entryValue != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((EntryCompareItemData vm) => $"Lv.{vm.EntryChangeData.CurLevel}");
		}
		if (bg != null)
		{
			bindingSet.Bind(bg).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => !vm.EntryChangeData.EntryData.IsSpecial && !vm.EntryChangeData.EntryData.IsFixed);
		}
		if (speBg != null)
		{
			bindingSet.Bind(speBg).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => vm.EntryChangeData.EntryData.IsSpecial && !vm.EntryChangeData.EntryData.IsFixed);
		}
		if (fixBg != null)
		{
			bindingSet.Bind(fixBg).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => vm.EntryChangeData.EntryData.IsFixed);
		}
		if (newGos != null)
		{
			foreach (GameObject newGo in newGos)
			{
				if (!(newGo == null))
				{
					bindingSet.Bind(newGo).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => (int)vm.ChangeEnum == 1);
				}
			}
		}
		if (disappearGos != null)
		{
			foreach (GameObject disappearGo in disappearGos)
			{
				if (!(disappearGo == null))
				{
					bindingSet.Bind(disappearGo).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => (int)vm.ChangeEnum == 2);
				}
			}
		}
		if (upGos != null)
		{
			foreach (GameObject upGo in upGos)
			{
				if (!(upGo == null))
				{
					bindingSet.Bind(upGo).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => (int)vm.ChangeEnum == 3);
				}
			}
		}
		if (downGos != null)
		{
			foreach (GameObject downGo in downGos)
			{
				if (!(downGo == null))
				{
					bindingSet.Bind(downGo).For((GameObject v) => v.activeSelf).ToExpression((EntryCompareItemData vm) => (int)vm.ChangeEnum == 4);
				}
			}
		}
		bindingSet.Build();
		if (gridBgRoot != null && gridBgTpl != null)
		{
			_gridBgPool = new GameObjectPool(gridBgTpl, gridBgRoot);
		}
		if (gridRoot != null && gridTpl != null)
		{
			_gridPool = new GameObjectPool(gridTpl, gridRoot);
		}
		RefreshGrids();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is EntryCompareItemData entryCompareItemData)
		{
			_viewModel = entryCompareItemData;
			this.SetDataContext(entryCompareItemData);
			RefreshGrids();
		}
	}

	private void RefreshGrids()
	{
		if (_gridBgPool == null || _gridPool == null)
		{
			return;
		}
		_gridBgPool.RecycleAll();
		_gridPool.RecycleAll();
		if (_viewModel?.EntryChangeData?.EntryData == null)
		{
			return;
		}
		EntryChangeData entryChangeData = _viewModel.EntryChangeData;
		for (int i = 0; i < entryChangeData.EntryData.MaxLevel; i++)
		{
			_gridBgPool.Allocate();
		}
		int a = 0;
		int num = -1;
		Color color = new Color(0f, 0f, 0f, 0f);
		if (entryChangeData.ChangeEnum == EntryChangeEnum.New)
		{
			a = entryChangeData.CurLevel;
			num = entryChangeData.CurLevel - 1;
		}
		else if (entryChangeData.ChangeEnum == EntryChangeEnum.Disappear)
		{
			a = 0;
			num = -1;
		}
		else if (entryChangeData.ChangeEnum == EntryChangeEnum.Add)
		{
			a = entryChangeData.CurLevel;
			num = entryChangeData.OriLevel - 1;
			color = upColor;
		}
		else if (entryChangeData.ChangeEnum == EntryChangeEnum.Reduce)
		{
			a = entryChangeData.OriLevel;
			num = entryChangeData.CurLevel - 1;
			color = downColor;
		}
		a = Mathf.Min(a, entryChangeData.EntryData.MaxLevel);
		for (int j = 0; j < a; j++)
		{
			Image component = _gridPool.Allocate().GetComponent<Image>();
			if (!(component == null))
			{
				component.rectTransform.SetSiblingIndex(j);
				if (j <= num)
				{
					component.color = normalColor;
				}
				else
				{
					component.color = color;
				}
			}
		}
	}

	protected override void OnDestroy()
	{
		_gridBgPool?.Dispose();
		_gridBgPool = null;
		_gridPool?.Dispose();
		_gridPool = null;
		base.OnDestroy();
	}
}
