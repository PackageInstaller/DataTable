using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("通用蓄力条(渲染)(非正式)", 0)]
[Category("Render/UI")]
[Description("通用蓄力条逻辑;\n Buff的第一个参数为最大层数,第二个参数是每层持续时间,第三个参数是抬手占蓄力条时间,第四个参数是总蓄力时间(此参数和前面三个参数二选一)\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress(num);\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
public class CommonPressingProcess : EffectCreateBaseNode
{
	private ValueInput<string> _ChildPanelPathInput;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _BuffClassIDInput;

	private ValueInput<int> _MaxFloorInput;

	private ValueInput<int> _PerFloorTimeInput;

	private ValueInput<int> _StartTimeInput;

	private ValueInput<int> _AllTimeInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private GameObject _ChildPanel;

	private int maxTime;

	private Slider _ProgressImg;

	private CanvasGroup _CanvasGroup;

	private FlowOutput _Bind;

	private FlowOutput _Tick;

	private FlowOutput _Leave;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_Bind = AddFlowOutput("增加", "Bind");
		_Tick = AddFlowOutput("触发", "Tick");
		_Leave = AddFlowOutput("移除", "Leave");
		_Error = AddFlowOutput("Error");
		_effectPathInput.SetDefaultAndSerializedValue("UI/AbilityPressingProgress");
		_ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		_AgentIDInput = AddValueInput<int>("实体ID", "agentID");
		_BuffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID", "buffClassID");
		_MaxFloorInput = AddValueInput<int>("蓄力最大层数", "maxFloor");
		_PerFloorTimeInput = AddValueInput<int>("每层蓄力时间", "perFloorTime");
		_StartTimeInput = AddValueInput<int>("抬手占蓄力时间", "startTime");
		_AllTimeInput = AddValueInput<int>("蓄力总时间", "allTime").SetDefaultAndSerializedValue(0);
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
					_CanvasGroup = _ProgressImg.transform.GetComponent<CanvasGroup>();
					_ProgressImg.wholeNumbers = true;
					if (_AllTimeInput.value != 0)
					{
						_ProgressImg.maxValue = _AllTimeInput.value;
					}
					else
					{
						_ProgressImg.maxValue = _MaxFloorInput.value * _PerFloorTimeInput.value + _StartTimeInput.value;
					}
					_ProgressImg.minValue = (0f - _ProgressImg.maxValue) / 1000f * 33f;
					_ProgressImg.value = 0f;
					_CanvasGroup.alpha = 1f;
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
			if (_effectInstance == null || _ProgressImg == null)
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
					AgentManager agentManager = battleScene.GetAgentManager();
					if (agentManager == null)
					{
						_Error.Call(f);
					}
					else
					{
						BBHumanoid bBHumanoid = agentManager.GetAgent(_AgentIDInput.value).Blackboard as BBHumanoid;
						if (bBHumanoid == null)
						{
							_Error.Call(f);
						}
						else
						{
							if (bBHumanoid.m_NextSimFrameData.mAbilityID != 0)
							{
								_ProgressImg.value += bBHumanoid.m_NextSimFrameData.AbilityTimeStep;
							}
							if (_ProgressImg.value >= _ProgressImg.maxValue)
							{
								_CanvasGroup.alpha = 0f;
							}
							_Tick.Call(f);
						}
					}
				}
			}
		});
		AddFlowInput("移除", "remove", delegate(Flow f)
		{
			PooledAsset.DestroyOrReturn(_effectInstance);
			_ProgressImg = null;
			_effectInstance = null;
			_Leave.Call(f);
		});
	}
}
