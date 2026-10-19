using ACT.Battle.Configs;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoInteractTipUI : MonoBehaviour
{
	public YooAssetReference atlasRefAssetID;

	public SpriteRenderer spriteRenderer;

	public SpriteRenderer mainMission;

	public SpriteRenderer mainMissionCanBeTake;

	public SpriteRenderer subMission;

	public SpriteRenderer subMissionCanBeTake;

	private Transform m_Sync;

	private int m_Uid;

	public async void Init(int uid, int icon, Transform transform)
	{
		m_Uid = uid;
		this.spriteRenderer.gameObject.SetActive(value: false);
		m_Sync = transform;
		SpriteRenderer spriteRenderer = this.spriteRenderer;
		spriteRenderer.sprite = await this.GetImageStation().LoadSpriteAsync(atlasRefAssetID, icon);
		this.spriteRenderer.gameObject.SetActive(value: true);
		RefreshMission(null);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Mission_Finish, RefreshMission);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SubMission_Finish, RefreshMission);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Mission_Receive, RefreshMission);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, RefreshMission);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateMissionArrow, RefreshMission);
	}

	private void RefreshMission(BaseEventContent obj)
	{
		MissionPointData missionPointData = null;
		foreach (MissionArrowData currentTrackMissionData in Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas())
		{
			if (currentTrackMissionData.missionPointData is StateObjectMissionPoint stateObjectMissionPoint && stateObjectMissionPoint.InteractObjId == m_Uid)
			{
				missionPointData = currentTrackMissionData.missionPointData;
			}
		}
		bool flag = false;
		if (missionPointData != null)
		{
			if (Singleton<MissionManager>.instance.GetMissionConfig(missionPointData.MissionId).MissionType == 1)
			{
				flag = true;
			}
			spriteRenderer.gameObject.SetActive(value: false);
			mainMission.gameObject.SetActive(flag);
			subMission.gameObject.SetActive(!flag);
		}
		else
		{
			spriteRenderer.gameObject.SetActive(value: true);
			mainMission.gameObject.SetActive(value: false);
			subMission.gameObject.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (m_Sync != null)
		{
			transform.position = m_Sync.position;
		}
	}

	public void UnInit()
	{
		this.GetImageStation().UnloadSprite(atlasRefAssetID);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Mission_Finish, RefreshMission);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SubMission_Finish, RefreshMission);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Mission_Receive, RefreshMission);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, RefreshMission);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateMissionArrow, RefreshMission);
	}
}
