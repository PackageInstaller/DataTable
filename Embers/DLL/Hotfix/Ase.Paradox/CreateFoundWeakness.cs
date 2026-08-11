using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放破绽条", 0)]
[Category("✫ DragonLost/Weakness")]
[Description("在实体上创建斩味弱点，用于显示弱点条和配置弱点表现。")]
public class CreateFoundWeakness : ActionTaskBase
{
	[Name("是否选择自己", 0)]
	[Description("指示是否选择当前行为树的所有者作为目标实体。")]
	public bool Iself = true;

	[Name("实体Id", 0)]
	[Description("要设置属性值的目标实体的ID。")]
	[ShowIf("Iself", false)]
	public BBParameter<int> EntityId;

	[RequiredField]
	[Name("弱点时长", 0)]
	[Description("弱点持续的时间（秒）。")]
	public BBParameter<float> endureLifeTime;

	[RequiredField]
	[Name("弱点表现挂点", 0)]
	[Description("用于显示弱点效果的挂点名称。")]
	public BBParameter<string> boneName;

	[RequiredField]
	[Name("是否显示弱点条", 0)]
	[Description("指示是否显示弱点条。")]
	public BBParameter<bool> isShowWeaknessBar = new BBParameter<bool>(value: true);

	[RequiredField]
	[Name("弱点详细配置", 0)]
	[Description("弱点的详细配置列表。")]
	public BBParameter<List<FoundWeaknessData>> weaknessConfig;

	[Name("绑点名字", 0)]
	public string PointName = "Weakness";

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = (Iself ? ownerEntity : GetEntity(EntityId.value, isSyncEntity: false));
		if (baseEntity != null)
		{
			ownerEntity.GetSystem<WeaknessSystem>().CreateCutFlavourWeakness(endureLifeTime.value, weaknessConfig.value, baseEntity, boneName.value, isShowWeaknessBar.value, PointName);
		}
		if (LockstepData.Instance != null)
		{
			for (int i = 0; i < weaknessConfig.value.Count; i++)
			{
				FoundWeaknessData foundWeaknessData = weaknessConfig.value[i];
				LockstepData.Instance.WriteAuthorityEntityId($"播放破绽条 FoundWeaknessData CentralMoment = {foundWeaknessData.CentralMoment}  Level = {foundWeaknessData.Level}  Timer = {foundWeaknessData.Timer}", baseEntity);
			}
			LockstepData.Instance.WriteAuthorityEntityId($"播放破绽条 endureLifeTime {endureLifeTime.value} ", baseEntity);
		}
		EndAction();
	}
}
