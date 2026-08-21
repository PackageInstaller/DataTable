using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("蓄力条(渲染)", 0)]
[Category("Render/UI")]
[Description("类似1099的蓄力条逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
public class CustomUIPressingProcess : EffectCreateBaseNode
{
	[Name("蓄力条(渲染)(实例名字)", 0)]
	[Category("Render/UI")]
	[Description("类似1099的蓄力条逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo;\n +【实例名字】填写对应的角色ID。")]
	public class CustomUIPressingProcess2 : EffectCreateBaseNode
	{
		private Slider _ProgressImg;

		private GameObject _ChildPanel;

		protected override void RegisterPorts()
		{
			base.RegisterPorts();
			FlowOutput _Bind = AddFlowOutput("增加", "Bind");
			FlowOutput _Tick = AddFlowOutput("更新", "Tick");
			FlowOutput _Leave = AddFlowOutput("移除", "Leave");
			FlowOutput _Error = AddFlowOutput("Error");
			ValueInput<string> _ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
			ValueInput<float> progressInput = AddValueInput<float>("进度");
			ValueInput<string> nameInput = AddValueInput<string>("实例名字", "nameInput");
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
							Debug.LogError(base.graph.name + "的蓄力条（渲染）节点的战斗子面板路径参数为空！！！");
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
						Transform transform2 = _ChildPanel.transform.Find(nameInput.value);
						if (transform2 == null)
						{
							if (_effectInstance == null)
							{
								GameObject gameObject = Asset.Instantiate(_effectPathInput.GetValue());
								gameObject.name = nameInput.value;
								transform2 = gameObject.transform;
								_ProgressImg = transform2.Find("Storage").GetComponent<Slider>();
								gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
								_effectInstance = gameObject;
							}
							_Bind.Call(f);
						}
						else
						{
							_effectInstance = transform2.gameObject;
							_ProgressImg = transform2.Find("Storage").GetComponent<Slider>();
							_Bind.Call(f);
						}
					}
				}
			});
			AddFlowInput("更新", "tick", delegate(Flow f)
			{
				if (_effectInstance == null || _ProgressImg == null)
				{
					_Error.Call(f);
				}
				else
				{
					_ProgressImg.value = progressInput.value;
					_Tick.Call(f);
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

	[Name("蓄力条(渲染)(播放特效)", 0)]
	[Category("Render/UI")]
	[Description("类似1099的蓄力条逻辑;\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgress ,则填写 UI/AbilityPressingProgress;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
	public class CustomUIPressingProcessWithEffect : EffectCreateBaseNode
	{
		private Slider _ProgressImg;

		private GameObject effectGo;

		private GameObject _ChildPanel;

		protected override void RegisterPorts()
		{
			base.RegisterPorts();
			FlowOutput _Bind = AddFlowOutput("增加", "Bind");
			FlowOutput _Tick = AddFlowOutput("更新", "Tick");
			FlowOutput _Leave = AddFlowOutput("移除", "Leave");
			FlowOutput _Error = AddFlowOutput("Error");
			ValueInput<string> _ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
			ValueInput<float> progressInput = AddValueInput<float>("进度");
			ValueInput<bool> useEffectInput = AddValueInput<bool>("开启特效");
			ValueInput<string> effectPathInput = AddValueInput<string>("预制体的特效路径");
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
							Debug.LogError(base.graph.name + "的蓄力条（渲染）节点的战斗子面板路径参数为空！！！");
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
							_ProgressImg = gameObject.transform.Find("Storage").GetComponent<Slider>();
							effectGo = gameObject.transform.Find(effectPathInput.value).gameObject;
							gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
							_effectInstance = gameObject;
						}
						_Bind.Call(f);
					}
				}
			});
			AddFlowInput("更新", "tick", delegate(Flow f)
			{
				if (_effectInstance == null || _ProgressImg == null || (useEffectInput.value && effectGo == null))
				{
					_Error.Call(f);
				}
				else
				{
					_ProgressImg.value = progressInput.value;
					effectGo.SetActive(useEffectInput.value);
					_Tick.Call(f);
				}
			});
			AddFlowInput("移除", "remove", delegate(Flow f)
			{
				PooledAsset.DestroyOrReturn(_effectInstance);
				_ProgressImg = null;
				_effectInstance = null;
				effectGo = null;
				_Leave.Call(f);
			});
		}
	}

	[Name("1041判定条(渲染)(非正式)", 0)]
	[Category("Render/UI")]
	[Description("1041的判定条逻辑;\n Buff的第一个参数为判定框所在帧数的毫秒数(使用帧数转毫秒就行),第二个参数是判定框的大小(毫秒数)\n 资源路径从 Prefab 下开始,例如要加载 AbilityPressingProgressWithBestArea(滑动条使用整数计数) ,则填写 UI/AbilityPressingProgressWithBestArea;\n【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo")]
	public class CustomUI1041PressingProcess : EffectCreateBaseNode
	{
		private ValueInput<string> _ChildPanelPathInput;

		private ValueInput<int> _AgentIDInput;

		private ValueInput<int> _BuffClassIDInput;

		private ValueInput<int> _CurAbilityTime;

		private ValueInput<int> _BestAreaCenter;

		private ValueInput<int> _BestAreaLenth;

		private ValueInput<int> _PerfectLenth;

		private FlowOutput _Out;

		private FlowOutput _Error;

		private GameObject _ChildPanel;

		private Slider _ProgressImg;

		private Image _BestArea;

		private Image _PerfectImg;

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
			_effectPathInput.SetDefaultAndSerializedValue("UI/AbilityPressingProgressWithBestArea");
			_ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
			_AgentIDInput = AddValueInput<int>("实体ID", "agentID");
			_BuffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID", "buffClassID");
			_CurAbilityTime = AddValueInput<int>("当前判定条时长", "curAbilityTime");
			_BestAreaCenter = AddValueInput<int>("判定中心(输入毫秒)", "bestAreaCenter");
			_BestAreaLenth = AddValueInput<int>("判定长度(输入毫秒正负区间)", "bestAreaLenth");
			_PerfectLenth = AddValueInput<int>("完美判断长度(输入占判定长度百分比)", "perfectLenth");
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
						_BestArea = _ProgressImg.transform.Find("bestarea").GetComponent<Image>();
						_PerfectImg = _BestArea.transform.Find("perfectarea").GetComponent<Image>();
						_CanvasGroup = _ProgressImg.gameObject.GetComponent<CanvasGroup>();
						int num = 1;
						if (_CurAbilityTime.value != 0)
						{
							num = _CurAbilityTime.value;
						}
						else
						{
							BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
							if (battleScene == null)
							{
								_Error.Call(f);
								return;
							}
							AgentManager agentManager = battleScene.GetAgentManager();
							if (agentManager == null)
							{
								_Error.Call(f);
								return;
							}
							BBHumanoid bBHumanoid = agentManager.GetAgent(_AgentIDInput.value).Blackboard as BBHumanoid;
							if (bBHumanoid == null)
							{
								_Error.Call(f);
								return;
							}
							if (bBHumanoid.m_NextSimFrameData.mAbilityID != 0)
							{
								int mAbilityID = bBHumanoid.m_NextSimFrameData.mAbilityID;
								num = ConfigHelper.GetInstance().GetConfig<Timeline>(mAbilityID).Duration;
							}
						}
						_ProgressImg.maxValue = num;
						_ProgressImg.minValue = -num / 1000 * 33;
						_ProgressImg.value = 0f;
						RectTransform rectTransform = _ProgressImg.transform as RectTransform;
						RectTransform rectTransform2 = _BestArea.rectTransform;
						RectTransform rectTransform3 = _PerfectImg.rectTransform;
						float width = rectTransform.rect.width;
						_ = rectTransform.rect.height;
						float x = (float)_BestAreaCenter.value * width / (float)num - width / 2f;
						float num2 = (float)(_BestAreaLenth.value * 2) * width / (float)num;
						float x2 = num2 * (float)_PerfectLenth.value / 100f;
						float num3 = rectTransform2.rect.height / rectTransform.rect.height;
						float num4 = rectTransform3.rect.height / rectTransform.rect.height;
						_BestArea.rectTransform.localPosition = new Vector3(x, 0f, 0f);
						_BestArea.rectTransform.sizeDelta = new Vector2(num2, rectTransform.rect.height * num3);
						_PerfectImg.rectTransform.sizeDelta = new Vector2(x2, rectTransform.rect.height * num4);
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
									_ProgressImg.value = buffList[i].mBuffKeepTime - buffList[i].mDuring;
									break;
								}
							}
							if (_ProgressImg.value >= _ProgressImg.maxValue)
							{
								_CanvasGroup.alpha = 0f;
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
				_BestArea = null;
				_effectInstance = null;
				_Leave.Call(f);
			});
		}
	}

	private Slider _ProgressImg;

	private GameObject _ChildPanel;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput _Bind = AddFlowOutput("增加", "Bind");
		FlowOutput _Tick = AddFlowOutput("更新", "Tick");
		FlowOutput _Leave = AddFlowOutput("移除", "Leave");
		FlowOutput _Error = AddFlowOutput("Error");
		ValueInput<string> _ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		ValueInput<float> progressInput = AddValueInput<float>("进度");
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
						Debug.LogError(base.graph.name + "的蓄力条（渲染）节点的战斗子面板路径参数为空！！！");
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
						_ProgressImg = gameObject.transform.Find("Storage").GetComponent<Slider>();
						gameObject.transform.SetParent(_ChildPanel.transform, worldPositionStays: false);
						_effectInstance = gameObject;
					}
					_Bind.Call(f);
				}
			}
		});
		AddFlowInput("更新", "tick", delegate(Flow f)
		{
			if (_effectInstance == null || _ProgressImg == null)
			{
				_Error.Call(f);
			}
			else
			{
				_ProgressImg.value = progressInput.value;
				_Tick.Call(f);
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
