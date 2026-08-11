using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放普通弱点", 0)]
[Category("✫ DragonLost/Weakness")]
[Description("在实体上创建普通弱点，用于显示弱点条和配置弱点表现。")]
public class CreatNormalWeaknessAction : ActionTaskBase
{
	[RequiredField]
	[Name("弱点时长", 0)]
	[Description("弱点持续的时间（秒）。")]
	public BBParameter<float> EndureLifeTime;

	[RequiredField]
	[Name("弱点表现挂点", 0)]
	[Description("用于显示弱点效果的挂点名称。")]
	public BBParameter<string> BoneName;

	[RequiredField]
	[Name("弱点详细配置", 0)]
	[Description("弱点的详细配置列表。")]
	public BBParameter<List<MomentWeaknessData>> weakessConfig;

	[RequiredField]
	[Name("是否显示弱点条", 0)]
	[Description("指示是否显示弱点条。")]
	public BBParameter<bool> isShowWeaknessBar = new BBParameter<bool>(value: true);

	[Name("绑点名字", 0)]
	public string PointName = "Weakness";

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<WeaknessSystem>().CreateNormalWeakness(EndureLifeTime.value, weakessConfig.value, ownerEntity, BoneName.value, isShowWeaknessBar.value, PointName);
		EndAction(success: true);
	}
}
