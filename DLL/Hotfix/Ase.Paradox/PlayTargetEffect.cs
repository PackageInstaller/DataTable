using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放目标特效", 0)]
[Category("✫ DragonLost/Effect")]
[Description("播放特效并将其附加到目标单位。")]
public class PlayTargetEffect : ActionTaskBase
{
	[ShowIf("manualDispose", 1)]
	[Name("缓存列表", 0)]
	[Description("手动回收特效的实体列表。")]
	public BBParameter<List<BaseEntity>> cacheEntities;

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

	[Name("是否跟随父节点销毁", 0)]
	[Description("特效是否跟随目标单位销毁。")]
	public bool followParentDispose;

	[Name("手动回收", 0)]
	[Description("是否手动回收特效的实体。")]
	public bool manualDispose;

	[RequiredField]
	[Name("目标单位", 0)]
	[Description("特效将附加到的目标单位的ID。")]
	public BBParameter<int> targetEntityId;

	protected override bool IsDisplayNode => true;

	protected override async void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
