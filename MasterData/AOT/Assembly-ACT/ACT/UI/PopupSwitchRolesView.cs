using System.Collections.Generic;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupSwitchRolesView : BaseUIView<PopupSwitchRolesViewInputController>
{
	public GamePadTipsComp gamePadGroup;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	private PopupSwitchRolesViewData m_data;

	public ActButton BtnClose;

	public ActButton BtnCanel;

	public ActButton BtnConfim;

	public Image ImageCurrent;

	public Image ImageReplace;

	public BetterAnimation betterAni;

	public List<Sprite> ImageRole = new List<Sprite>();

	private bool isMan;

	private bool m_canRightStickScroll;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public override async UniTask PreInit()
	{
		PreInitPanel();
		await base.PreInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Set/ChangeRole");
		betterAni.GetSequence("Show").Play();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAni.GetSequence("Hide").Play();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	private void PreInitPanel()
	{
		BtnCanel.SetBtnClick(Close);
		BtnClose.SetBtnClick(Close);
		BtnConfim.SetBtnClick(OnConfirm);
	}

	private void InitPanel()
	{
		isMan = G.detailUserInfo.Brief.Gender == 1;
		ImageCurrent.sprite = (isMan ? ImageRole[1] : ImageRole[0]);
		ImageReplace.sprite = (isMan ? ImageRole[0] : ImageRole[1]);
		BtnConfim.Interactable(Model<PlayerGenderModel>.Interface.IsCanChangeGender());
	}

	private void OnConfirm()
	{
		if (Model<PlayerGenderModel>.Interface.IsCanChangeGender())
		{
			Model<PlayerGenderModel>.Interface.SendReviseGender((!isMan) ? 1 : 2, (ChangeGenderAck ack) =>
			{
				Close();
			});
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
