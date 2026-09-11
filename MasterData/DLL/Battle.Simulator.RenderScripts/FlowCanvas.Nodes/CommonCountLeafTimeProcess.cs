using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("通用倒计时(渲染)(非正式)", 0)]
[Category("Render/UI")]
[Description("通用倒计时逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
public class CommonCountLeafTimeProcess : EffectCreateBaseNode
{
	private ValueInput<string> _ChildPanelPathInput;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _BuffClassIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private GameObject _ChildPanel;

	private Slider _ProgressImg;

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
					_ProgressImg.wholeNumbers = true;
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
									_ProgressImg.maxValue = buffList[i].mBuffKeepTime;
									break;
								}
							}
							_ProgressImg.minValue = (0f - _ProgressImg.maxValue) / 1000f * 33f;
							_ProgressImg.value = _ProgressImg.maxValue;
							gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
							_effectInstance = gameObject;
							_Bind.Call(f);
						}
					}
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
						_Tick.Call(f);
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
