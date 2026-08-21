using System.Collections.Generic;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachSkillComboWindow : UGuiWindow
{
	private TeachSkillComboViewModel _viewModel;

	[SerializeField]
	private GameObject skillItemPrefab;

	[SerializeField]
	private RectTransform lessRect;

	[SerializeField]
	private RectTransform moreRect;

	[SerializeField]
	private RectMask2D rectMask2D;

	[SerializeField]
	private GameObject finishTitle;

	[SerializeField]
	private CanvasGroup skillComboCanvesGroup;

	[SerializeField]
	private float moveItemDis = 158f;

	[SerializeField]
	private float itemWidth = 158f;

	private Tween failTween;

	private bool moreSkillItem;

	private float skillItemParentLocalX;

	private RectTransform skillItemParent;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachSkillComboViewModel>();
		if (_viewModel == null || _viewModel.IsCloseView)
		{
			Close();
			return;
		}
		BindingSet<TeachSkillComboWindow, TeachSkillComboViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((TeachSkillComboWindow v) => v.OnSkillComboFail).To((TeachSkillComboViewModel vm) => vm.SkillComboFailRequest);
		bindingSet.Bind().For((TeachSkillComboWindow v) => v.OnskillComboStartNext).To((TeachSkillComboViewModel vm) => vm.SkillComboStartNextRequest);
		bindingSet.Bind().For((TeachSkillComboWindow v) => v.OnDismissRequest).To((TeachSkillComboViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		LoadSkillItem();
	}

	private void LoadSkillItem()
	{
		List<SkillComboViewModel> allSkillCombos = _viewModel.AllSkillCombos;
		moreSkillItem = allSkillCombos.Count > 5;
		skillItemParent = ((!moreSkillItem) ? lessRect : moreRect);
		skillItemParentLocalX = skillItemParent.transform.localPosition.x;
		rectMask2D.enabled = moreSkillItem;
		for (int i = 0; i < allSkillCombos.Count; i++)
		{
			GameObject obj = Object.Instantiate(skillItemPrefab, skillItemParent.transform);
			obj.transform.localPosition = new Vector3((float)i * itemWidth, 0f, 0f);
			obj.SetActive(value: true);
			obj.GetComponent<SkillComboView>().Init(allSkillCombos[i]);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		_viewModel.ShowAction();
	}

	private void OnSkillComboFail(object sender, InteractionEventArgs e)
	{
		SkillComboState skillComboState = _viewModel.SkillComboState;
		if (failTween != null && failTween.IsPlaying())
		{
			failTween.Kill(complete: true);
			failTween = null;
		}
		if (skillComboState == SkillComboState.FailHide)
		{
			failTween = DOTweenModuleUI.DOFade(skillComboCanvesGroup, 0f, 0.1f);
		}
		if (skillComboState == SkillComboState.FailShow)
		{
			Vector3 localPosition = skillItemParent.transform.localPosition;
			localPosition.x = skillItemParentLocalX;
			skillItemParent.transform.localPosition = localPosition;
			failTween = DOTweenModuleUI.DOFade(skillComboCanvesGroup, 1f, 0.1f);
		}
	}

	private void OnskillComboStartNext(object sender, InteractionEventArgs e)
	{
		if (_viewModel.SkillComboState == SkillComboState.FinishAll)
		{
			DOTweenModuleUI.DOFade(skillComboCanvesGroup, 0f, 0.1f).SetDelay(0.5f).OnComplete(delegate
			{
				finishTitle.SetActive(value: true);
			});
		}
		else if (_viewModel.AllSkillCombos.Count > 5 && _viewModel.CurrentIndex >= 2)
		{
			skillItemParent.transform.DOLocalMoveX(skillItemParent.transform.localPosition.x - moveItemDis, 0.2f);
		}
	}

	public void CloseWindow()
	{
		Close();
	}
}
