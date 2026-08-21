using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置特殊UI浮动", 0)]
[Category("Render/UI")]
[Description("指定的UI会跟随某个实体，有缓动，路径相对于战斗面板,死区是距离目标点多远就不移动了，缓动区域是预制体UI离目标点最远距离")]
public class CustomUIFollow : FlowNode
{
	private SpecialUIIcon _com;

	private Transform _parent;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)", "path");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)", "parentPath").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字", "name");
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID", "实体ID");
		ValueInput<Vector3> offsetInput = AddValueInput<Vector3>("偏移(相对于脚底)", "offset");
		ValueInput<float> deadZoomInput = AddValueInput<float>("死区", "deadZoom");
		ValueInput<float> slowZoomInput = AddValueInput<float>("缓动区域", "slowZoom").SetDefaultAndSerializedValue(200f);
		ValueInput<float> lerpTimeInput = AddValueInput<float>("缓动时间", "lerpTime").SetDefaultAndSerializedValue(1f);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			if (_com == null)
			{
				Debug.LogError("设置特殊UI浮动 没有初始化");
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
				if (agent == null)
				{
					Debug.LogError("设置特殊UI浮动 无法找到跟随对象 " + agentIDInput.value);
					errorOut.Call(f);
				}
				else
				{
					U3DUtil.Get<RoleUIFollow>(_com.gameObject).Init(agent.transform, offsetInput.value, _com.transform as RectTransform, _parent as RectTransform, deadZoomInput.value, slowZoomInput.value, lerpTimeInput.value);
					output.Call(f);
				}
			}
		});
		void Init()
		{
			if (_com == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(parentPathInput.value);
				_parent = transform;
				Transform transform2 = transform.Find(nameInput.value);
				if (transform2 == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(pathInput.value, transform);
					gameObject.name = nameInput.value;
					transform2 = gameObject.transform;
					_com = transform2.GetComponent<SpecialUIIcon>();
					_com.Clear(isEnable: false);
				}
				_com = transform2.GetComponent<SpecialUIIcon>();
			}
		}
	}
}
