using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示伤害文字", 0)]
[Category("✫ DragonLost/DamageText")]
[Description("显示伤害文字，用于在游戏中展示伤害数值等信息")]
public class ShowDamageText : ActionTaskBase
{
	[Name("显示文字", 0)]
	[Description("要显示的伤害文字内容。")]
	public BBParameter<string> showText;

	protected override void OnExecute()
	{
		base.OnExecute();
		UIDamageTextSystem system = ownerEntity.GetSystem<UIDamageTextSystem>();
		if (system != null)
		{
			TextDamageParam textDamageParam = ReferencePool.Acquire<TextDamageParam>();
			textDamageParam.showContent = showText.value;
			textDamageParam.WeaknessLevel = 3;
			system.ShowStackDamageText(textDamageParam, ownerEntity);
			OnActionFinish();
		}
	}
}
