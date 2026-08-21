using UnityEngine;

namespace Ase.ECS;

public class WarningIndicatorSystem : BaseSystem
{
	protected override bool IsLogicSystem => false;

	public WarningIndicatorEntity CreateWarnRingIndicator(WarningIndicatorData data)
	{
		if (data.commonData.Creator == null)
		{
			return null;
		}
		GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(data.shapeData.DrWarningIndicator.Id, data.shapeData.DrWarningIndicator.AssetsPath);
		EntityData entityData = EntityData.Create();
		entityData.entityObject = entityObject;
		entityData.userData = data;
		WarningIndicatorEntity warningIndicatorEntity = null;
		if (data is NormalWarningIndicatorData)
		{
			warningIndicatorEntity = GetSystem<EntitySystem>().CreateEntity<WarningIndicatorEntity>(data.shapeData.DrWarningIndicator.Id, entityData);
		}
		else if (data is FollowWarningIndicatorData)
		{
			warningIndicatorEntity = GetSystem<EntitySystem>().CreateEntity<FollowWarnIndicatorEntity>(data.shapeData.DrWarningIndicator.Id, entityData);
		}
		else if (data is TrackWarningIndicatorData)
		{
			warningIndicatorEntity = GetSystem<EntitySystem>().CreateEntity<TrackWarningIndicatorEntity>(data.shapeData.DrWarningIndicator.Id, entityData);
		}
		data.commonData.Creator.GetComponent<EntityWarningComponent>().CreateWarnIndicator(warningIndicatorEntity);
		return warningIndicatorEntity;
	}
}
