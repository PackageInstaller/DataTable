using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取随机敌对目标", 0)]
[Description("从敌对目标列表中随机选择一个敌对目标，并可选择是否设置目标位置和朝向。")]
[Category("✫ DragonLost/Target")]
public class GetRandomHostileTarget : ActionTaskBase
{
	[Name("特效挂点", 0)]
	[ShowIf("useBonePoint", 1)]
	[Description("要设置目标位置和朝向的特效挂点名称。")]
	public string effectKey;

	[Name("是否从敌对列表中随机获取", 0)]
	[Description("确定是否从敌对目标列表中随机获取敌对目标。")]
	public bool isFromHostile;

	[Name("是否同时设置位置旋转", 0)]
	[Description("确定是否设置获取的敌对目标的位置和朝向。")]
	public bool setTargetPos;

	[Name("敌对目标", 0)]
	[Description("存储获取的敌对目标的实体ID。")]
	public BBParameter<int> targetEntityId;

	[Name("敌对列表", 0)]
	[ShowIf("isFromHostile", 1)]
	[Description("存储敌对目标的实体ID列表。")]
	public BBParameter<List<int>> targetIdList;

	[Name("目标位置", 0)]
	[ShowIf("setTargetPos", 1)]
	[Description("存储获取的敌对目标的位置。")]
	public BBParameter<Vector3> targetPosition;

	[Name("目标朝向", 0)]
	[ShowIf("setTargetPos", 1)]
	[Description("存储获取的敌对目标的朝向。")]
	public BBParameter<Vector3> targetRotation;

	[Name("使用绑点", 0)]
	[ShowIf("setTargetPos", 1)]
	[Description("确定是否使用特效挂点设置目标位置和朝向。")]
	public bool useBonePoint;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (isFromHostile)
		{
			if (targetIdList == null || targetIdList.value.Count <= 0)
			{
				OnActionFinish();
				return;
			}
			int num = ownerEntity.RandomInt(0, targetIdList.value.Count);
			targetEntityId.value = num;
			SetTargetPositionAndRotation(GetEntity(num, isSyncEntity: true));
		}
		OnActionFinish();
	}

	private void SetTargetPositionAndRotation(BaseEntity target)
	{
		if (!setTargetPos)
		{
			return;
		}
		if (useBonePoint)
		{
			EntityBoneComponent component = target.GetComponent<EntityBoneComponent>();
			if (component != null)
			{
				Transform boneRoot = component.GetBoneRoot(effectKey);
				if (boneRoot != null)
				{
					targetPosition.value = boneRoot.position;
					targetRotation.value = boneRoot.eulerAngles;
					return;
				}
			}
		}
		targetPosition.value = target.transform.position;
		targetRotation.value = target.transform.rotation.eulerAngles;
	}
}
