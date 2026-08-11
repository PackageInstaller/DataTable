using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HCTalentView : HeroCultivateView
{
	[SerializeField]
	protected RectTransform descPos1;

	[SerializeField]
	protected RectTransform descPos2;

	[SerializeField]
	protected RectTransform pos;

	[SerializeField]
	private RectTransform pos2;

	[SerializeField]
	private LoadUISprite lampIcon;

	[SerializeField]
	private Transform branch;

	[SerializeField]
	private List<TalentLamp> talentLampConfig;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	protected Transform skillDescView;

	[SerializeField]
	private Button btnCloseDesc;

	[SerializeField]
	protected HCTDescView hctDescView;

	[SerializeField]
	private AutoDispose effect_big;

	[SerializeField]
	private AutoDispose effect_small;

	protected Vector3 p1;

	protected float descWidth;

	private int allBigProgress;

	private HCTPointItemView[] itemViews;

	private HCTalentViewModel viewModel;

	public int AllBigProgress
	{
		get
		{
			return allBigProgress;
		}
		set
		{
			allBigProgress = value;
			_ = talentLampConfig;
			for (int i = 0; i < talentLampConfig.Count; i++)
			{
				if (allBigProgress >= talentLampConfig[i].minLevel && allBigProgress <= talentLampConfig[i].maxLevel)
				{
					lampIcon.Path = talentLampConfig[i].imageName;
					talentLampConfig[i].animationGo.SetActive(value: true);
				}
				else
				{
					talentLampConfig[i].animationGo.SetActive(value: false);
				}
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<HCTalentViewModel>(userData);
		BindingSet<HCTalentView, HCTalentViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HCTalentView v) => v.AllBigProgress).To((HCTalentViewModel vm) => vm.AllProgress);
		bindingSet.Bind(this).For((HCTalentView v) => v.PlayOpenEffect).To((HCTalentViewModel vm) => vm.PlayOpenEffectRequest);
		bindingSet.Bind(this).For((HCTalentView v) => v.ShowDesc).To((HCTalentViewModel vm) => vm.ShowDescViewRequest);
		bindingSet.Bind(this).For((HCTalentView v) => v.BindPoint).To((HCTalentViewModel vm) => vm.BindPointRequest);
		bindingSet.Bind(this).For((HCTalentView v) => v.OnCancel).To((HCTalentViewModel vm) => vm.OnCancelRequest);
		bindingSet.Bind(btnCloseDesc).For((Button v) => v.onClick).To((HCTalentViewModel vm) => vm.CancelSelectSkill);
		bindingSet.Build();
	}

	public virtual void OnInitAfter()
	{
		moneyView.Init(new MoneyViewModel(viewModel.Parent));
		hctDescView.Init(viewModel.DescVm);
		hctDescView.gameObject.SetActive(value: false);
		skillDescView.gameObject.SetActive(value: false);
		BindPoints();
		hctDescView.transform.SetParent(base.transform.parent.transform.parent);
		skillDescView.SetParent(base.transform.parent.transform.parent);
		descPos1.SetParent(base.transform.parent.transform.parent);
		descPos1.anchoredPosition = new Vector2(0f, descPos1.anchoredPosition.y);
		descPos2.SetParent(base.transform.parent.transform.parent);
		descPos2.anchoredPosition = new Vector2(hctDescView.RectTransform.rect.width, descPos2.anchoredPosition.y);
		descWidth = hctDescView.RectTransform.sizeDelta.x / 2f;
		p1 = pos.anchoredPosition;
		effect_big.AddDisposeAction(delegate(GameObject e)
		{
			e.gameObject.SetActive(value: false);
		});
		effect_small.AddDisposeAction(delegate(GameObject e)
		{
			e.gameObject.SetActive(value: false);
		});
	}

	protected override void OnEnable()
	{
		if (viewModel != null)
		{
			viewModel.CheckAllPointState();
			viewModel.RefreshSkillItems();
			BindPoints();
		}
	}

	private void PlayOpenEffect(object sender, InteractionEventArgs e)
	{
		HCTPointItemViewModel vm = (HCTPointItemViewModel)e.Context;
		for (int i = 0; i < itemViews.Length; i++)
		{
			if (itemViews[i].CheckVM(vm))
			{
				if (itemViews[i].PointType == HCSPointType.Big)
				{
					itemViews[i].PlayEffect(effect_big);
				}
				else
				{
					itemViews[i].PlayEffect(effect_small);
				}
				break;
			}
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		pos.anchoredPosition = p1;
		hctDescView.gameObject.SetActive(value: false);
		skillDescView.gameObject.SetActive(value: false);
	}

	private void ShowDesc(object sender, InteractionEventArgs e)
	{
		hctDescView.gameObject.SetActive(value: true);
		pos.anchoredPosition = pos2.anchoredPosition;
		skillDescView.gameObject.SetActive(value: false);
	}

	protected void BindPoints()
	{
		if (itemViews == null)
		{
			itemViews = branch.GetComponentsInChildren<HCTPointItemView>();
		}
		if (viewModel.ItemVMs == null || itemViews == null)
		{
			return;
		}
		for (int i = 0; i < itemViews.Length; i++)
		{
			HCTPointItemViewModel pointVM = viewModel.GetPointVM(itemViews[i].PointType, itemViews[i].Order);
			if (pointVM != null)
			{
				itemViews[i].Init(pointVM);
			}
		}
	}

	private void BindPoint(object sender, InteractionEventArgs e)
	{
		BindPoints();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<HCTalentViewModel>(userData);
		this.SetDataContext(viewModel);
		BindPoints();
	}

	private LoopListViewItem2 OnGetSkillItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SkillList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("SkillItem");
		if (loopListViewItem != null)
		{
			HCTSkillItemView component = loopListViewItem.GetComponent<HCTSkillItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SkillList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SkillList[index]);
			}
		}
		return loopListViewItem;
	}

	private void OnCancel(object sender, InteractionEventArgs e)
	{
		skillDescView.gameObject.SetActive(value: false);
		hctDescView.gameObject.SetActive(value: false);
		pos.anchoredPosition = new Vector2(0f, 0f);
	}
}
