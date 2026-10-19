using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ChaseMissionPoint : StateObjectMissionPoint
{
	public ChaseMissionPoint(int missionId, int pointId, bool use3DLogic, MapArea area, int interactObjId, bool needEffect, bool custom = false, Vector3 customPosition = default(Vector3))
		: base(missionId, pointId, use3DLogic, area, interactObjId, needEffect, custom, customPosition)
	{
	}

	public override void Init()
	{
	}

	public override Vector3 GetActualPos()
	{
		if (m_Custom)
		{
			return m_CustomPosition;
		}
		if (MonoECS.instance.ruleManager.TryGetWorldStateAsset(InteractObjId, out var asset))
		{
			if (asset.stateObjectBase is InteractBehaveAnimControl interactBehaveAnimControl)
			{
				return (interactBehaveAnimControl?.GetBehaveWorldPos()).Value;
			}
			if (asset.stateObjectBase is InteractBehaveAnimControlEx interactBehaveAnimControlEx)
			{
				return (interactBehaveAnimControlEx?.GetBehaveWorldPos()).Value;
			}
			if (asset.stateObjectBase is InteractBehaveControl interactBehaveControl && interactBehaveControl.ControlEb.TryGetCompTransform(out CompTransform component))
			{
				return component.physicsPosition + Vector3.up * 2f;
			}
			return Vector3.zero;
		}
		return Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(InteractObjId)?.initPos ?? Vector3.zero;
	}

	public string GetCurrTaskText()
	{
		if (!MonoECS.instance.ruleManager.TryGetWorldStateAsset(InteractObjId, out var asset))
		{
			return "";
		}
		if (!(asset.stateObjectBase is InteractBehaveAnimControlEx interactBehaveAnimControlEx))
		{
			return "";
		}
		if (interactBehaveAnimControlEx.behave.fail)
		{
			return "捕捉失败";
		}
		if (interactBehaveAnimControlEx.behave.toEnd && !interactBehaveAnimControlEx.behave.fail)
		{
			return "捕捉成功";
		}
		return "";
	}

	public bool IsFail()
	{
		if (!MonoECS.instance.ruleManager.TryGetWorldStateAsset(InteractObjId, out var asset) || !(asset.stateObjectBase is InteractBehaveAnimControlEx interactBehaveAnimControlEx))
		{
			return false;
		}
		return interactBehaveAnimControlEx.behave.fail;
	}
}
