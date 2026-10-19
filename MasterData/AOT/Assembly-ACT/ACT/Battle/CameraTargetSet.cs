using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CameraTargetSet : MonoBehaviour
{
	public ConditionalCamera conditionalCamera;

	private void OnEnable()
	{
		if (MonoECS.instance != null && MonoECS.instance.mainEntity != null)
		{
			conditionalCamera.enabled = true;
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, ChangeCamFollow);
		if (conditionalCamera.cameraType == ACT.Battle.Configs.CameraType.TargetGroup)
		{
			ACTAreaCameraTargetGroup.RefreshPlayerSlot(conditionalCamera.targertGroup);
		}
	}

	public void ChangeCamFollow(BaseEventContent obj)
	{
		Transform modelTrans = ((BattleCharacterChangeEvt)obj).newEb.GetModelTrans();
		switch (conditionalCamera.cameraType)
		{
		case ACT.Battle.Configs.CameraType.FollowOwner:
			conditionalCamera.vCamera.Follow = modelTrans;
			break;
		case ACT.Battle.Configs.CameraType.TargetGroup:
			ACTAreaCameraTargetGroup.RefreshPlayerSlot(conditionalCamera.targertGroup);
			break;
		case ACT.Battle.Configs.CameraType.None:
		case ACT.Battle.Configs.CameraType.FollowPoint:
		case ACT.Battle.Configs.CameraType.SelfTarget:
		case ACT.Battle.Configs.CameraType.Static:
			break;
		}
	}

	private void OnDisable()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, ChangeCamFollow);
	}
}
