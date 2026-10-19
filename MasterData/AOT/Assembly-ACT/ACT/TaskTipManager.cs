using System;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT;

public class TaskTipManager : MonoBehaviour, IBattleMainComponent
{
	public Animator animationController;

	public CanvasGroup canvasGroup;

	[Header("新任务")]
	public TaskTip_New taskTip_New;

	[Header("当任务成功")]
	public TaskTip_Success taskTip_Success;

	[Header("当任务失败")]
	public TaskTip_Fail taskTip_Fail;

	[Header("当前追踪任务")]
	public TaskTip_Tracing taskTip_Tracing;

	private MissionTipAdapter m_Adapter;

	private MonoBattleMainBaseView _view;

	private NewMissionStateAdapter m_Complete;

	private TaskTip_Tracing.ConditionUpdate m_CompleteUpdate;

	private NewMissionStateAdapter m_Failure;

	private NewMissionStateAdapter m_ReceiveNew;

	private NewMissionStateAdapter m_Proceed;

	private TaskTip_Tracing.ConditionUpdate m_ConditionUpdate;

	private TaskTip_Tracing.StageUpdate m_StageUpdate;

	private bool m_ClearProceed;

	private bool m_Processing;

	public MonoBattleMainBaseView View => _view;

	private void Awake()
	{
		animationController.keepAnimatorStateOnDisable = true;
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
		m_Adapter = new NewMissionTipAdapter();
		m_Complete = null;
		m_CompleteUpdate = null;
		m_Failure = null;
		m_ReceiveNew = null;
		m_Proceed = null;
		m_ConditionUpdate = null;
		m_StageUpdate = null;
		m_ClearProceed = false;
		m_Processing = false;
		taskTip_New.Init(this);
		taskTip_Success.Init(this);
		taskTip_Fail.Init(this);
		taskTip_Tracing.Init(this);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionNTip_Accept, OnTaskTipShowNewReceive);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionNTip_Tracing, OnTaskTipShowProceed);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionNTip_Failure, OnTaskTipShowFail);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionNTip_Success, OnTaskTipShowComplete);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_ConditionUpdate, OnTaskTipConditionChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_StageUpdate, OnMissionStageUpdate);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Open, OnUIEvent);
		Model<BattleMainModel>.Interface.OnTaskTipStateChangeEventHandler += OnTaskTipStateChanged;
		MissionStateAdapter tracingTaskTipState = m_Adapter.GetTracingTaskTipState();
		taskTip_Tracing.RefreshMission(tracingTaskTipState);
	}

	public void UnInitialize()
	{
		OnBattleMainHide();
		m_Complete = null;
		m_CompleteUpdate = null;
		m_Failure = null;
		m_ReceiveNew = null;
		m_Proceed = null;
		m_ConditionUpdate = null;
		m_StageUpdate = null;
		m_ClearProceed = false;
		m_Processing = false;
		taskTip_New.UnInit();
		taskTip_Success.UnInit();
		taskTip_Fail.UnInit();
		taskTip_Tracing.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionNTip_Failure, OnTaskTipShowFail);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionNTip_Success, OnTaskTipShowComplete);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionNTip_Tracing, OnTaskTipShowProceed);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionNTip_Accept, OnTaskTipShowNewReceive);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_ConditionUpdate, OnTaskTipConditionChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_StageUpdate, OnMissionStageUpdate);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Open, OnUIEvent);
		Model<BattleMainModel>.Interface.OnTaskTipStateChangeEventHandler -= OnTaskTipStateChanged;
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void UpdateActive()
	{
		bool taskTipActive = Model<BattleMainModel>.Interface.GetTaskTipActive();
		canvasGroup.alpha = (taskTipActive ? 1f : 0f);
		canvasGroup.interactable = taskTipActive;
		if (taskTipActive)
		{
			ProcessingTasks().Forget();
		}
	}

	private void OnUIEvent(BaseEventContent obj)
	{
		UIEvent uIEvent = (UIEvent)obj;
		if (uIEvent != null && uIEvent.UIType == UI_TYPE.UI_LETTERBOXINGPANEL)
		{
			UpdateActive();
		}
	}

	private void OnTaskTipStateChanged()
	{
		UpdateActive();
	}

	private void OnTaskTipShowFail(BaseEventContent obj)
	{
		MissionNFailureEvt missionNFailureEvt = obj as MissionNFailureEvt;
		if (m_Adapter.GetTaskTipState(missionNFailureEvt.missionId) is NewMissionStateAdapter failure)
		{
			m_Failure = failure;
			ProcessingTasks().Forget();
		}
	}

	private void OnTaskTipShowComplete(BaseEventContent obj)
	{
		MissionNSuccessEvt missionNSuccessEvt = obj as MissionNSuccessEvt;
		if (m_Adapter.GetTaskTipState(missionNSuccessEvt.missionId) is NewMissionStateAdapter complete)
		{
			m_Complete = complete;
			m_CompleteUpdate = new TaskTip_Tracing.ConditionUpdate
			{
				missionId = missionNSuccessEvt.missionId,
				finished = true,
				descriptions = Singleton<MissionManager>.instance.GetMissionDescriptions(missionNSuccessEvt.missionId)
			};
			ProcessingTasks().Forget();
		}
	}

	private void OnTaskTipShowProceed(BaseEventContent obj)
	{
		MissionNTracingEvt missionNTracingEvt = obj as MissionNTracingEvt;
		if (!(m_Adapter.GetTaskTipState(missionNTracingEvt.missionId) is NewMissionStateAdapter proceed))
		{
			m_ClearProceed = true;
		}
		else
		{
			m_Proceed = proceed;
			m_ClearProceed = false;
		}
		ProcessingTasks().Forget();
	}

	private void OnTaskTipShowNewReceive(BaseEventContent obj)
	{
		MissionNAcceptEvt missionNAcceptEvt = obj as MissionNAcceptEvt;
		if (m_Adapter.GetTaskTipState(missionNAcceptEvt.missionId) is NewMissionStateAdapter receiveNew)
		{
			m_ReceiveNew = receiveNew;
			ProcessingTasks().Forget();
		}
	}

	private void OnTaskTipConditionChanged(BaseEventContent obj)
	{
		if (obj is MissionNConditionUpdateEvt missionNConditionUpdateEvt)
		{
			TaskTip_Tracing.ConditionUpdate conditionUpdate = new TaskTip_Tracing.ConditionUpdate();
			conditionUpdate.missionId = missionNConditionUpdateEvt.missionId;
			conditionUpdate.conditionId = missionNConditionUpdateEvt.conditionId;
			conditionUpdate.finished = missionNConditionUpdateEvt.finished;
			conditionUpdate.descriptions = Singleton<MissionManager>.instance.GetMissionDescriptions(missionNConditionUpdateEvt.missionId);
			m_ConditionUpdate = conditionUpdate;
			ProcessingTasks().Forget();
		}
	}

	private void OnMissionStageUpdate(BaseEventContent obj)
	{
		if (obj is MissionNStageUpdateEvt missionNStageUpdateEvt)
		{
			TaskTip_Tracing.StageUpdate stageUpdate = new TaskTip_Tracing.StageUpdate();
			stageUpdate.missionId = missionNStageUpdateEvt.missionId;
			stageUpdate.stageIndex = missionNStageUpdateEvt.stageIndex;
			m_StageUpdate = stageUpdate;
			ProcessingTasks().Forget();
		}
	}

	private async UniTaskVoid ProcessingTasks()
	{
		if (Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN) == UIState.Closed || m_Processing)
		{
			return;
		}
		m_Processing = true;
		try
		{
			bool lastCompleteIgnore = false;
			while (true)
			{
				if (m_ConditionUpdate != null)
				{
					TaskTip_Tracing.ConditionUpdate conditionUpdate = m_ConditionUpdate;
					m_ConditionUpdate = null;
					try
					{
						await taskTip_Tracing.OnMissionConditionUpdate(conditionUpdate);
					}
					catch (Exception message)
					{
						Debug.LogError(message);
					}
				}
				else if (m_StageUpdate != null)
				{
					TaskTip_Tracing.StageUpdate stageUpdate = m_StageUpdate;
					m_StageUpdate = null;
					try
					{
						taskTip_Tracing.OnMissionStageUpdate(stageUpdate);
					}
					catch (Exception message2)
					{
						Debug.LogError(message2);
					}
				}
				else if (m_Complete != null)
				{
					NewMissionStateAdapter complete = m_Complete;
					TaskTip_Tracing.ConditionUpdate completeUpdate = m_CompleteUpdate;
					m_Complete = null;
					m_CompleteUpdate = null;
					try
					{
						await taskTip_Tracing.OnMissionConditionUpdate(completeUpdate);
					}
					catch (Exception message3)
					{
						Debug.LogError(message3);
					}
					if (complete.m_MissionData.NextMissions != null && complete.m_MissionData.NextMissions.Count > 0)
					{
						MissionData missionData = complete.m_MissionData.NextMissions[0];
						MissionData missionData2 = complete.m_MissionData;
						MissionConfig config = missionData.Config;
						MissionConfig config2 = missionData2.Config;
						if (config2.MissionNameId == config.MissionNameId && config2.MissionTitleDescId == config.MissionTitleDescId)
						{
							lastCompleteIgnore = true;
							await UniTask.Delay(500);
							continue;
						}
					}
					lastCompleteIgnore = false;
					try
					{
						if (complete.IsLastMissionInGroup())
						{
							await taskTip_Success.Play(complete);
						}
					}
					catch (Exception message4)
					{
						Debug.LogError(message4);
					}
				}
				else if (m_Failure != null)
				{
					NewMissionStateAdapter failure = m_Failure;
					m_Failure = null;
					try
					{
						taskTip_Fail.Play(failure);
					}
					catch (Exception message5)
					{
						Debug.LogError(message5);
					}
				}
				else if (m_ReceiveNew != null)
				{
					NewMissionStateAdapter receiveNew = m_ReceiveNew;
					m_ReceiveNew = null;
					if (!lastCompleteIgnore)
					{
						try
						{
							await taskTip_New.Play(receiveNew);
						}
						catch (Exception message6)
						{
							Debug.LogError(message6);
						}
					}
				}
				else if (m_Proceed != null)
				{
					NewMissionStateAdapter proceed = m_Proceed;
					m_Proceed = null;
					try
					{
						taskTip_Tracing.RefreshMission(proceed);
					}
					catch (Exception message7)
					{
						Debug.LogError(message7);
					}
				}
				else
				{
					if (!m_ClearProceed)
					{
						break;
					}
					m_ClearProceed = false;
					taskTip_Tracing.Clear();
				}
			}
		}
		catch (Exception message8)
		{
			Debug.LogError(message8);
		}
		finally
		{
			m_Processing = false;
		}
	}

	private void OnDestroy()
	{
	}

	public void HideAll()
	{
		if ((bool)gameObject && (bool)canvasGroup)
		{
			canvasGroup.alpha = 0f;
		}
	}

	public void OnMissionTipClick()
	{
		if (!m_Adapter.HaveTracingMission())
		{
			return;
		}
		GameUtility.CalculateClosestMissionPoint(out MissionArrowData output);
		if (output != null)
		{
			if (output.missionPointData.IsSameArea)
			{
				output.arrow.HighLight();
			}
			else if (Model<BattleMainModel>.Interface.MiniMapModeDisabled)
			{
				output.arrow.HighLight();
			}
			else if (output.missionPointData.MapArea != MapArea.None)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_LARGEMAP, new LargeMapViewData
				{
					missionOpen = true,
					initPosition = output.missionPointData.GetActualPos(),
					initMapArea = output.missionPointData.MapArea
				});
			}
		}
	}

	public async void OnBattleMainCompletelyShow()
	{
		UpdateActive();
	}

	public void OnBattleMainHide()
	{
	}

	private void Update()
	{
	}
}
