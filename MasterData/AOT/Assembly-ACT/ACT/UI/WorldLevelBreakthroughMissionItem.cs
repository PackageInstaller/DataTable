using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldLevelBreakthroughMissionItem : LoopScrollBaseItem
{
	[SerializeField]
	private Image _diban1;

	[SerializeField]
	private Image _diban2;

	[SerializeField]
	private Image _weiwanchengIcon;

	[SerializeField]
	private Image _completeIcon;

	[SerializeField]
	private TextMeshProUGUI _taskDesc;

	[SerializeField]
	private LocalizeStringEvent _taskDescLocalizeString;

	[SerializeField]
	private TextMeshProUGUI _completeText;

	[SerializeField]
	private TextMeshProUGUI _proceedingText;

	[SerializeField]
	private ActButton _btn_goto;

	[SerializeField]
	private GameObject _btnGO;

	[SerializeField]
	private GamePadSelectComponent gamePadSelectComponent;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptA;

	private List<int> missionGroup;

	private int missionId;

	private TaskInfo taskInfo;

	private StringBuilder _sb;

	private int progress;

	private int status;

	private int jumpId;

	private bool _gamepadInputInited;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		gameObject.name = string.Format("{0}_{1}", "WorldLevelBreakthroughMissionItem", idx);
		_sb = new StringBuilder();
		missionGroup = Model<WorldLevelModel>.Interface.GetWorldLevelBreakTaskGroup(Model<WorldLevelModel>.Interface.CurrentSelectWorldLevel);
		missionId = missionGroup[index];
		Mission mission = RuntimeConfigs.data.missions[missionId];
		_ = mission.preconditionId;
		_ = mission.type;
		int number = mission.number;
		_ = mission.param;
		jumpId = mission.missionId;
		Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(missionId, out var value);
		if (value != null)
		{
			_btn_goto.SetBtnClick(OnClickBtn);
			progress = value.progress;
			status = value.status;
			if (status == 0)
			{
				_diban1.gameObject.SetActive(value: true);
				_diban2.gameObject.SetActive(value: false);
				_weiwanchengIcon.gameObject.SetActive(value: true);
				_completeIcon.gameObject.SetActive(value: false);
				_completeText.gameObject.SetActive(value: false);
				if (jumpId != 0)
				{
					_proceedingText.gameObject.SetActive(value: false);
					_btnGO.SetActive(value: true);
				}
				else
				{
					_proceedingText.gameObject.SetActive(value: true);
					_btnGO.SetActive(value: false);
				}
			}
			else if (status == 1 || status == 2)
			{
				_diban1.gameObject.SetActive(value: false);
				_diban2.gameObject.SetActive(value: true);
				_weiwanchengIcon.gameObject.SetActive(value: false);
				_completeIcon.gameObject.SetActive(value: true);
				_completeText.gameObject.SetActive(value: true);
				_btnGO.SetActive(value: false);
				_proceedingText.gameObject.SetActive(value: false);
			}
		}
		string value2 = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
		if (mission.preconditionId == 18)
		{
			var (value3, value4) = CountConditionProcess.CumulativeOnlineDurationProcess(mission.preconditionId, progress, number);
			_sb.Clear();
			_sb.Append(value2);
			_sb.Append("(");
			_sb.Append(value3);
			_sb.Append("/");
			_sb.Append(value4);
			_sb.Append(")");
		}
		else
		{
			_sb.Clear();
			_sb.Append(value2);
			_sb.Append("(");
			_sb.Append(progress);
			_sb.Append("/");
			_sb.Append(number);
			_sb.Append(")");
		}
		_taskDesc.text = _sb.ToString();
		ColorUtility.TryParseHtmlString((status != 0) ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color);
		_taskDesc.color = color;
		RefreshGamepadInputState(GetJourneyTracesView());
	}

	private void OnClickBtn()
	{
		if (jumpId != 0)
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.WorldLevelTaskJumpBtnClick);
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpId);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
			}
			else
			{
				runTimeJumpData.FromSystem = SystemType.PlayerWorldLevel;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				result.Release();
			}
		}
	}

	public void RefreshGamepadInputState(MonoJourneyTracesView view)
	{
		InitGamepadInput();
		bool num = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag = (object)view != null && view.GetCurSubControllerType() == JourneyTraceSubController.SelectWorldLevelTaskGroup;
		bool flag2 = (num & flag) && IsCurrentSelectedCell();
		bool flag3 = IsGotoButtonVisible();
		gamePadSelectComponent?.SetSelectState(flag2);
		SetPromptVisible(operateBtnPromptA, flag2 & flag3);
	}

	public bool TryClickGoto()
	{
		if (!IsGotoButtonVisible())
		{
			return false;
		}
		OnClickBtn();
		return true;
	}

	private void InitGamepadInput()
	{
		if (!_gamepadInputInited)
		{
			_gamepadInputInited = true;
			if (!(operateBtnPromptA == null))
			{
				operateBtnPromptA.SetBindingAction("UI/Confirm");
				operateBtnPromptA.SetVisible(vis: false);
				operateBtnPromptA.RefreshIcon();
			}
		}
	}

	private bool IsGotoButtonVisible()
	{
		if (_btnGO != null)
		{
			return _btn_goto.gameObject.activeInHierarchy;
		}
		return false;
	}

	private bool IsCurrentSelectedCell()
	{
		if (Model<WorldLevelModel>.Interface.HasGuideWorldLevelTaskGroupIndex && Singleton<GameState>.instance != null && Singleton<GameState>.instance.InGuiding && MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			return index == Model<WorldLevelModel>.Interface.GuideWorldLevelTaskGroupIndex;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			return currentSelected.GetComponentInParent<WorldLevelBreakthroughMissionItem>(includeInactive: true) == this;
		}
		return false;
	}

	private static void SetPromptVisible(OperateBtnPrompt prompt, bool visible)
	{
		if (!(prompt == null))
		{
			prompt.SetVisible(visible);
			if (visible)
			{
				prompt.RefreshIcon();
			}
		}
	}

	private MonoJourneyTracesView GetJourneyTracesView()
	{
		return Singleton<NewUIManager>.instance.GetTopActiveUI()?.GetUIView() as MonoJourneyTracesView;
	}
}
