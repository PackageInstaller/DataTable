using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开始前调整角色数据", 0)]
[Category("Render/UI")]
[Description("开始前调整角色数据, 填大于等于3的话, 就删掉这个角色不再出场, 如果一号位没有角色的话, 就顺延")]
public class ChangeRoleData : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> role1Input = AddValueInput<int>("一号位调整为").SetDefaultAndSerializedValue(0);
		ValueInput<int> role2Input = AddValueInput<int>("二号位调整为").SetDefaultAndSerializedValue(1);
		ValueInput<int> role3Input = AddValueInput<int>("三号位调整为").SetDefaultAndSerializedValue(2);
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.ready != null && battleScene.ready.SceneDataForExcehange != null && battleScene.ready.SceneDataForExcehange.RoleDataInLua != null)
			{
				RoleDataForExchangeInfo roleDataForExchangeInfo = null;
				int value = role1Input.value;
				if (value < battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count)
				{
					roleDataForExchangeInfo = battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(value);
				}
				RoleDataForExchangeInfo roleDataForExchangeInfo2 = null;
				int value2 = role2Input.value;
				if (value2 < battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count)
				{
					roleDataForExchangeInfo2 = battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(value2);
				}
				RoleDataForExchangeInfo roleDataForExchangeInfo3 = null;
				int value3 = role3Input.value;
				if (value3 < battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count)
				{
					roleDataForExchangeInfo3 = battleScene.ready.SceneDataForExcehange.RoleDataInLua.get_Item(value3);
				}
				if (roleDataForExchangeInfo != null || roleDataForExchangeInfo2 != null || roleDataForExchangeInfo3 != null)
				{
					battleScene.ready.SceneDataForExcehange.RoleDataInLua.Clear();
					if (roleDataForExchangeInfo != null)
					{
						battleScene.ready.SceneDataForExcehange.RoleDataInLua.Add(roleDataForExchangeInfo);
					}
					if (roleDataForExchangeInfo2 != null)
					{
						battleScene.ready.SceneDataForExcehange.RoleDataInLua.Add(roleDataForExchangeInfo2);
					}
					if (roleDataForExchangeInfo3 != null)
					{
						battleScene.ready.SceneDataForExcehange.RoleDataInLua.Add(roleDataForExchangeInfo3);
					}
				}
			}
			f.Call(output);
		});
	}
}
