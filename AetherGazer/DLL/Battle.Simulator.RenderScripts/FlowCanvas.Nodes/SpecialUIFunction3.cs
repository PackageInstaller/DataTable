using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置特殊UI进度", 0)]
[Category("Render/UI")]
[Description("基于【设置特殊UI标记】增加进度控制功能,\n路径 和 父节点相对路径 和 实例名字 这三个参数只有在 初始化 的时候有用\n下标 和 是否激活 这两个参数只有在 设置指定icon 的时候有用\n")]
public class SpecialUIFunction3 : FlowNode
{
	private SpecialUIIcon _com;

	private Slider _progressImg;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径(预制体加载路径)");
		ValueInput<string> parentPathInput = AddValueInput<string>("父节点相对路径(相对于战斗面板)").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<string> nameInput = AddValueInput<string>("实例名字");
		ValueInput<float> progressInput = AddValueInput<float>("进度");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("初始化", delegate(Flow f)
		{
			Init();
			if (_com == null || _progressImg == null)
			{
				Debug.LogError("设置特殊UI进度 没有初始化");
			}
			else
			{
				_progressImg.value = progressInput.value;
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			Init();
			if (_com == null || _progressImg == null)
			{
				Debug.LogError("设置特殊UI进度 没有初始化");
			}
			else
			{
				_progressImg.value = progressInput.value;
				f.Call(output);
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			Init();
			if (_com == null || _progressImg == null)
			{
				Debug.LogError("设置特殊UI进度 没有初始化");
			}
			else
			{
				_progressImg.value = progressInput.value;
				f.Call(output);
			}
		});
		void Init()
		{
			if (_com == null)
			{
				Transform transform = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject.transform.Find(parentPathInput.value);
				Transform transform2 = transform.Find(nameInput.value);
				if (transform2 == null)
				{
					GameObject gameObject = Asset.InstantiateWithoutCache(pathInput.value, transform);
					gameObject.name = nameInput.value;
					transform2 = gameObject.transform;
					_com = transform2.GetComponent<SpecialUIIcon>();
					_progressImg = _com.GetComponentInChildren<Slider>(includeInactive: true);
					_com.Clear(isEnable: false);
				}
				_com = transform2.GetComponent<SpecialUIIcon>();
				_progressImg = _com.GetComponentInChildren<Slider>(includeInactive: true);
			}
		}
	}
}
