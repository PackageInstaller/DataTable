using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class TouchInputWindow : UGuiWindow
{
	[SerializeField]
	private GameObject skillRoot;

	[SerializeField]
	private bool useUICamera;

	[SerializeField]
	private UniversalButton inputMove;

	[SerializeField]
	private UniversalButton attackBtn;

	[SerializeField]
	private UniversalButton dodgeBtn;

	[SerializeField]
	private List<InteractionBtnUIComp> interactiveBtns;

	[SerializeField]
	private List<RecuseBtn> recuseBtns;

	[SerializeField]
	private List<UniversalButton> skillBtnList;

	[SerializeField]
	private DistanceCanelSkill distanceCanelSkill;

	[SerializeField]
	private Transform skill4Light;

	[SerializeField]
	private GameObject ImmunizationInput;

	private GameObject skill4Effect;

	[SerializeField]
	private Image skill4Progress;

	public TextMeshProUGUI RelaseSkillTipText;

	public Transform RelaseSkillTip;

	private CanvasGroup relaseSkillTipCanvasGroup;

	private Tween releaseSkillTipTween;

	private HeroSkillTypeEnum releaseSkillTipBtnType;

	[SerializeField]
	private float releaseSkillTipShowTime = 0.8f;

	[SerializeField]
	private float releaseSkillTipHideTime = 0.2f;

	public Transform PropSkillTrans;

	public Transform DeputyPropSkillTrans;

	private SkillDescView skillDescView;

	[SerializeField]
	private List<TouchLayoutPos> pos;

	[SerializeField]
	public Button BuffDescBtn;

	[SerializeField]
	private GameObject showCastingMask;

	[SerializeField]
	private ChangeUniversalBtnSkin _changeUniversalBtnSkin;

	public Action<HeroSkillTypeEnum, bool> onSkillButtonStopPressed;

	public Action<HeroSkillTypeEnum> onSkillButtonPressed;

	public Action<HeroSkillTypeEnum, Vector3, bool, bool> onSkillButtonDragged;

	public Action<HeroSkillTypeEnum, Vector3> onActivateSkill;

	public Action<HeroSkillTypeEnum> onCancelSkill;

	public Action<HeroSkillTypeEnum> onPointerUp;

	[SerializeField]
	private CanvasGroup _panelAlpha;

	private TouchInputViewModel viewModel;

	private Vector3 interactionBtnSpace = Vector3.zero;

	private int showAlphaIndex;

	public Vector2 Direction
	{
		get
		{
			if (!(inputMove == null))
			{
				if (!inputMove.isFingerDown && !inputMove.isSimulator)
				{
					return Vector2.zero;
				}
				return Utility.Math.GetCameraOffsetDir(inputMove.directionXZ.ToVector2());
			}
			return Vector2.zero;
		}
	}

	protected override void OnInit()
	{
		viewModel = GetData<TouchInputViewModel>();
		BindingSet<TouchInputWindow, TouchInputViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TouchInputWindow v) => v.OnDismissRequest).To((TouchInputViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TouchInputWindow v) => v.OpenUguiWindow).To((TouchInputViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((TouchInputWindow v) => v.OnVisibleChanged).To((TouchInputViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((TouchInputWindow v) => v.OnHidePanelChanged).To((TouchInputViewModel vm) => vm.HidePanelRequest);
		bindingSet.Bind<CanvasGroup>(CanvasGroup).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).ToExpression((TouchInputViewModel vm) => vm.CanTouch);
		if (BuffDescBtn != null)
		{
			bindingSet.Bind(BuffDescBtn).For((Button v) => v.onClick).To((TouchInputViewModel vm) => vm.OpenBuffDesc);
		}
		bindingSet.Build();
		BtnAddListener(attackBtn);
		BtnAddListener(dodgeBtn);
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			if (viewModel.GetHeroSkill(skillBtn.optionType) != null)
			{
				BtnAddListener(skillBtn);
			}
		}
		for (int num = 0; num < interactiveBtns.Count; num++)
		{
			interactiveBtns[num].InteractiveBtn.onPointerDown.AddListener(OnSkillButtonPressed);
			interactiveBtns[num].InteractiveBtn.onPointerUp.AddListener(OnPointerUp);
		}
		for (int num2 = 0; num2 < recuseBtns.Count; num2++)
		{
			recuseBtns[num2].onPointerDown.AddListener(OnSkillButtonPressed);
			recuseBtns[num2].onPointerUp.AddListener(OnPointerUp);
		}
		skill4Effect = skill4Light.Find($"Skill4_{viewModel.HeroAttributeEnum}")?.gameObject;
		skill4Effect?.SetActive(value: true);
		interactionBtnSpace = recuseBtns[0].transform.position - recuseBtns[1].transform.position;
		relaseSkillTipCanvasGroup = RelaseSkillTip.GetComponent<CanvasGroup>();
	}

	private void BtnAddListener(UniversalButton btn)
	{
		btn.onStopPress.AddListener(OnSkillButtonStopPressed);
		btn.onPointerDown.AddListener(OnSkillButtonPressed);
		btn.onShowReleaseSkillTip = (Action<string, Vector3, HeroSkillTypeEnum, bool>)Delegate.Combine(btn.onShowReleaseSkillTip, new Action<string, Vector3, HeroSkillTypeEnum, bool>(UpdateReleaseSkillTip));
		btn.onHideReleaseSkillTip = (Action<HeroSkillTypeEnum>)Delegate.Combine(btn.onHideReleaseSkillTip, new Action<HeroSkillTypeEnum>(HideReleaseSkillTip));
		btn.onActivateSkill.AddListener(OnActivateSkill);
		btn.onCancelSkill.AddListener(OnCancelSkill);
		btn.onDrag.AddListener(OnSkillButtonDragged);
		btn.onPointerUp.AddListener(OnPointerUp);
	}

	public void InitCommandSystem(ICommandSystemHandle commandSystemHandle)
	{
		inputMove.SetCommandHandle(commandSystemHandle);
	}

	public override bool CloseInversion()
	{
		if (viewModel != null && !viewModel.IsCloseView)
		{
			viewModel.Close();
			return true;
		}
		return base.CloseInversion();
	}

	public void ReleaseSkill(HeroSkillTypeEnum optionType)
	{
		if (skillBtnList == null)
		{
			return;
		}
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			if (skillBtn.optionType == optionType)
			{
				skillBtn.OnPointerUp(new PointerEventData(EventSystem.current));
			}
		}
	}

	protected virtual void OnPointerUp(HeroSkillTypeEnum skillEnum)
	{
		onPointerUp?.Invoke(skillEnum);
	}

	protected virtual void OnSkillButtonStopPressed(HeroSkillTypeEnum skillEnum, bool val)
	{
		onSkillButtonStopPressed?.Invoke(skillEnum, val);
	}

	protected virtual void OnSkillButtonPressed(HeroSkillTypeEnum skillEnum)
	{
		if (skillEnum == HeroSkillTypeEnum.Interaction1 || skillEnum == HeroSkillTypeEnum.Interaction2 || skillEnum == HeroSkillTypeEnum.Interaction3 || skillEnum == HeroSkillTypeEnum.Interaction4)
		{
			ClickInteractiveRecuseBtn(skillEnum);
		}
		onSkillButtonPressed?.Invoke(skillEnum);
	}

	protected virtual void OnSkillButtonDragged(HeroSkillTypeEnum skillEnum, Vector3 pos, bool canccelRelease, bool IsDragOutSkillJudge)
	{
		onSkillButtonDragged?.Invoke(skillEnum, pos, canccelRelease, IsDragOutSkillJudge);
	}

	protected virtual void OnCancelSkill(HeroSkillTypeEnum skillEnum)
	{
		onCancelSkill?.Invoke(skillEnum);
	}

	protected virtual void OnActivateSkill(HeroSkillTypeEnum skillEnum, Vector3 direction)
	{
		onActivateSkill?.Invoke(skillEnum, direction);
	}

	public void SetDirection(Vector3 inputUvTemp, bool activeInput)
	{
		inputMove.directionXZ = inputUvTemp;
		inputMove.SetSimulatorMode(activeInput);
	}

	public void ShowInteraction(int index, bool isShow, string iconType, string interName, float interactiveTime, bool isRefreshPos, bool isFinishInter)
	{
		HeroSkill heroSkill = null;
		if (index == 0)
		{
			heroSkill = viewModel.GetHeroSkill(HeroSkillTypeEnum.Interaction1);
		}
		switch (index)
		{
		case 1:
			heroSkill = viewModel.GetHeroSkill(HeroSkillTypeEnum.Interaction2);
			break;
		case 2:
			heroSkill = viewModel.GetHeroSkill(HeroSkillTypeEnum.Interaction3);
			break;
		case 3:
			heroSkill = viewModel.GetHeroSkill(HeroSkillTypeEnum.Interaction4);
			break;
		}
		interactiveBtns[index].InteractiveBtn.gameObject.SetActive(isShow);
		heroSkill.IconBattle = iconType;
		if (isRefreshPos)
		{
			RefreshInteractionBtnsPos(isFinishInter);
		}
		interactiveBtns[index].InteractiveBtn.RefreshInteractionInfo(interactiveTime, interName);
	}

	public void HideRecuse()
	{
		InteractionRecuseBtnSet(HeroSkillTypeEnum.None, isShow: false);
	}

	public void RefreshRecuseBtn()
	{
		RefreshInteractionBtnsPos(isFinishInter: false);
	}

	private void RefreshInteractionBtnsPos(bool isFinishInter)
	{
		int num = 0;
		Vector3 position = recuseBtns[0].transform.position;
		for (int i = 0; i < recuseBtns.Count; i++)
		{
			recuseBtns[i].transform.parent.gameObject.SetActive(num < 4);
			if (recuseBtns[i].gameObject.activeSelf)
			{
				recuseBtns[i].transform.parent.position = position;
				position -= interactionBtnSpace;
				num++;
			}
		}
		for (int j = 0; j < interactiveBtns.Count; j++)
		{
			interactiveBtns[j].BtnRoot.SetActive(num < 4);
			if (interactiveBtns[j].BtnTrans.gameObject.activeSelf)
			{
				interactiveBtns[j].BtnRoot.transform.position = position;
				position -= interactionBtnSpace;
				num++;
			}
			if (isFinishInter)
			{
				interactiveBtns[j].InteractiveBtn.SetBtnAlpha(isShow: true);
			}
		}
	}

	private void ClickInteractiveRecuseBtn(HeroSkillTypeEnum skillTypeEnum)
	{
		foreach (InteractionBtnUIComp interactiveBtn in interactiveBtns)
		{
			if (interactiveBtn.InteractiveBtn.optionType == skillTypeEnum)
			{
				_ = interactiveBtn.InteractiveBtn.InteractiveTime;
				_ = 0.1f;
			}
		}
		InteractionRecuseBtnTweenSet(skillTypeEnum, isShow: false);
	}

	public void InteractionRecuseBtnSet(HeroSkillTypeEnum noHideType, bool isShow)
	{
		for (int i = 0; i < recuseBtns.Count; i++)
		{
			recuseBtns[i].SetBtnAlpha(isShow);
		}
		foreach (InteractionBtnUIComp interactiveBtn in interactiveBtns)
		{
			if (interactiveBtn.InteractiveBtn.optionType != noHideType)
			{
				interactiveBtn.InteractiveBtn.SetBtnAlpha(isShow);
			}
		}
	}

	public void InteractionRecuseBtnTweenSet(HeroSkillTypeEnum noHideType, bool isShow)
	{
		for (int i = 0; i < recuseBtns.Count; i++)
		{
			recuseBtns[i].SetBtnAlphaTween(isShow);
		}
		foreach (InteractionBtnUIComp interactiveBtn in interactiveBtns)
		{
			if (interactiveBtn.InteractiveBtn.optionType != noHideType)
			{
				interactiveBtn.InteractiveBtn.SetBtnAlphaTween(isShow);
			}
		}
	}

	private string GetSliderColorByHeroAttribute(HeroAttributeEnum heroAttributeEnum)
	{
		return heroAttributeEnum switch
		{
			HeroAttributeEnum.Wind => "#39d8b0", 
			HeroAttributeEnum.Water => "#369ad3", 
			HeroAttributeEnum.Fire => "#d96333", 
			HeroAttributeEnum.Light => "#d99633", 
			HeroAttributeEnum.Dark => "#8357d5", 
			_ => "#39d8b0", 
		};
	}

	private void OnHidePanelChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		_panelAlpha.alpha = (flag ? 1 : 0);
		showCastingMask.SetActive(viewModel.TouchInputMaskState);
		if (!flag && !viewModel.TouchInputMaskState)
		{
			inputMove.HideAimer();
		}
		if (flag)
		{
			CanvasGroup.blocksRaycasts = flag;
		}
		else
		{
			CanvasGroup.blocksRaycasts = viewModel.TouchInputMaskState;
		}
	}

	public void Refresh(TouchInputViewModel inputViewModel, int skillCount)
	{
		viewModel = inputViewModel;
		this.SetDataContext(inputViewModel);
		skillRoot.SetActive(skillCount > 0);
		attackBtn.RefreshData(viewModel.GetHeroSkill(HeroSkillTypeEnum.Attack));
		dodgeBtn.RefreshData(viewModel.GetHeroSkill(HeroSkillTypeEnum.Roll));
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			skillBtn.RefreshData(viewModel.GetHeroSkill(skillBtn.optionType));
		}
		foreach (InteractionBtnUIComp interactiveBtn in interactiveBtns)
		{
			interactiveBtn.InteractiveBtn.RefreshData(viewModel.GetHeroSkill(interactiveBtn.InteractiveBtn.optionType));
		}
		foreach (RecuseBtn recuseBtn in recuseBtns)
		{
			recuseBtn.RefreshData(viewModel.HeroData);
		}
		skill4Effect?.SetActive(value: false);
		skill4Effect = skill4Light.Find($"Skill4_{viewModel.HeroEntity.BattleHeroData.Attribute}")?.gameObject;
		skill4Effect?.SetActive(value: true);
		SetPropSkillPos();
	}

	public void SetPropSkillPos()
	{
		HeroSkill heroSkill = viewModel.GetHeroSkill(HeroSkillTypeEnum.PropSkill);
		HeroSkill heroSkill2 = viewModel.GetHeroSkill(HeroSkillTypeEnum.DeputyPropSkill);
		int num = 0;
		if (heroSkill != null && !heroSkill.IsEmpty)
		{
			num++;
		}
		if (heroSkill2 != null && !heroSkill2.IsEmpty)
		{
			num++;
		}
		switch (num)
		{
		case 1:
		{
			foreach (UniversalButton skillBtn in skillBtnList)
			{
				if (skillBtn.optionType == HeroSkillTypeEnum.PropSkill)
				{
					skillBtn.gameObject.transform.position = DeputyPropSkillTrans.position;
				}
			}
			break;
		}
		case 2:
		{
			foreach (UniversalButton skillBtn2 in skillBtnList)
			{
				if (skillBtn2.optionType == HeroSkillTypeEnum.PropSkill)
				{
					skillBtn2.gameObject.transform.position = PropSkillTrans.position;
				}
				else if (skillBtn2.optionType == HeroSkillTypeEnum.DeputyPropSkill)
				{
					skillBtn2.gameObject.transform.position = DeputyPropSkillTrans.position;
				}
			}
			break;
		}
		}
	}

	public void HideSkillAimer(HeroSkillTypeEnum skillType)
	{
		switch (skillType)
		{
		case HeroSkillTypeEnum.Attack:
			attackBtn.HideAimer();
			return;
		case HeroSkillTypeEnum.Roll:
			dodgeBtn.HideAimer();
			return;
		}
		for (int i = 0; i < skillBtnList.Count; i++)
		{
			if (skillBtnList[i].optionType == skillType)
			{
				skillBtnList[i].HideAimer();
				break;
			}
		}
	}

	public void HideSkillAimerAll()
	{
		attackBtn.HideAimer();
		dodgeBtn.HideAimer();
		for (int i = 0; i < skillBtnList.Count; i++)
		{
			skillBtnList[i].HideAimer();
		}
	}

	public void SetSkillAimerPointer(HeroSkillTypeEnum skillType, bool isActive)
	{
		switch (skillType)
		{
		case HeroSkillTypeEnum.Attack:
			attackBtn.SetAimerPointer(isActive);
			return;
		case HeroSkillTypeEnum.Roll:
			dodgeBtn.SetAimerPointer(isActive);
			return;
		}
		for (int i = 0; i < skillBtnList.Count; i++)
		{
			if (skillBtnList[i].optionType == skillType)
			{
				skillBtnList[i].SetAimerPointer(isActive);
				break;
			}
		}
	}

	public void UpdateSkillBind(HeroSkillTypeEnum skillType, HeroSkill heroSkill)
	{
		switch (skillType)
		{
		case HeroSkillTypeEnum.Attack:
			attackBtn.RefreshData(heroSkill);
			return;
		case HeroSkillTypeEnum.Roll:
			dodgeBtn.RefreshData(heroSkill);
			return;
		}
		for (int i = 0; i < skillBtnList.Count; i++)
		{
			if (skillBtnList[i].optionType == skillType)
			{
				skillBtnList[i].RefreshData(heroSkill);
				break;
			}
		}
	}

	public void SetSkillBtnDragOutDeadArea(HeroSkillTypeEnum skillTypeEnum)
	{
		switch (skillTypeEnum)
		{
		case HeroSkillTypeEnum.Attack:
			attackBtn.IsDragOutSkillJudge = true;
			return;
		case HeroSkillTypeEnum.Roll:
			dodgeBtn.IsDragOutSkillJudge = true;
			return;
		}
		for (int i = 0; i < skillBtnList.Count; i++)
		{
			if (skillBtnList[i].optionType == skillTypeEnum)
			{
				skillBtnList[i].IsDragOutSkillJudge = true;
				break;
			}
		}
	}

	private void UpdateReleaseSkillTip(string content, Vector3 textPos, HeroSkillTypeEnum optionType, bool energyUnenough)
	{
		if (!string.IsNullOrEmpty(content))
		{
			if (releaseSkillTipTween.IsActive())
			{
				releaseSkillTipTween.Kill(complete: true);
			}
			RelaseSkillTip.position = textPos;
			((TMP_Text)RelaseSkillTipText).text = content;
			relaseSkillTipCanvasGroup.alpha = 1f;
			releaseSkillTipTween = DOTweenModuleUI.DOFade(relaseSkillTipCanvasGroup, 0f, releaseSkillTipHideTime).SetDelay(releaseSkillTipShowTime).OnComplete(delegate
			{
				releaseSkillTipBtnType = HeroSkillTypeEnum.None;
			});
			releaseSkillTipBtnType = optionType;
			if (energyUnenough)
			{
				viewModel.EnergyUnenoughEffect();
			}
		}
	}

	private void HideReleaseSkillTip(HeroSkillTypeEnum optionType)
	{
		if (releaseSkillTipBtnType == optionType)
		{
			releaseSkillTipTween.Kill(complete: true);
		}
	}

	public void SetDragSkillJude(float dragSkillJude, float skillCancelDistance)
	{
		if (distanceCanelSkill != null)
		{
			distanceCanelSkill.SetCancelDistance(skillCancelDistance);
		}
		attackBtn.DragSkillJude = dragSkillJude;
		attackBtn.DistanceCanelSkill = distanceCanelSkill;
		dodgeBtn.DragSkillJude = dragSkillJude;
		dodgeBtn.DistanceCanelSkill = distanceCanelSkill;
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			skillBtn.DragSkillJude = dragSkillJude;
			skillBtn.DistanceCanelSkill = distanceCanelSkill;
		}
	}

	public void SetDragAnalogStickJude(float dragJude)
	{
		AnalogStick analogStick = inputMove as AnalogStick;
		if (analogStick != null)
		{
			analogStick.SetInputDragJude(dragJude);
		}
	}

	public void SetEntityTransToPropSkillBtn(Transform transform, Vector2 offset)
	{
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			if (skillBtn.optionType == HeroSkillTypeEnum.PropSkill || skillBtn.optionType == HeroSkillTypeEnum.DeputyPropSkill)
			{
				skillBtn.ChargeUIFollowTrans = transform;
				skillBtn.ChargeUIOffset = offset;
			}
		}
	}

	public void SetBattleCamera(Camera battleCamera)
	{
		foreach (UniversalButton skillBtn in skillBtnList)
		{
			skillBtn.BattleCamera = battleCamera;
		}
	}

	public void CanImmunizationExcute(bool isShow)
	{
		ImmunizationInput.SetActive(isShow);
		(inputMove as AnalogStick).CanImmunizationExcute(isShow);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if ((UnityEngine.Object)(object)_changeUniversalBtnSkin != null)
		{
			_changeUniversalBtnSkin.UnSkinAsset();
		}
	}

	public async UniTask SetEntitySkin(int skinId)
	{
		SkinUniversalBtnData skinUniversalBtnData = await _changeUniversalBtnSkin.SetEntitySkin(skinId);
		if (!(skinUniversalBtnData == null))
		{
			Color distanceCancelColor = skinUniversalBtnData.DistanceCancelColor;
			bool useSkin = skinId > 0;
			if (skinId > 0)
			{
				useSkin = GameEntry.DataTable.GetDataRow<DRHeroSkin>(skinId)?.ChangeSkillIcon ?? false;
			}
			attackBtn.ChangeSkinReset(useSkin, distanceCancelColor);
			dodgeBtn.ChangeSkinReset(useSkin, distanceCancelColor);
			for (int i = 0; i < skillBtnList.Count; i++)
			{
				skillBtnList[i].ChangeSkinReset(useSkin, distanceCancelColor);
			}
			distanceCanelSkill.SetNormalColor(distanceCancelColor);
		}
	}
}
