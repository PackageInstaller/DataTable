using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体位置（受击盒选取）", 0)]
[Category("✫ DragonLost/Entity")]
public class GetEntityHitVolumePosition : ActionTaskBase
{
	[Name("返回坐标", 0)]
	[Description("存储获取到的实体位置。")]
	public BBParameter<Vector3> positionParam;

	[Name("目标实体", 0)]
	[Description("要获取位置的目标实体的ID。如果目标实体为空，则会返回自身的坐标。")]
	[Tooltip("目标实体为空时，则会返回自身的坐标。")]
	public BBParameter<int> targetId;

	[Name("目标受击盒名称", 0)]
	public BBParameter<string> hitBoxKey;

	[Name("是否只获取投影位置", 0)]
	public bool isProjection;

	[Name("是否包含关闭的受击盒", 0)]
	public bool isContainCloseHitBox;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: true);
		if (entity == null)
		{
			EndAction();
			return;
		}
		positionParam.value = entity.transform.position;
		if (!string.IsNullOrEmpty(hitBoxKey.value))
		{
			Vector3 vector = Vector3.zero;
			HitVolume hitVolume = entity.GetSystem<VolumeSystem>()?.GetEntityVolume(entity.Id, hitBoxKey.value, isContainCloseHitBox);
			if (hitVolume != null)
			{
				vector = ((!isProjection) ? (entity.transform.rotation * hitVolume.VolumeData.offset) : (entity.transform.rotation * new Vector3(hitVolume.VolumeData.offset.x, 0f, hitVolume.VolumeData.offset.z)));
			}
			positionParam.value += vector;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取实体位置 {positionParam.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
