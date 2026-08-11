using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放跟随子弹的特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("播放跟随子弹移动的特效。")]
public class PlayFollowBulletEffect : ActionTaskBase
{
	private EffectEntity _effectEntity;

	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要播放的特效的ID。")]
	public BBParameter<int> effectId;

	[RequiredField]
	[Name("子弹实体Id", 0)]
	[Description("要跟随的子弹实体的ID。")]
	public BBParameter<int> bulletId;

	[Name("位置偏移量", 0)]
	[Description("特效相对于子弹的位置偏移量。")]
	public BBParameter<Vector3> effectOffset = Vector3.zero;

	[Name("缩放倍率", 0)]
	[Description("特效的缩放倍率。")]
	public BBParameter<float> effectScale = 1f;

	private EffectType effectType = EffectType.FOLLOW_ENTITY;

	[Name("是否跟随父节点销毁", 0)]
	[Description("特效是否跟随其父节点销毁。")]
	public bool followParentDispose;

	[Name("跟随行为树销毁", 0)]
	[Description("特效是否跟随行为树销毁。")]
	public bool followTreeDead;

	[Name("返回特效Id", 0)]
	[Description("播放的特效的ID将被写入此变量。")]
	public BBParameter<int> returnEffectId;

	[Name("旋转偏移量", 0)]
	[Description("特效的旋转偏移量（仅限于Y轴）。")]
	public BBParameter<float> rotationOffsetY = 0f;

	[Name("特效是否需要插值运动", 0)]
	[Description("子弹加载的特效是否需要插值")]
	public bool ViewIsNeedLerp;

	[Name("特效移动的插值速度", 0)]
	[Description("特效移动的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableMovementSharpness = 0.2f;

	[Name("特效旋转的插值速度", 0)]
	[Description("特效旋转的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableRotationSharpness = 0.033f;

	protected override void OnExecute()
	{
		base.OnExecute();
		EffectSystem system = ownerEntity.GetSystem<EffectSystem>();
		if (system == null)
		{
			OnActionFail();
			return;
		}
		EntitySystem system2 = ownerEntity.GetSystem<EntitySystem>();
		if (system2 == null)
		{
			OnActionFail();
			return;
		}
		BulletEntity bulletEntity = (BulletEntity)system2.GetEntity(bulletId.value, isGetCache: true);
		if (bulletEntity == null)
		{
			OnActionFinish();
			return;
		}
		_effectEntity = (EffectEntity)system.PlayFollowBulletEffect(bulletEntity.Parent, bulletEntity, effectType, effectId.value, effectOffset.value, new Vector3(0f, rotationOffsetY.value, 0f), followParentDispose, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness, effectScale.value);
		if (_effectEntity != null)
		{
			_effectEntity.EffectData.FollowTreeStop = followTreeDead;
			returnEffectId.value = _effectEntity.Id;
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (_effectEntity != null && _effectEntity.IsSurvival && ownerEntity != null && _effectEntity.EffectData.FollowTreeStop)
		{
			ownerEntity.GetSystem<EntitySystem>().DoEntityDestroy(returnEffectId?.value ?? 0);
		}
	}
}
