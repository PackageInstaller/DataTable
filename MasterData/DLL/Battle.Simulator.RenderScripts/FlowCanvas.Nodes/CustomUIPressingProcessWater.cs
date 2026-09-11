using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("气氛值条(渲染)", 0)]
[Category("Render/UI")]
[Description("类似1099的蓄力条逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
public class CustomUIPressingProcessWater : EffectCreateBaseNode
{
	private Slider _ProgressImg;

	private Image _Fill;

	private GameObject _ChildPanel;

	private GameObject _FillFlame;

	private float _Current;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput _Bind = AddFlowOutput("增加", "Bind");
		FlowOutput _Tick = AddFlowOutput("更新", "Tick");
		FlowOutput _Leave = AddFlowOutput("移除", "Leave");
		FlowOutput _Error = AddFlowOutput("Error");
		ValueInput<string> _ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<Vector3> positionInput = AddValueInput<Vector3>("坐标", "position").SetDefaultAndSerializedValue(new Vector3(0f, 670f, 0f));
		ValueInput<float> maxInput = AddValueInput<float>("最大气氛值", "max").SetDefaultAndSerializedValue(0f);
		ValueInput<float> increaseInput = AddValueInput<float>("增加值", "increase");
		ValueInput<float> decreaseInput = AddValueInput<float>("衰减值", "decrease").SetDefaultAndSerializedValue(0f);
		ValueInput<float> limitInput = AddValueInput<float>("进度高亮", "limit");
		ValueInput<Color> colorInput = AddValueInput<Color>("指定颜色", "color");
		ValueInput<string> pathStorageInput = AddValueInput<string>("进度条路径").SetDefaultAndSerializedValue("Storage");
		ValueInput<string> pathFillInput = AddValueInput<string>("进度条Fill路径").SetDefaultAndSerializedValue("Storage/Fill Area/Fill");
		ValueInput<string> pathEffectInput = AddValueInput<string>("高亮特效路径").SetDefaultAndSerializedValue("Storage/eff");
		AddValueOutput("当前气氛值", "current", () => _Current);
		AddFlowInput("添加", "bind", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(_effectPathInput.GetValue()))
			{
				_Error.Call(f);
			}
			else
			{
				if (_ChildPanel == null)
				{
					BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
					if (battleScene != null)
					{
						_ChildPanel = battleScene.battlePanelGameObject;
					}
					if (string.IsNullOrEmpty(_ChildPanelPathInput.GetValue()))
					{
						Debug.LogError(base.graph.name + "的气氛值条（渲染）节点的战斗子面板路径参数为空！！！");
					}
					else
					{
						Transform transform = _ChildPanel.transform.Find(_ChildPanelPathInput.GetValue());
						if (transform != null)
						{
							_ChildPanel = transform.gameObject;
						}
					}
				}
				if (_ChildPanel == null)
				{
					_Error.Call(f);
				}
				else
				{
					if (_effectInstance == null)
					{
						GameObject gameObject = Asset.Instantiate(_effectPathInput.GetValue());
						gameObject.transform.position = positionInput.value;
						if (gameObject.transform.Find(pathStorageInput.value).TryGetComponent<Slider>(out _ProgressImg))
						{
							_ProgressImg.value = 0f;
						}
						if (gameObject.transform.Find(pathFillInput.value).TryGetComponent<Image>(out _Fill))
						{
							_Fill.color = colorInput.value;
						}
						_FillFlame = gameObject.transform.Find(pathEffectInput.value).gameObject;
						if (_FillFlame != null)
						{
							_FillFlame.SetActive(value: false);
						}
						gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
						_effectInstance = gameObject;
					}
					_Bind.Call(f);
				}
			}
		});
		AddFlowInput("更新", "tick", delegate(Flow f)
		{
			if (_effectInstance == null || _ProgressImg == null || _FillFlame == null || _Fill == null)
			{
				Debug.LogError(base.graph.name + "图的气氛值条节点，对应路径取到的预制体或其子Go为空");
				_Error.Call(f);
			}
			else
			{
				if (_ProgressImg.value < 1f)
				{
					_Current = _ProgressImg.value * maxInput.value + increaseInput.value - decreaseInput.value;
					_ProgressImg.value = _Current / maxInput.value;
					if (!_FillFlame.activeSelf && _ProgressImg.value >= limitInput.value / maxInput.value)
					{
						_FillFlame.SetActive(value: true);
					}
				}
				else
				{
					_ProgressImg.value = 1f;
				}
				_Fill.color = colorInput.value;
				_Tick.Call(f);
			}
		});
		AddFlowInput("移除", "remove", delegate(Flow f)
		{
			PooledAsset.DestroyOrReturn(_effectInstance);
			_ProgressImg = null;
			_Fill = null;
			_effectInstance = null;
			_FillFlame = null;
			_Current = 0f;
			_Leave.Call(f);
		});
	}
}
