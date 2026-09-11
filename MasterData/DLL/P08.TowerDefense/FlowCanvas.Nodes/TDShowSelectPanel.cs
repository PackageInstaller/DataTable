using Config;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[TD]显示选择项", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI")]
public class TDShowSelectPanel : FlowControlNodeOfRender, IUpdatable
{
	private TowerPTUI ui;

	private int _showed;

	private int _configID;

	private bool _reShow;

	private float _hideTime;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ui = null;
		_showed = 0;
		_configID = 0;
		_hideTime = 0f;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ui = null;
		_showed = 0;
		_configID = 0;
		_hideTime = 0f;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("触发器ID").SetDefaultAndSerializedValue(0);
		ValueInput<float> deltaInput = AddValueInput<float>("显示间隔", "delta").SetDefaultAndSerializedValue(0.5f);
		AddValueOutput("触发器ID", () => _showed);
		AddValueOutput("配置ID", () => _configID);
		FlowOutput selectAOut = AddFlowOutput("选择A");
		AddFlowOutput("选择B");
		FlowOutput selectCOut = AddFlowOutput("选项C");
		FlowOutput unlockOut = AddFlowOutput("未解锁");
		FlowOutput energyLessOut = AddFlowOutput("能量不足");
		FlowOutput levelMaxOut = AddFlowOutput("满级");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("显示选择", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				if (_showed != 0 && _showed == triggerIDInput.value && ui.m_selectA != null && ui.m_selectB != null)
				{
					ui.m_selectA.UpdateItem();
					ui.m_selectB.UpdateItem();
				}
				if (ui.m_selectA != null && ui.m_selectB != null && ui.m_recycleBtn != null && (_showed == 0 || (_showed == triggerIDInput.value && _reShow)))
				{
					_showed = triggerIDInput.value;
					_configID = 0;
					_reShow = false;
					ui.ShowSelectPanel();
					TowerData towerData = ui.GetTowerData(_showed);
					activity_tower_defense_tower config = ConfigHelper.GetInstance().GetConfig<activity_tower_defense_tower>(towerData.m_body);
					int count = config.SubArray.Count;
					ui.SetTitle(config.Title);
					if (count > 0)
					{
						ui.m_selectA.Show();
						ui.m_selectA.InitSelectItem(config.SubArray.get_Item(0), _showed, 0, delegate(int configID)
						{
							if (ui.IsShowed())
							{
								_configID = configID;
								ui.HideSelectPanel();
								_hideTime = deltaInput.value;
								f.Call(selectAOut);
							}
						});
						ui.m_selectA.SetLockAction(delegate
						{
							f.Call(unlockOut);
						});
						ui.m_selectA.SetEnergyLessAction(delegate
						{
							f.Call(energyLessOut);
						});
						ui.m_selectA.SetLevelMaxAction(delegate
						{
							f.Call(levelMaxOut);
						});
						ui.m_selectA.UpdateItem();
					}
					if (count > 1)
					{
						ui.m_selectB.Show();
						ui.m_selectB.InitSelectItem(config.SubArray.get_Item(1), _showed, 1, delegate(int configID)
						{
							if (ui.IsShowed())
							{
								_configID = configID;
								ui.HideSelectPanel();
								_hideTime = deltaInput.value;
								f.Call(selectAOut);
							}
						});
						ui.m_selectB.SetLockAction(delegate
						{
							f.Call(unlockOut);
						});
						ui.m_selectB.SetEnergyLessAction(delegate
						{
							f.Call(energyLessOut);
						});
						ui.m_selectB.SetLevelMaxAction(delegate
						{
							f.Call(levelMaxOut);
						});
						ui.m_selectB.UpdateItem();
					}
					if (towerData.m_body != 0)
					{
						ui.m_recycleTxt.text = WorldStateManager.GetNumberString(towerData.m_recycle);
						ui.ShowRecyclePanel();
						ui.m_recycleBtn.onClick.RemoveAllListeners();
						ui.m_recycleBtn.onClick.AddListener(delegate
						{
							if (ui.IsShowed())
							{
								ui.SetPT(ui.GetPT() + ui.RecycleTower(_showed));
								_configID = 0;
								ui.HideSelectPanel();
								_hideTime = deltaInput.value;
								f.Call(selectCOut);
							}
						});
					}
				}
			}
		});
		AddFlowInput("隐藏选择", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else if (_showed == triggerIDInput.value)
			{
				ui.HideSelectPanel();
				_showed = 0;
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
