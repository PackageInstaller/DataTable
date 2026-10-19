using ACT.Battle;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassTaskCell : LoopScrollBaseItem, ISelectHandler, IEventSystemHandler, IDeselectHandler
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	[Header("任务名字")]
	private TextMeshProUGUI _taskName;

	[SerializeField]
	[Header("任务进度数字配置")]
	private CommonNumberComponent _commonNumberComponent;

	[SerializeField]
	[Header("经验数字")]
	private TextMeshProUGUI _experienceText;

	[SerializeField]
	[Header("前往按钮")]
	private ActButton _jumpBtn;

	[SerializeField]
	[Header("领取按钮")]
	private ActButton _getExperienceBtn;

	[SerializeField]
	[Header("已完成")]
	private GameObject _claimdObj;

	[SerializeField]
	[Header("进行中")]
	private GameObject _doingObj;

	[SerializeField]
	[Header("手柄模式选中时显示")]
	private GameObject _gamePadHandle;

	[SerializeField]
	[Header("前往按钮手柄提示")]
	private OperateBtnPrompt _jumpBtnOperateBtnPrompt;

	[SerializeField]
	[Header("领取按钮手柄提示")]
	private OperateBtnPrompt _getBtnOperateBtnPrompt;

	private const string ShowAnimation = "show";

	private const string HideAnimation = "Hide";

	private bool _selected;

	public void OnSelect(BaseEventData eventData)
	{
		_selected = true;
		UpdateSelect();
	}

	public void OnDeselect(BaseEventData eventData)
	{
		_selected = false;
		UpdateSelect();
	}

	public void GotoShow()
	{
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence("show").Goto(0f);
		}
	}

	public void PlayAnimation()
	{
		if (_betterAnimation != null)
		{
			_betterAnimation.GetSequence("show").Play();
		}
	}

	public void OnInit(int taskIndex, BattlePassTaskType taskType)
	{
		BattlePassTask taskData = ((taskType == BattlePassTaskType.Daily) ? Model<BattlePassModel>.Interface.DailyTaskList[taskIndex] : Model<BattlePassModel>.Interface.RoundTaskList[taskIndex]);
		_taskName.text = taskData.Description;
		_commonNumberComponent.UpdateNumber(taskData.CurrentProgress, taskData.TargetProgress);
		_experienceText.SetText("{0:0}", taskData.Exp);
		_jumpBtn.OnClick.RemoveAllListeners();
		_jumpBtn.OnClick.AddListener(() =>
		{
			JumpBtnEvt(taskData.JumpId);
		});
		_jumpBtn.gameObject.SetActive(taskData.Status == BattlePassTaskStatus.UnDone && taskData.JumpId != 0);
		_getExperienceBtn.OnClick.RemoveAllListeners();
		_getExperienceBtn.OnClick.AddListener(() =>
		{
			ClaimExpEvt(taskData.TaskId);
		});
		_getExperienceBtn.gameObject.SetActive(taskData.Status == BattlePassTaskStatus.DoneUnClaimed);
		_doingObj.gameObject.SetActive(taskData.Status == BattlePassTaskStatus.UnDone && taskData.JumpId == 0);
		_claimdObj.gameObject.SetActive(taskData.Status == BattlePassTaskStatus.Claimed);
		UpdateSelect();
	}

	private void UpdateSelect()
	{
		_gamePadHandle?.SetActive(_selected && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		_jumpBtnOperateBtnPrompt.SetVisible(_selected && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		_getBtnOperateBtnPrompt.SetVisible(_selected && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void OnDisable()
	{
		_selected = false;
	}

	public void ConfirmByGamePad()
	{
		if (_jumpBtn.gameObject.activeInHierarchy)
		{
			_jumpBtn.OnClick?.Invoke();
		}
		else if (_getExperienceBtn.gameObject.activeInHierarchy)
		{
			_getExperienceBtn.OnClick?.Invoke();
		}
	}

	private void JumpBtnEvt(int jumpId)
	{
		if (jumpId != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpId);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			JumpResult.JumpShowType showType = result.ShowType;
			if (showType == JumpResult.JumpShowType.Forbidden || showType == JumpResult.JumpShowType.Hide)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
			}
			else
			{
				runTimeJumpData.FromSystem = SystemType.BattlePass;
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				result.Release();
			}
		}
	}

	private void ClaimExpEvt(int taskId)
	{
		BattlePassTask task = Model<BattlePassModel>.Interface.GetTask(taskId);
		if (task.Status == BattlePassTaskStatus.DoneUnClaimed)
		{
			Model<BattlePassModel>.Interface.ClaimTasks(task.TaskGroupId, taskId, (bool b) =>
			{
			});
		}
	}
}
