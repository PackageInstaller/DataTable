using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachSkillTaskWindow : UGuiWindow
{
	private TeachSkillTaskViewModel _viewModel;

	[SerializeField]
	private TextMeshProUGUI teachName;

	[SerializeField]
	private TextMeshProUGUI teachContent;

	[SerializeField]
	private TextMeshProUGUI finishDesc;

	[SerializeField]
	private Button finishLevelBtn;

	[SerializeField]
	private GameObject finshLevelEffect;

	[SerializeField]
	private GameObject teachContetnRoot;

	[SerializeField]
	private GameObject functionPanel;

	[SerializeField]
	private Button expandGMBtn;

	[SerializeField]
	private Button putGMBtn;

	[SerializeField]
	private CanvasGroup gmContentCanvasGroup;

	[SerializeField]
	private GameObject emptyMask;

	[SerializeField]
	private GameObject otherShow;

	[SerializeField]
	private Button btn_refreshCD;

	[SerializeField]
	private Image img_trgger_refreshCD;

	[SerializeField]
	private Button btn_energy;

	[SerializeField]
	private GameObject go_energy_open;

	[SerializeField]
	private Button btn_sp;

	[SerializeField]
	private GameObject go_sp_open;

	[SerializeField]
	private Color triggerColor = new Color(0.75686276f, 31f / 51f, 0.38039216f, 20f / 51f);

	[SerializeField]
	private Animation skillTaskAni;

	private Tween showTeachTextTween;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachSkillTaskViewModel>();
		BindingSet<TeachSkillTaskWindow, TeachSkillTaskViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(finishLevelBtn.gameObject).For((GameObject v) => v.activeSelf).To((TeachSkillTaskViewModel vm) => vm.ShowFinishLevelBtn);
		bindingSet.Bind(functionPanel).For((GameObject v) => v.activeSelf).To((TeachSkillTaskViewModel vm) => vm.ShowFinishLevelBtn);
		bindingSet.Bind(this).For((TeachSkillTaskWindow v) => v.OnDismissRequest).To((TeachSkillTaskViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(functionPanel).For((GameObject v) => v.activeSelf).To((TeachSkillTaskViewModel vm) => vm.ShowFinishLevelBtn);
		bindingSet.Bind(finishLevelBtn).For((Button v) => v.onClick).To((TeachSkillTaskViewModel vm) => vm.OnClickFinish);
		bindingSet.Bind(this).For((TeachSkillTaskWindow v) => v.OnSkillTaskUpdate).To((TeachSkillTaskViewModel vm) => vm.TeachSkillTaskUpdate);
		bindingSet.Build();
		btn_refreshCD.onClick.AddListener(OnBtn_RefreshCD);
		btn_energy.onClick.AddListener(OnBtn_Energy);
		btn_sp.onClick.AddListener(OnBtn_Sp);
		expandGMBtn.onClick.AddListener(OnClickExpandBtn);
		putGMBtn.onClick.AddListener(OnClickExpandBtn);
		finishLevelBtn.onClick.AddListener(OnClickFinishBtn);
		expandGMBtn.gameObject.SetActive(_viewModel.IsExpand);
		putGMBtn.gameObject.SetActive(!_viewModel.IsExpand);
	}

	protected override void OnShow()
	{
		base.OnShow();
		emptyMask.SetActive(value: true);
		otherShow.SetActive(value: false);
		teachContetnRoot.SetActive(_viewModel.ShowTeachContent);
		SetTeachText();
	}

	public void HideEmptyMask()
	{
		emptyMask.SetActive(value: false);
		otherShow.SetActive(value: true);
	}

	public void ShowEmptyMask()
	{
		emptyMask.SetActive(value: true);
	}

	private void OnBtn_RefreshCD()
	{
		_viewModel.OnClickGM(BattleGMEnum.RefreshCD);
		OnUpdateGMState(BattleGMEnum.RefreshCD, isOpen: true);
	}

	private void OnBtn_Energy()
	{
		_viewModel.OnClickGM(BattleGMEnum.InfiniteEnergy);
		OnUpdateGMState(BattleGMEnum.InfiniteEnergy, _viewModel.InfiniteEnergy);
	}

	private void OnBtn_Sp()
	{
		_viewModel.OnClickGM(BattleGMEnum.InfiniteSp);
		OnUpdateGMState(BattleGMEnum.InfiniteSp, _viewModel.InfiniteSp);
	}

	private void OnClickFinishBtn()
	{
		_viewModel.OnClickFinish();
		((TMP_Text)finishDesc).text = "正在退出关卡中";
		finshLevelEffect.SetActive(value: false);
	}

	private void OnClickExpandBtn()
	{
		_viewModel.OnClickExpand();
		DOTweenModuleUI.DOFade(gmContentCanvasGroup, (float)(_viewModel.IsExpand ? 1 : 0), 0.1f);
		gmContentCanvasGroup.interactable = _viewModel.IsExpand;
		expandGMBtn.gameObject.SetActive(_viewModel.IsExpand);
		putGMBtn.gameObject.SetActive(!_viewModel.IsExpand);
	}

	private void OnUpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		switch (gmEnum)
		{
		case BattleGMEnum.RefreshCD:
			DOTweenModuleUI.DOColor(img_trgger_refreshCD, triggerColor, 0.1f).OnComplete(delegate
			{
				DOTweenModuleUI.DOColor(img_trgger_refreshCD, Color.clear, 0.1f);
			});
			break;
		case BattleGMEnum.InfiniteEnergy:
			go_energy_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.InfiniteSp:
			go_sp_open?.SetActive(isOpen);
			break;
		}
	}

	private void OnSkillTaskUpdate(object sender, InteractionEventArgs args)
	{
		if ((bool)args.Context)
		{
			skillTaskAni.Play("Teaching_out_2");
		}
		else if (_viewModel.LastTeachContentIsEmpty)
		{
			SetTeachText();
			skillTaskAni.Play("Teaching_enter_1");
			teachContetnRoot.SetActive(_viewModel.ShowTeachContent);
		}
		else if (!_viewModel.LastTeachContentIsEmpty && !string.IsNullOrEmpty(_viewModel.TeachContent))
		{
			DelaySetTeachText(0.3f);
			skillTaskAni.Play("Teaching_replay");
			teachContetnRoot.SetActive(_viewModel.ShowTeachContent);
		}
		else if (!_viewModel.LastTeachContentIsEmpty && string.IsNullOrEmpty(_viewModel.TeachContent))
		{
			skillTaskAni.Play("Teaching_out_2");
		}
	}

	private void DelaySetTeachText(float delayTime)
	{
		if (delayTime > 0f)
		{
			if (showTeachTextTween != null)
			{
				DOTween.Kill(showTeachTextTween);
				showTeachTextTween = null;
			}
			showTeachTextTween = DOTweenModuleUI.DOFade(CanvasGroup, 1f, delayTime).OnComplete(delegate
			{
				SetTeachText();
				showTeachTextTween = null;
			});
		}
		else
		{
			SetTeachText();
		}
	}

	private void SetTeachText()
	{
		((TMP_Text)teachContent).text = _viewModel.TeachContent;
		((TMP_Text)teachName).text = _viewModel.TeachName;
	}
}
