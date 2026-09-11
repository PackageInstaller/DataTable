using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTShowSkillHudNode : BActionNode
{
	public string stringKey;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase caster = env.GetPlayer<BilliardGameEntityBase>("Caster");
		string skillText = LuaHelper.CallFunction("GetTips", stringKey)[0].ToString();
		if (caster != null && stringKey != "" && skillText != "")
		{
			FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				BilliardGameUIManager.Instance.ShowSkillHud(skillText, caster.go.transform);
			}, 0.33f, 1);
		}
		return BTNodeStatus.Success;
	}
}
