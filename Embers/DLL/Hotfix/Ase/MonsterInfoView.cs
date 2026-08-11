using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MonsterInfoView : UGuiView
{
	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private RectTransform monster;

	[SerializeField]
	private Image monsterIcon;

	[SerializeField]
	private TextMeshProUGUI monsterName;

	[SerializeField]
	private TextMeshProUGUI monsterDesc;

	[SerializeField]
	private GameObject dropPart;

	[SerializeField]
	private Transform dropRoot;

	[SerializeField]
	private MonsterDropItem dropItemTpl;

	private List<MonsterDropItem> dropItems = new List<MonsterDropItem>();

	private MonsterInfoViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<MonsterInfoViewModel>(userData);
		BindingSet<MonsterInfoView, MonsterInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((MonsterInfoView v) => v.OnVisibleChanged).To((MonsterInfoViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((MonsterInfoView v) => v.Close).To((MonsterInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(monsterName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MonsterInfoViewModel vm) => vm.MonsterName);
		bindingSet.Bind<TextMeshProUGUI>(monsterDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MonsterInfoViewModel vm) => vm.MonsterDesc);
		bindingSet.Bind(monsterIcon).For((Image v) => v.sprite).ToExpression((MonsterInfoViewModel vm) => vm.MonsterIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((MonsterInfoViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((MonsterInfoViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind().For((MonsterInfoView v) => v.Refresh).To((MonsterInfoViewModel vm) => vm.RefreshRst);
		bindingSet.Build();
		Refresh();
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		monster.anchorMin = anchorMin;
		monster.anchorMax = anchorMax;
		monster.pivot = pivot;
	}

	public void RefreshData(MonsterInfoViewModel newVm)
	{
		_viewModel = newVm;
		this.SetDataContext(newVm);
		Refresh();
	}

	private async void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		monster.anchoredPosition = _viewModel.Vector2;
		List<KeyValuePair<PropDataBase, int>> drops = _viewModel.Drops;
		if (drops == null || drops.Count <= 0)
		{
			dropPart.SetActive(value: false);
			return;
		}
		for (int i = 0; i < drops.Count; i++)
		{
			if (drops[i].Key != null)
			{
				MonsterDropItemData data = new MonsterDropItemData(drops[i].Key.Name, drops[i].Value);
				if (dropItems.Count <= i)
				{
					MonsterDropItem monsterDropItem = UnityEngine.Object.Instantiate(dropItemTpl, dropRoot);
					dropItems.Add(monsterDropItem);
					monsterDropItem.Init(data);
				}
				else
				{
					dropItems[i].RefreshData(data);
				}
				dropItems[i].gameObject.SetActive(value: true);
			}
		}
		if (dropItems.Count > drops.Count)
		{
			for (int j = drops.Count; j < dropItems.Count; j++)
			{
				dropItems[j].gameObject.SetActive(value: false);
			}
		}
		dropPart.SetActive(value: true);
	}

	private void Close(object sender, InteractionEventArgs e)
	{
		DisMiss();
	}

	private void DisMiss(bool ignoreAnimation = false)
	{
		if (!ignoreAnimation && ExitAnimation != null)
		{
			ExitAnimation.OnEnd(Func).Play();
		}
		else
		{
			Func();
		}
		void Func()
		{
			if (!IsDestroyed() && base.gameObject != null)
			{
				Dispose();
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}
	}

	private void Dispose()
	{
		for (int num = dropItems.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.DestroyImmediate(dropItems[num]);
			dropItems[num] = null;
		}
		dropItems = null;
	}
}
