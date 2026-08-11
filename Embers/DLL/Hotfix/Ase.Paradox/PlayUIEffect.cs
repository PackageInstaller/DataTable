using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放UI特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("在UI上播放特效，并将其附加到指定的目标单位列表中的一个或多个目标单位上。")]
public class PlayUIEffect : ActionTaskBase
{
	[Name("返回特效实体Id", 0)]
	[Description("特效实体的ID，用于后续操作。")]
	public BBParameter<int> effectEntityId = new BBParameter<int>();

	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要播放的UI特效的ID。")]
	public BBParameter<int> effectId = new BBParameter<int>();

	[Name("是否跟随绑点位置", 0)]
	public bool isFollowBone;

	[Name("是否跟随父节点销毁", 0)]
	[Description("特效是否跟随其父节点销毁。")]
	public bool followParentDispose;

	[RequiredField]
	[Name("目标单位列表", 0)]
	[Description("要将UI特效附加到的目标单位列表的ID。")]
	public BBParameter<List<int>> targetEntityList = new BBParameter<List<int>>();

	[RequiredField]
	[Name("目标单位", 0)]
	[Description("要将UI特效附加到的单个目标单位的ID。")]
	public BBParameter<int> targetId = new BBParameter<int>();

	protected override bool IsDisplayNode => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		bool flag = false;
		if (targetId != null)
		{
			flag = targetId.value == GetOwnerEntity().GetWorld().ActorId;
		}
		if (!flag && targetEntityList != null)
		{
			flag = targetEntityList.value.Contains(GetOwnerEntity().GetWorld().ActorId);
		}
		if (!flag)
		{
			OnActionFinish();
			return;
		}
		BaseEntity entity = GetEntity(GetOwnerEntity().GetWorld().ActorId, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFinish();
			return;
		}
		if (GetOwnerEntity().GetSystem<EffectSystem>() == null)
		{
			OnActionFinish();
			return;
		}
		BaseEntity baseEntity = ownerEntity.GetSystem<EffectSystem>().PlayEffect(entity, entity, EffectType.FOLLOW_UI, effectId.value, string.Empty, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, followParentDispose, 1f, isFollowBone);
		if (baseEntity != null)
		{
			effectEntityId.value = baseEntity.Id;
		}
		OnActionFinish();
	}
}
