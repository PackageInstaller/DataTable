using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("1041连击条(渲染)(非正式)", 0)]
[Category("Render/UI")]
[Description("1041的连击条逻辑;\n Buff的第一个参数为当前连击数,第二个参数是连击持续时间\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgressWithCombo(滑动条使用整数计数) ,则填写 UI/AbilityPressingProgressWithCombo;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo\n【触发】仅刷新连击时间倒计时读条，当不显示连击时间时走Error\n【更新】仅刷新当前连击数")]
public class CustomUI1041ComboProcess : EffectCreateBaseNode
{
	private ValueInput<string> _ChildPanelPathInput;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _BuffClassIDInput;

	private ValueInput<int> _ComboCountInput;

	private ValueInput<int> _ComboTimeInput;

	private ValueInput<bool> _ShowComboTime;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private GameObject _ChildPanel;

	private Slider _ProgressImg;

	private Text _Text;

	private CanvasGroup _CanvasGroup;

	private FlowOutput _Bind;

	private FlowOutput _Tick;

	private FlowOutput _Leave;

	private FlowOutput _Refresh;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_Bind = AddFlowOutput("增加", "Bind");
		_Tick = AddFlowOutput("触发", "Tick");
		_Refresh = AddFlowOutput("更新", "Refresh");
		_Leave = AddFlowOutput("移除", "Leave");
		_Error = AddFlowOutput("Error");
		_effectPathInput.SetDefaultAndSerializedValue("UI/AbilityPressingProgressWithCombo");
		_ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		_AgentIDInput = AddValueInput<int>("实体ID", "agentID");
		_BuffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID", "buffClassID");
		_ComboCountInput = AddValueInput<int>("当前连击数", "ComboCount");
		_ComboTimeInput = AddValueInput<int>("连击持续时间", "ComboTime");
		_ShowComboTime = AddValueInput<bool>("显示连击时间", "ShowComboTime").SetDefaultAndSerializedValue(v: true);
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
					if (string.IsNullOrEmpty(_ChildPanelPathInput.GetValue()))
					{
						_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel");
					}
					else
					{
						_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel/" + _ChildPanelPathInput.GetValue());
					}
				}
				if (_ChildPanel == null)
				{
					_Error.Call(f);
				}
				else
				{
					GameObject gameObject = Asset.Instantiate(_effectPathInput.GetValue());
					_ProgressImg = gameObject.transform.Find("Storage").GetComponent<Slider>();
					_Text = gameObject.transform.Find("text").GetComponent<Text>();
					_CanvasGroup = gameObject.transform.GetComponent<CanvasGroup>();
					_ProgressImg.maxValue = _ComboTimeInput.value;
					_ProgressImg.minValue = -_ComboTimeInput.value / 1000 * 33;
					_ProgressImg.value = _ComboTimeInput.value;
					_ProgressImg.SetActive(_ShowComboTime.value);
					_Text.text = _ComboCountInput.value.ToString();
					if (_ComboCountInput.value > 0)
					{
						_CanvasGroup.alpha = 1f;
					}
					else
					{
						_CanvasGroup.alpha = 0f;
					}
					_CanvasGroup.interactable = false;
					_CanvasGroup.blocksRaycasts = false;
					gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
					_effectInstance = gameObject;
					_Bind.Call(f);
				}
			}
		});
		AddFlowInput("触发", "tick", delegate(Flow f)
		{
			if (!_ShowComboTime.value)
			{
				_Error.Call(f);
			}
			else if (_effectInstance == null || _ProgressImg == null)
			{
				_Error.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null)
				{
					_Error.Call(f);
				}
				else
				{
					List<BuffState> buffList = null;
					if (!battleScene.GetBuffManager().TryGetBuffListByAgentID(_AgentIDInput.GetValue(), out buffList))
					{
						_Error.Call(f);
					}
					else
					{
						for (int i = 0; i < buffList.Count; i++)
						{
							if (buffList[i].mBuffClassID == _BuffClassIDInput.GetValue())
							{
								_ProgressImg.value = buffList[i].mDuring;
								break;
							}
						}
						if (_ProgressImg.value <= 0f)
						{
							_CanvasGroup.alpha = 0f;
						}
						_Tick.Call(f);
					}
				}
			}
		});
		AddFlowInput("更新", "refresh", delegate(Flow f)
		{
			if (_Text == null)
			{
				_Error.Call(f);
			}
			else
			{
				_Text.text = _ComboCountInput.value.ToString();
				_Refresh.Call(f);
			}
		});
		AddFlowInput("移除", "remove", delegate(Flow f)
		{
			PooledAsset.DestroyOrReturn(_effectInstance);
			_ProgressImg = null;
			_Text = null;
			_effectInstance = null;
			_Leave.Call(f);
		});
	}
}
