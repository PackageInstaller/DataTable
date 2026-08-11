#define ENABLE_LOG
using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("播放连接特效", 0)]
[Description("播放连接特效，并指定连接的类型和位置。")]
[Category("✫ DragonLost/Effect")]
public class PlayLinkEffect : ActionTaskBase
{
	[Name("特效ID", 0)]
	[Description("要播放的特效的配置ID")]
	public int EffectConfigId;

	[Name("连接类型", 0)]
	[Description("指定特效播放的连接类型")]
	public EffectPlayPositionType LinkType;

	[Name("发起方实体ID", 0)]
	[Description("连接的发起方实体的ID")]
	public BBParameter<int> StartEntityId;

	[Name("连接方实体ID", 0)]
	[Description("连接的目标实体的ID")]
	public BBParameter<int> TargetEntityId;

	[HideIf("LinkType", 0, 2)]
	[Name("发起方位置", 0)]
	[Description("连接的发起方位置，仅在连接类型为位置和位置时有效")]
	public BBParameter<Vector3> StartPosition;

	[HideIf("LinkType", 0, 2)]
	[Name("连接方位置", 0)]
	[Description("连接的目标位置，仅在连接类型为位置和位置时有效")]
	public BBParameter<Vector3> TargetPosition;

	[ShowIf("LinkType", 0)]
	[Name("发起方绑点", 0)]
	[Description("连接的发起方绑定点名称，仅在连接类型为绑点和绑点时有效")]
	public BBParameter<string> StartPointkey;

	[ShowIf("LinkType", 0)]
	[Name("连接方绑点", 0)]
	[Description("连接的目标绑定点名称，仅在连接类型为绑点和绑点时有效")]
	public BBParameter<string> TargetPointkey;

	[Name("返回的特效ID", 0)]
	[Description("用于存储创建的特效实体的ID")]
	public BBParameter<int> EffectId;

	protected override bool IsDisplayNode => true;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(StartEntityId.value, isSyncEntity: false);
		BaseEntity entity2 = GetEntity(TargetEntityId.value, isSyncEntity: false);
		if (entity == null || entity2 == null)
		{
			LogActionError("播放连接特效错误：实体为空!");
			EndAction();
			return;
		}
		LinkEffectData linkEffectData = ReferencePool.Acquire<LinkEffectData>();
		linkEffectData.LinkEffectType = LinkType;
		linkEffectData.OwnerEntity = entity;
		linkEffectData.LinkEntity = entity2;
		linkEffectData.StartKey = StartPointkey.value;
		linkEffectData.LinkKey = TargetPointkey.value;
		linkEffectData.StartPosition = StartPosition.value;
		linkEffectData.LinkPosition = TargetPosition.value;
		BaseEntity baseEntity = ownerEntity.GetSystem<EffectSystem>().PlayLinkEffect(ownerEntity, EffectConfigId, linkEffectData);
		EffectId.value = baseEntity?.Id ?? 0;
		EndAction();
	}
}
