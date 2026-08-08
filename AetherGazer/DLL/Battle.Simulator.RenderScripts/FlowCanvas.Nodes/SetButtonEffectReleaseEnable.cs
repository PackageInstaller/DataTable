using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UI技能连续点击动效显示(过时)", 0)]
[Category("Render/UI")]
[Description("战斗按钮UI技能切换动效显示")]
public class SetButtonEffectReleaseEnable : SetButtonEffectEnable
{
	protected override void Invoke(AbilityButtonEffect abilityButtonEffect, bool enable)
	{
		abilityButtonEffect.ShowReleaseEffect = enable;
	}
}
