using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillDescView : UGuiView
{
	[SerializeField]
	private RectTransform selPos;

	[SerializeField]
	private Button btnOpen;

	[SerializeField]
	private GameObject root;

	[SerializeField]
	private Button btnBack;

	private List<SkillBtnInfo> skillBtnInfos;

	[SerializeField]
	private List<RectTransform> skill4List;

	[SerializeField]
	private List<RectTransform> arrowList;

	[SerializeField]
	private Transform skill_4_Root;

	[SerializeField]
	private Transform skill_3_Root;

	[SerializeField]
	private SkillTabItemView skillTabItemView;

	[SerializeField]
	private LoopListView2 tabList;

	[SerializeField]
	private SkillDescPopView popView;

	private SkillDescViewModel viewModel;

	private int curCount;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<SkillDescViewModel>(userData);
		BindingSet<SkillDescView, SkillDescViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((SkillDescView v) => v.OnVisibleChanged).To((SkillDescViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((SkillDescView v) => v.UpdateIcon).To((SkillDescViewModel vm) => vm.UpdateSkillBtnRequest);
		bindingSet.Build();
		skillBtnInfos = new List<SkillBtnInfo>();
		btnOpen.onClick.AddListener(Open);
		btnBack.onClick.AddListener(Close);
		UpdateSkillBtn();
		root.gameObject.SetActive(value: false);
		popView.gameObject.SetActive(value: false);
	}

	private void UpdateIcon(object sender, InteractionEventArgs e)
	{
		UpdateSkillBtn();
		UpdateBtnIcon();
	}

	private void Close()
	{
		root.gameObject.SetActive(value: false);
	}

	private void Open()
	{
		root.gameObject.SetActive(value: true);
		if (!skillTabItemView.IsInit)
		{
			skillTabItemView.Init(viewModel.CurSkill);
		}
		else
		{
			skillTabItemView.RefreshData(viewModel.CurSkill);
		}
		UpdateBtnIcon();
		if (!tabList.IsInited)
		{
			tabList.InitListView(viewModel.TabVmList.Count, OnGetTabItemByIndex);
			return;
		}
		tabList.SetListItemCount(viewModel.TabVmList.Count);
		tabList.RefreshAllShownItem();
	}

	public void RefreshData(SkillDescViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	public void UpdateSkillBtn()
	{
		if (curCount == viewModel.SkillCount)
		{
			return;
		}
		skill_3_Root.gameObject.SetActive(viewModel.SkillCount == 3);
		skill_4_Root.gameObject.SetActive(viewModel.SkillCount == 4);
		skillBtnInfos.Clear();
		SkillBtnInfo[] array = null;
		if (viewModel.SkillCount == 3)
		{
			array = skill_3_Root.GetComponentsInChildren<SkillBtnInfo>();
		}
		else if (viewModel.SkillCount == 4)
		{
			array = skill_4_Root.GetComponentsInChildren<SkillBtnInfo>();
		}
		RectTransform rectTransform = null;
		for (int i = 0; i < array.Length; i++)
		{
			skillBtnInfos.Add(array[i]);
			if (array[i].key == HeroSkillTypeEnum.Skill4)
			{
				rectTransform = array[i].GetComponent<RectTransform>();
			}
		}
		if (rectTransform != null)
		{
			for (int j = 0; j < skill4List.Count; j++)
			{
				if (skill4List[j].name.Equals("Skill4_" + viewModel.HeroAttri))
				{
					skill4List[j].gameObject.SetActive(value: true);
					skill4List[j].anchoredPosition = rectTransform.anchoredPosition;
				}
				else
				{
					skill4List[j].gameObject.SetActive(value: false);
				}
			}
		}
		else
		{
			for (int k = 0; k < skill4List.Count; k++)
			{
				skill4List[k].gameObject.SetActive(value: false);
			}
		}
		foreach (SkillBtnInfo skillBtnInfo in skillBtnInfos)
		{
			skillBtnInfo.Init(UpdateSelect);
		}
	}

	public void UpdateBtnIcon()
	{
		foreach (SkillBtnInfo skillBtnInfo in skillBtnInfos)
		{
			skillBtnInfo.LoadImg(viewModel.GetIconName(skillBtnInfo.key));
			if (viewModel.CurOpt == skillBtnInfo.key)
			{
				UpdateSelect(skillBtnInfo);
			}
			skillBtnInfo.UpdateTag(viewModel.GetTagName(skillBtnInfo.key));
		}
	}

	private void UpdateSelect(SkillBtnInfo btn)
	{
		selPos.anchoredPosition = btn.pos.anchoredPosition + btn.GetComponent<RectTransform>().anchoredPosition;
		selPos.localScale = btn.pos.localScale;
		if (viewModel.CurOpt != btn.key)
		{
			viewModel.UpdateSelectSkill(btn.key);
		}
		for (int i = 0; i < arrowList.Count; i++)
		{
			if (arrowList[i].name.Equals("Arrow_Up") || arrowList[i].name.Equals("Arrow_Down"))
			{
				arrowList[i].anchoredPosition = new Vector2(selPos.anchoredPosition.x, arrowList[i].anchoredPosition.y);
			}
			else
			{
				arrowList[i].anchoredPosition = new Vector2(arrowList[i].anchoredPosition.x, selPos.anchoredPosition.y);
			}
		}
	}

	private LoopListViewItem2 OnGetTabItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TabVmList.Count)
		{
			return null;
		}
		viewModel.IsOptRole(index);
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TabItem");
		if (loopListViewItem != null)
		{
			SkillTabItemView component = loopListViewItem.GetComponent<SkillTabItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TabVmList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TabVmList[index]);
			}
		}
		return loopListViewItem;
	}

	public void HidePop()
	{
		popView.gameObject.SetActive(value: false);
	}

	public void ShowPop(HeroSkillData skill, RectTransform rectTransform)
	{
		popView.Init(skill, rectTransform);
		popView.gameObject.SetActive(value: true);
	}
}
