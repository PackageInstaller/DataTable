using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示战斗暂停界面", 0)]
[Category("Render/UI")]
[Description("显示战斗暂停界面")]
[ExposeAsDefinition]
public class SendBattleDataInPause : CallableFunctionNode<bool, BattleResultForLua>
{
	public override bool Invoke(BattleResultForLua battleResult)
	{
		if (LuaHelper.IsLuaClientInited())
		{
			LuaHelper.CallFunction("ShowBattlePausePage", battleResult, BattleScene.Newbie);
			return true;
		}
		return false;
	}
}
