#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillSettingView : UGuiView
{
	public new TextMeshProUGUI name;

	public LoopListView2 heroList;

	public RectTransform skillListRoot;

	public HCTSkillItemView tempFirst;

	public HCTSkillItemView tempNormal;

	public GameObject line;

	public VerticalLayoutGroup VLG;

	public float skillItemOtherHeight;

	private List<GameObject> lines = new List<GameObject>();

	private List<HCTSkillItemView> skillItems = new List<HCTSkillItemView>();

	private SkillSettingViewModel viewModel;

	private bool needCalculate;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<SkillSettingViewModel>(userData);
		BindingSet<SkillSettingView, SkillSettingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SkillSettingViewModel vm) => vm.Name);
		bindingSet.Bind(this).For((SkillSettingView v) => v.OnOpt).To((SkillSettingViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		heroList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
		tempFirst.gameObject.SetActive(value: false);
		tempNormal.gameObject.SetActive(value: false);
		RefreshSkillRoot();
	}

	private void RefreshSkillRoot()
	{
		int num = 0;
		for (int i = 0; i < viewModel.GetSkillList().Count; i++)
		{
			bool isOriginSkill = viewModel.GetSkillList()[i].Data.IsOriginSkill;
			if ((i != 0) & isOriginSkill)
			{
				if (lines.Count > num)
				{
					lines[num].SetActive(value: true);
				}
				else
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(line, skillListRoot);
					lines.Add(gameObject);
					gameObject.gameObject.SetActive(value: true);
				}
				lines[num].transform.SetSiblingIndex(i + num);
				num++;
			}
			HCTSkillItemView hCTSkillItemView = null;
			for (int j = i; j < skillItems.Count; j++)
			{
				if (skillItems[j].IsOriSkillItem == isOriginSkill)
				{
					hCTSkillItemView = skillItems[j];
					skillItems.RemoveAt(j);
					break;
				}
			}
			if (hCTSkillItemView == null)
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(isOriginSkill ? tempFirst.gameObject : tempNormal.gameObject, skillListRoot);
				if (!(gameObject2 != null))
				{
					Log.Error("创建预制体出现异常！");
					return;
				}
				hCTSkillItemView = gameObject2.GetComponent<HCTSkillItemView>();
				hCTSkillItemView.IsOriSkillItem = isOriginSkill;
			}
			hCTSkillItemView.Init(viewModel.GetSkillList()[i]);
			hCTSkillItemView.transform.SetParent(skillListRoot);
			hCTSkillItemView.transform.SetSiblingIndex(i + num);
			hCTSkillItemView.gameObject.SetActive(value: true);
			hCTSkillItemView.SetSkinIconStyle(1f, 1f);
			hCTSkillItemView.HasConsumeBar2();
			skillItems.Insert(i, hCTSkillItemView);
		}
		for (int k = viewModel.GetSkillList().Count; k < skillItems.Count; k++)
		{
			skillItems[k].gameObject.SetActive(value: false);
		}
		for (int l = num; l < lines.Count; l++)
		{
			lines[l].gameObject.SetActive(value: false);
		}
		needCalculate = true;
	}

	private void Update()
	{
		if (!needCalculate)
		{
			return;
		}
		needCalculate = false;
		float num = VLG.padding.top + VLG.padding.bottom;
		for (int i = 0; i < lines.Count; i++)
		{
			if (lines[i].gameObject.activeSelf)
			{
				num += lines[i].GetComponent<RectTransform>().rect.height;
			}
		}
		for (int j = 0; j < skillItems.Count; j++)
		{
			if (skillItems[j].gameObject.activeSelf)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)skillItems[j].descText).rectTransform);
				skillItems[j].RectTransform.sizeDelta = new Vector2(((TMP_Text)skillItems[j].descText).rectTransform.sizeDelta.x, skillItemOtherHeight + ((TMP_Text)skillItems[j].descText).rectTransform.rect.height);
				num += skillItems[j].RectTransform.rect.height;
			}
		}
		skillListRoot.sizeDelta = new Vector2(skillListRoot.sizeDelta.x, num);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<SkillSettingViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshSkillList".Equals(optName))
		{
			RefreshSkillRoot();
		}
	}

	private LoopListViewItem2 OnGetTeamItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TeamItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TeamItem");
		if (loopListViewItem != null)
		{
			CopyTeamItemView component = loopListViewItem.GetComponent<CopyTeamItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
			component.CurIndex = index;
		}
		return loopListViewItem;
	}
}
