using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]得到无人机配置", 0)]
[Category("Active/TowerDefense/Common/Data")]
[Description("得到无人机配置")]
public class TDGetTowerConfig : FlowControlNodeOfCommon
{
	private int _type;

	private string _name;

	private string _iconBattle;

	private int _upgradeCost;

	private int _dismantleReturn;

	private int _subType;

	private List<int> _subArray = new List<int>();

	private int _roleID;

	private int _buffConfigID;

	private int _upgradeCountLimit;

	private int _attackRange;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID", "configID");
		AddValueOutput("无人机ID", "configID", () => configIDInput.value);
		AddValueOutput("无人机类型", "type", () => _type);
		AddValueOutput("无人机名称", "name", () => _name);
		AddValueOutput("战斗内图标", "desc", () => _iconBattle);
		AddValueOutput("升级消耗", "upgradeCost", () => _upgradeCost);
		AddValueOutput("拆除返还", "dismantleReturn", () => _dismantleReturn);
		AddValueOutput("升级类型", "subType", () => _subType);
		AddValueOutput("下一级选项", "_subArray", () => _subArray);
		AddValueOutput("实体类型ID", "_roleID", () => _roleID);
		AddValueOutput("buff配置ID", "_buffConfigID", () => _buffConfigID);
		AddValueOutput("升级次数上限", "_upgradeCountLimit", () => _upgradeCountLimit);
		AddValueOutput("攻击范围(毫米)", "_attackRange", () => _attackRange);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_type = 0;
			_name = string.Empty;
			_iconBattle = string.Empty;
			_upgradeCost = 0;
			_dismantleReturn = 0;
			_subType = 0;
			_subArray.Clear();
			_roleID = 0;
			_buffConfigID = 0;
			_upgradeCountLimit = 0;
			_attackRange = 0;
			if (ConfigHelper.GetInstance().TryGetConfig<activity_tower_defense_tower>(configIDInput.value, out var config))
			{
				_type = config.Type;
				_name = config.Name;
				_iconBattle = config.IconBattle;
				_upgradeCost = config.UpgradeCost;
				_dismantleReturn = config.DismantleReturn;
				_subType = config.SubType;
				for (int i = 0; i < config.SubArray.Count; i++)
				{
					_subArray.Add(config.SubArray.get_Item(i));
				}
				_roleID = config.RoleId;
				_buffConfigID = config.BuffConfigId;
				_upgradeCountLimit = config.UpgradeCountLimit;
				_attackRange = config.AttackRange;
				output.Call(f);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
