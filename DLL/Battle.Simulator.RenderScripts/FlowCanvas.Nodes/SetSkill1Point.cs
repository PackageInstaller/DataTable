using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置薇儿丹蒂1技能UI点数", 0)]
[Category("Render/Role/1084")]
[Description("设置薇儿丹蒂1技能UI点数")]
public class SetSkill1Point : FlowNode
{
	private FlowOutput _out;

	private ValueInput<int> _pointNumInput;

	protected override void RegisterPorts()
	{
		_pointNumInput = AddValueInput<int>("点数");
		_out = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			GameObject.Find("/UICamera/Canvas/UIMain/BattlePanel/ScreenAdjustContainer/PlayerInfo/1084(Clone)0").GetComponent<RoleUI1084>().SetSkillCount(_pointNumInput.value);
			_out.Call(f);
		});
	}
}
