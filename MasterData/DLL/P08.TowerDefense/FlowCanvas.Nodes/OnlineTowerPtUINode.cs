using System.Collections.Generic;
using Config;
using Google.Protobuf;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[OnlineTD]PTUI初始化", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("初始化PTUI")]
public class OnlineTowerPtUINode : FlowNode
{
	[Name("[OnlineTD]PTUI波数更新", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("OnlinePTUI更新")]
	public class UpdateOnlineTowerPtUI : FlowNode
	{
		private OnlineTowerPTUI ui;

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
		}

		protected override void RegisterPorts()
		{
			ValueInput<int> currentWaveInput = AddValueInput<int>("当前波数", "currentWave");
			ValueInput<int> totalWaveInput = AddValueInput<int>("总波数", "totalWave");
			FlowOutput output = AddFlowOutput("Out", "output");
			FlowOutput errorOut = AddFlowOutput("Error", "error");
			AddFlowInput("更新", "update", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					ui.SetWave(currentWaveInput.value, totalWaveInput.value);
					output.Call(f);
				}
			});
		}
	}

	[Name("[OnlineTD]增加PT点", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("OnlinePTUI更新")]
	public class OnlineTDAddPt : FlowControlNodeOfRender
	{
		private OnlineTowerPTUI ui;

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
		}

		protected override void RegisterPorts()
		{
			ValueInput<int> addValueInput = AddValueInput<int>("增量", "addValue");
			FlowOutput output = AddFlowOutput("Out", "output");
			FlowOutput errorOut = AddFlowOutput("Error", "error");
			AddFlowInput("In", "input", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					ui.SetPT(ui.GetPT() + addValueInput.value);
					output.Call(f);
				}
			});
		}
	}

	[Name("[OnlineTD]显示选择项", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("PTUI")]
	public class OnlineTDShowSelectPanel : FlowControlNodeOfRender, IUpdatable
	{
		private OnlineTowerPTUI ui;

		private int triggerID;

		private int selectID;

		private int selectBuffID;

		private int selectType;

		private int selectAddType;

		private bool _reShow;

		private float _hideTime;

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
			triggerID = 0;
			selectBuffID = 0;
			selectAddType = 0;
			_hideTime = 0f;
			selectID = 0;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
			triggerID = 0;
			selectBuffID = 0;
			selectAddType = 0;
			_hideTime = 0f;
			selectID = 0;
		}

		protected override void RegisterPorts()
		{
			ValueInput<List<int>> gachaInput = AddValueInput<List<int>>("卡池", "gachaPool");
			ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID", "triggerID");
			ValueInput<float> deltaInput = AddValueInput<float>("显示间隔", "delta").SetDefaultAndSerializedValue(0.5f);
			ValueInput<int> maxTipInput = AddValueInput<int>("满选择显示的提示ID", "maxTip");
			AddValueOutput("触发器ID", () => triggerID);
			AddValueOutput("选择强化ID", () => selectBuffID);
			AddValueOutput("强化类型", () => selectType);
			AddValueOutput("添加类型", () => selectAddType);
			AddValueOutput("强化ID", () => selectID);
			FlowOutput selectAOut = AddFlowOutput("选择强化");
			FlowOutput unlockOut = AddFlowOutput("未解锁");
			FlowOutput energyLessOut = AddFlowOutput("能量不足");
			FlowOutput errorOut = AddFlowOutput("error");
			AddFlowInput("初始化选项", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					ui.GetOnlineTowerData(triggerIDInput.value).OnResetData();
				}
			});
			AddFlowInput("显示选择", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					if (triggerID != 0 && triggerID == triggerIDInput.value)
					{
						for (int i = 0; i < ui.m_selects.Length; i++)
						{
							if (ui.m_selects[i] != null)
							{
								ui.m_selects[i].UpdateItem();
							}
						}
					}
					if (triggerID == 0 || (triggerID == triggerIDInput.value && _reShow))
					{
						triggerID = triggerIDInput.value;
						_reShow = false;
						selectType = -1;
						int num = WorldStateManager.GetWorldStateManager().GetLocalPlayerPosition();
						if (num == -1)
						{
							num = 0;
						}
						ui.ShowSelectPanel();
						OnlineTowerData onlineTowerData = ui.GetOnlineTowerData(triggerID);
						List<int> value = gachaInput.value;
						int num2 = 0;
						for (int j = 0; j < 3; j++)
						{
							int index = j + num * 3;
							if (value[index] == 0)
							{
								num2++;
							}
							else
							{
								ConfigHelper.GetInstance().GetConfig<activity_online_tower>(value[index]);
								ui.m_selects[j].Show();
								ui.m_selects[j].InitSelectItem(value[index], triggerID, j, delegate(int id, int selectID, int type, int addType)
								{
									this.selectID = id;
									if (ui.IsShow())
									{
										selectBuffID = selectID;
										selectType = type;
										selectAddType = addType;
										ui.HideSelectPanel();
										_hideTime = deltaInput.value;
										f.Call(selectAOut);
									}
								});
								ui.m_selects[j].SetLockAction(delegate
								{
									f.Call(unlockOut);
								});
								ui.m_selects[j].SetEnergyLessAction(delegate
								{
									f.Call(energyLessOut);
								});
								ui.m_selects[j].UpdateItem();
								if (onlineTowerData.isSelect[j])
								{
									num2++;
								}
							}
						}
						if (num2 >= 3)
						{
							ui.SetTimeString(maxTipInput.value);
						}
						else
						{
							ui.ResetTimeString();
						}
					}
				}
			});
			AddFlowInput("隐藏选择", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else if (triggerID == triggerIDInput.value)
				{
					ui.HideSelectPanel();
					triggerID = 0;
					ui.ResetTimeString();
				}
			});
		}

		public void Update()
		{
			if (_hideTime > 0f)
			{
				_hideTime -= Time.deltaTime;
				if (_hideTime <= 0f)
				{
					_reShow = true;
				}
			}
		}
	}

	[Name("[OnlineTD]设置倒计时", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("OnlinePTUI更新，设计待机倒计时")]
	public class OnlineTDSetTime : FlowControlNodeOfRender
	{
		private OnlineTowerPTUI ui;

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
		}

		protected override void RegisterPorts()
		{
			ValueInput<float> timeInput = AddValueInput<float>("时间", "timeValue");
			ValueInput<int> battleTipIDInput = AddValueInput<int>("战斗提示ID", "battleTipIDValue");
			ValueInput<bool> timeStampInput = AddValueInput<bool>("是否使用时间戳", "timeStampValue");
			ValueInput<bool> skipButtonInput = AddValueInput<bool>("是否显示跳过按钮", "skipBattonValue");
			FlowOutput output = AddFlowOutput("Out", "output");
			FlowOutput errorOut = AddFlowOutput("Error", "error");
			AddFlowInput("In", "input", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					ui.SetTime(timeInput.value, battleTipIDInput.value, !timeStampInput.value, skipButtonInput.value);
					output.Call(f);
				}
			});
		}
	}

	[Name("[OnlineTD]设置关卡进度", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("OnlinePTUI更新，设置当前关卡进度")]
	public class OnlineTDSetWavePercent : FlowControlNodeOfRender
	{
		private OnlineTowerPTUI ui;

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
		}

		protected override void RegisterPorts()
		{
			ValueInput<float> curInput = AddValueInput<float>("已死亡人数", "curValue");
			ValueInput<float> maxInput = AddValueInput<float>("总人数", "maxValue");
			FlowOutput output = AddFlowOutput("Out", "output");
			FlowOutput errorOut = AddFlowOutput("Error", "error");
			AddFlowInput("In", "input", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					ui.SetWavePercent(curInput.value / maxInput.value);
					output.Call(f);
				}
			});
		}
	}

	[Name("[OnlineTD]设置塔血量", 0)]
	[Category("Active/TowerDefense/Render/UI")]
	[Description("OnlinePTUI更新塔血量，如果传进实体ID身上没有列表上的buff，则输出false")]
	public class OnlineTDSetTowerHP : FlowControlNodeOfRender
	{
		[Name("塔对应标识BuffID", 0)]
		public List<int> m_towerBuff = new List<int>();

		private OnlineTowerPTUI ui;

		private AgentManager agentManager;

		private BuffManager buffManager;

		public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
		{
			m_towerBuff = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
		}

		public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
		{
			options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, m_towerBuff, options);
		}

		public override void OnGraphStarted()
		{
			base.OnGraphStarted();
			ui = null;
			agentManager = null;
			buffManager = null;
		}

		public override void OnGraphStoped()
		{
			base.OnGraphStoped();
			ui = null;
			agentManager = null;
			buffManager = null;
		}

		protected override void RegisterPorts()
		{
			ValueInput<int> agentIDInput = AddValueInput<int>("agentID", "agentID");
			FlowOutput output = AddFlowOutput("Out", "output");
			FlowOutput falseOut = AddFlowOutput("未找到", "falseOut");
			FlowOutput errorOut = AddFlowOutput("Error", "error");
			AddFlowInput("In", "input", delegate(Flow f)
			{
				if (ui == null && !TryGetPTUI(out ui))
				{
					errorOut.Call(f);
				}
				else
				{
					if (agentManager == null)
					{
						agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
						if (agentManager == null)
						{
							errorOut.Call(f);
							return;
						}
					}
					if (buffManager == null)
					{
						buffManager = (NScene.GetCurrentScene() as BattleScene).GetBuffManager();
						if (buffManager == null)
						{
							errorOut.Call(f);
							return;
						}
					}
					NAgent agent = agentManager.GetAgent(agentIDInput.value);
					if (agent == null || agent.Blackboard == null)
					{
						falseOut.Call(f);
					}
					else
					{
						BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
						if (!buffManager.TryGetBuffListByAgentID(agentIDInput.value, out var buffList))
						{
							falseOut.Call(f);
						}
						else
						{
							int num = -1;
							for (int i = 0; i < buffList.Count; i++)
							{
								if (m_towerBuff.Contains(buffList[i].mBuffClassID))
								{
									num = m_towerBuff.IndexOf(buffList[i].mBuffClassID);
									break;
								}
							}
							if (num == -1)
							{
								falseOut.Call(f);
							}
							else
							{
								ui.SetTowerHP((float)bBHumanoid.HP / (float)bBHumanoid.MaxHP, num);
								output.Call(f);
							}
						}
					}
				}
			});
		}
	}

	public const string ONLINE_PTUI_PREFAB_PATH = "UI/OnlineTower/OnlineTower_chooseBuff";

	public const string PTUI_PARENT_NAME = "ScreenAdjustContainer";

	public const string PTUI_INST_NAME = "PTUI";

	private OnlineTowerPTUI ui;

	private int _triggerID;

	private int _configID;

	public int GetTriggerID()
	{
		return _triggerID;
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ui = null;
		_triggerID = 0;
		_configID = 0;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ui = null;
		_triggerID = 0;
		_configID = 0;
	}

	public bool Init(string insPath, string insName, string prefabPath)
	{
		if (ui == null)
		{
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI != null)
			{
				Transform transform = battleUI.transform.Find(insPath);
				if (transform != null)
				{
					Transform transform2 = transform.Find(insName);
					if (transform2 != null)
					{
						ui = transform2.GetComponent<OnlineTowerPTUI>();
					}
					else
					{
						GameObject gameObject = Asset.InstantiateWithoutCache(prefabPath, transform);
						if (gameObject != null)
						{
							ui = gameObject.GetComponent<OnlineTowerPTUI>();
							gameObject.name = insName;
						}
					}
					if (ui != null)
					{
						ui.HideSelectPanel();
					}
				}
			}
		}
		return ui != null;
	}

	private List<int>[] GetAllGachaPool(int count)
	{
		List<int>[] array = new List<int>[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = new List<int>();
		}
		foreach (KeyValuePair<int, IMessage> item in ConfigHelper.GetInstance().GetAllConfig(typeof(activity_online_tower)))
		{
			activity_online_tower activity_online_tower2 = item.Value as activity_online_tower;
			array[activity_online_tower2.Type].Add(activity_online_tower2.ID);
		}
		return array;
	}

	public static bool TryGetPTUI(out OnlineTowerPTUI ui)
	{
		ui = null;
		BattleUI battleUI = BattleUI.GetBattleUI();
		if (battleUI != null)
		{
			Transform transform = battleUI.transform.Find("ScreenAdjustContainer");
			if (transform != null)
			{
				Transform transform2 = transform.Find("PTUI");
				if (transform2 != null)
				{
					ui = transform2.GetComponent<OnlineTowerPTUI>();
				}
				if (ui != null)
				{
					ui.HideSelectPanel();
				}
			}
		}
		return ui != null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> prefabPathInput = AddValueInput<string>("预制体路径").SetDefaultAndSerializedValue("UI/OnlineTower/OnlineTower_chooseBuff");
		ValueInput<int> initPtInput = AddValueInput<int>("初始pt点数").SetDefaultAndSerializedValue(500);
		AddValueInput<int>("触发器ID").SetDefaultAndSerializedValue(0);
		AddValueOutput("触发器ID", () => _triggerID);
		AddValueOutput("配置ID", () => _configID);
		FlowOutput output = AddFlowOutput("初始化结束");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("初始化", delegate(Flow f)
		{
			if (Init("ScreenAdjustContainer", "PTUI", prefabPathInput.value))
			{
				ui.SetPT(initPtInput.value);
				f.Call(output);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
