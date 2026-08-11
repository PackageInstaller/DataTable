using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("播放指定的特效，支持不同的特效类型和参数设置。")]
public class PlayEffect : ActionTaskBase
{
	private EffectEntity _effectEntity;

	[RequiredField]
	[Name("特效Id", 0)]
	[Description("要播放的特效的ID。")]
	public BBParameter<int> effectId;

	[HideIf("effectType", 3)]
	[BlackboardOnly]
	[Name("特效挂点", 0)]
	[Description("特效将被放置的挂点。仅适用于跟随实体的特效。")]
	public string effectKey = "center";

	[Name("位置偏移量", 0)]
	[Description("特效的位置偏移量。")]
	public BBParameter<Vector3> effectOffset = Vector3.zero;

	[ShowIf("effectType", 3)]
	[Name("特效坐标", 0)]
	[Description("特效的固定位置坐标。仅适用于固定点的特效。")]
	public BBParameter<Vector3> effectPoint;

	[Name("缩放倍率", 0)]
	[Description("特效的缩放倍率。")]
	public BBParameter<float> effectScale = 1f;

	[RequiredField]
	[Name("特效类型", 0)]
	[Description("要播放的特效类型。")]
	public EffectType effectType;

	[ShowIf("effectType", 4)]
	[Name("是否跟随绑点位置", 0)]
	public bool isFollowBone;

	[Name("是否跟随父节点销毁", 0)]
	[Description("特效是否跟随其父节点销毁。")]
	public bool followParentDispose;

	[Name("跟随行为树销毁", 0)]
	[Description("特效是否跟随行为树销毁。")]
	public bool followTreeDead;

	[Name("行为树结束取消跟随", 0)]
	public bool isDisposeFollowEntity;

	[Name("返回特效Id", 0)]
	[Description("播放的特效的ID将被写入此变量。")]
	public BBParameter<int> returnEffectId;

	[Name("旋转偏移量", 0)]
	[Description("特效的旋转偏移量（仅限于Y轴）。")]
	public BBParameter<float> rotationOffsetY = 0f;

	protected override bool IsDisplayNode => true;

	protected override async void OnExecute()
	{
		base.OnExecute();
		EffectSystem system = ownerEntity.GetSystem<EffectSystem>();
		if (system == null)
		{
			OnActionFail();
			return;
		}
		_effectEntity = (EffectEntity)system.PlayEffect(ownerEntity, ownerEntity, effectType, effectId.value, effectKey, effectPoint.value, effectOffset.value, Quaternion.identity.eulerAngles, new Vector3(0f, rotationOffsetY.value, 0f), followParentDispose, effectScale.value, isFollowBone);
		if (_effectEntity != null)
		{
			_effectEntity.EffectData.FollowTreeStop = followTreeDead;
			returnEffectId.value = _effectEntity.Id;
			if (effectType == EffectType.FOLLOW_BONE || effectType == EffectType.FOLLOW_ENTITY || effectType == EffectType.FOLLOW_BONE_SCREEN_LIMIT || effectType == EffectType.FOLLOW_BONE_POSITION)
			{
				ownerEntity.GetComponent<EffectControlComponent>()?.AddEffect(_effectEntity);
			}
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (isDisposeFollowEntity && _effectEntity != null && _effectEntity.IsSurvival)
		{
			_effectEntity.GetComponent<FollowParentEntityTransformComponent>()?.StopFollow();
		}
		if (_effectEntity != null && _effectEntity.IsSurvival && _effectEntity.EffectData.FollowTreeStop)
		{
			_effectEntity.GetSystem<EntitySystem>().DoEntityDestroy(_effectEntity.Id);
		}
	}
}
