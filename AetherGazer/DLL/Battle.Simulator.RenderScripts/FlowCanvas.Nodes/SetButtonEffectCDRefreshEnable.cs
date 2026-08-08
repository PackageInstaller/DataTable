using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗按钮UICD刷新动效显示(过时)", 0)]
[Category("Render/UI")]
[Description("战斗按钮UICD刷新动效显示")]
public class SetButtonEffectCDRefreshEnable : SetButtonEffectEnable
{
	protected override void Invoke(AbilityButtonEffect abilityButtonEffect, bool enable)
	{
		abilityButtonEffect.ShowCDRefreshEffect = enable;
	}
}
