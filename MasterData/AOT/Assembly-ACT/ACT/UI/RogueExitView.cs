using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.Model;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RogueExitView : BaseUIView<RogueExitViewInputController>
{
	private RogueExitViewData m_data;

	public ActButton BtnContinue;

	public ActButton BtnLeave;

	public ActButton BtnExit;

	public TextMeshProUGUI TxtProgress;

	[Header("Input Binding")]
	public ViewControlLayer viewControlLayer;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		BtnContinue.SetBtnClick(Close);
		BtnLeave.SetBtnClick(OnHangGame);
		BtnExit.SetBtnClick(OnExit);
	}

	protected override void Init()
	{
		base.Init();
		RogueMode data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data != null)
		{
			TxtProgress.SetText("{0:0}-{1:0}", Model<RogueNewModel>.Interface.Info.GameInfo.Index + 1, data.mapNodeList.Length);
		}
		BtnLeave.gameObject.SetActive(Model<RogueNewModel>.Interface.Info.GameInfo.Index != 0);
		viewControlLayer.Focus();
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void OnExit()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			OnConfirm = () =>
			{
				Model<RogueNewModel>.Interface.SendRogueFinishGame(RogueFinishType.Quit, (RogueFinishGameAck ack) =>
				{
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueOpenSettlement, null);
				});
				Close();
			},
			commonId = 2789
		});
	}

	private void OnHangGame()
	{
		Model<RogueNewModel>.Interface.SendRogueHangGame(async (RogueHangGameAck ack) =>
		{
			Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
			await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
		});
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
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
