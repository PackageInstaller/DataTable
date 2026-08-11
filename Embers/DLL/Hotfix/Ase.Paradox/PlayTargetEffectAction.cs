using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("给目标播放特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("播放特效并将其附加到目标单位。")]
public class PlayTargetEffectAction : ActionTaskBase
{
	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要播放的特效的ID。")]
	public BBParameter<int> effectId;

	[HideIf("effectType", 2, 3)]
	[BlackboardOnly]
	[Name("特效挂点", 0)]
	[Description("特效应该附加到目标的挂点名称。")]
	public string effectKey;

	[Name("位置偏移量", 0)]
	[Description("特效相对于目标的位置偏移量。")]
	public Vector3 effectOffset = Vector3.zero;

	[ShowIf("effectType", 3)]
	[Name("特效坐标", 0)]
	[Description("特效在场景中的固定位置坐标。")]
	public BBParameter<Vector3> effectPoint;

	[ShowIf("effectType", 3)]
	[Name("特效旋转", 0)]
	[Description("特效的初始旋转角度。")]
	public BBParameter<Vector3> effectRotation;

	[Name("缩放倍率", 0)]
	[Description("特效的缩放倍率。")]
	public BBParameter<float> effectScale = 1f;

	[RequiredField]
	[Tooltip("特效类型。如果非跟随实体特效，则需要设置特效挂点。")]
	[Name("特效类型", 0)]
	[Description("特效应该如何相对于目标单位播放。")]
	public EffectType effectType;

	[ShowIf("effectType", 4)]
	[Name("是否跟随绑点位置", 0)]
	public bool isFollowBone;

	[Name("是否跟随父节点销毁", 0)]
	[Description("特效是否跟随目标单位销毁。")]
	public bool followParentDispose;

	[RequiredField]
	[Name("目标单位", 0)]
	[Description("特效将附加到的目标单位的ID。")]
	public BBParameter<int> targetEntityId;

	[RequiredField]
	[Name("返回的实体ID", 0)]
	[Description("返回的实体ID,用于回收")]
	public BBParameter<int> EntityId;

	protected override bool IsDisplayNode => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(targetEntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFail();
			return;
		}
		EffectSystem system = ownerEntity.GetSystem<EffectSystem>();
		if (system == null)
		{
			OnActionFail();
			return;
		}
		if (ownerEntity.GetSystem<EntitySystem>().GetEntityIsTeam(ownerEntity) && system.GetTeammateSkillEffectAlpha(effectId.value) == 0f)
		{
			OnActionFinish();
			return;
		}
		BaseEntity baseEntity = system.PlayEffect(ownerEntity, entity, effectType, effectId.value, effectKey, effectPoint.value, effectRotation.value, effectOffset, Vector3.zero, followParentDispose, effectScale.value, isFollowBone);
		EntityId.value = baseEntity?.Id ?? 0;
		EndAction();
	}
}
