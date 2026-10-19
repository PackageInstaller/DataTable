using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Utility;
using Fundamental;

namespace ACT.Model;

public class BattleMainTaskTipModelV2 : Model<BattleMainTaskTipModelV2>
{
	public enum MissionState
	{
		None,
		Failure,
		Success,
		Tracing,
		Cancel,
		Accept,
		TracingStageUpdate
	}

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Accept, OnMissionAccept);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Tracing, OnMissionTracing);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_TracingStageUpdate, OnTracingMissionStageUpdate);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateMissionArrow, RefreshMission);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Accept, OnMissionAccept);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Tracing, OnMissionTracing);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Failure, OnMissionFailure);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_TracingStageUpdate, OnTracingMissionStageUpdate);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateMissionArrow, RefreshMission);
	}

	private void OnMissionAccept(BaseEventContent obj)
	{
		MissionNAcceptEvt missionNAcceptEvt = obj as MissionNAcceptEvt;
		if (RuntimeConfigs.data.missionBases.TryGetValue(missionNAcceptEvt.missionId, out var value) && !value.isHidden)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionNTip_Accept, missionNAcceptEvt);
		}
	}

	private void OnMissionTracing(BaseEventContent obj)
	{
		MissionNTracingEvt missionNTracingEvt = obj as MissionNTracingEvt;
		MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionNTracingEvt.missionId);
		if (missionData == null || !missionData.Config.MissionBase.isHidden)
		{
			if (GameUtility.gameLoader.IsNetMode)
			{
				Singleton<MissionManager>.instance.RefreshRedDot();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionNTip_Tracing, missionNTracingEvt);
		}
	}

	private void OnMissionFailure(BaseEventContent obj)
	{
		MissionNFailureEvt missionNFailureEvt = obj as MissionNFailureEvt;
		if (!IsHidden(missionNFailureEvt.missionId))
		{
			if (GameUtility.gameLoader.IsNetMode)
			{
				Singleton<MissionManager>.instance.RefreshRedDot();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionNTip_Failure, missionNFailureEvt);
		}
	}

	private void OnMissionSuccess(BaseEventContent obj)
	{
		MissionNSuccessEvt missionNSuccessEvt = obj as MissionNSuccessEvt;
		if (!IsHidden(missionNSuccessEvt.missionId))
		{
			if (GameUtility.gameLoader.IsNetMode)
			{
				Singleton<MissionManager>.instance.RefreshRedDot();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionNTip_Success, missionNSuccessEvt);
		}
	}

	private void OnTracingMissionStageUpdate(BaseEventContent obj)
	{
		MissionNStageUpdateEvt missionNStageUpdateEvt = obj as MissionNStageUpdateEvt;
		if (!IsHidden(missionNStageUpdateEvt.missionId))
		{
			if (GameUtility.gameLoader.IsNetMode)
			{
				Singleton<MissionManager>.instance.RefreshRedDot();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.MissionNTip_TracingStageUpdate, missionNStageUpdateEvt);
		}
	}

	private bool IsHidden(int missionId)
	{
		return Singleton<MissionManager>.instance.GetMissionData(missionId)?.Config.MissionBase.isHidden ?? false;
	}

	public void RefreshMission(BaseEventContent obj = null)
	{
		if (!MonoECS.instance.IsNotInMain)
		{
			int tracingMission = Singleton<MissionManager>.instance.GetTracingMission();
			MissionNTracingEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNTracingEvt>();
			evt.missionId = tracingMission;
			OnMissionTracing(evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
