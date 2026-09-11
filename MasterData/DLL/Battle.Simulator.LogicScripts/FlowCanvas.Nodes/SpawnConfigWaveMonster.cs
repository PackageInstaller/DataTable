using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("按关卡配置刷怪", 0)]
[Category("Logic/Spawn")]
[Description("按关卡配置刷怪")]
[ExposeAsDefinition]
public class SpawnConfigWaveMonster : FlowNode
{
	private bool isInit;

	private int time;

	private int tickTime;

	private int randomType;

	private int randomTimeLength;

	private int index;

	private List<int> monsterList;

	private RoleType camp;

	private int entityID;

	private int ai_id;

	private FlowOutput initOut;

	private FlowOutput initError;

	private FlowOutput updateOut;

	private FlowOutput updateEnd;

	protected override void RegisterPorts()
	{
		ValueInput<int> configInput = AddValueInput<int>("唯一波次序号");
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("阵营");
		ValueInput<int> triggerID = AddValueInput<int>("触发器ID");
		AddValueOutput("entityID", () => entityID);
		AddValueOutput("aiID", () => ai_id);
		initOut = AddFlowOutput("initOut");
		initError = AddFlowOutput("initError");
		updateOut = AddFlowOutput("updateOut");
		updateEnd = AddFlowOutput("updateEnd");
		AddFlowInput("init", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<MonsterSpawnerLevel>(configInput.value, out var config))
			{
				initError.Call(f);
			}
			else
			{
				switch (config.WaveType.get_Item(0))
				{
				case 1:
					isInit = true;
					tickTime = 0;
					randomType = 1;
					randomTimeLength = 0;
					break;
				case 2:
					isInit = true;
					tickTime = config.WaveType.get_Item(1);
					randomType = 2;
					randomTimeLength = 0;
					break;
				case 3:
					isInit = true;
					randomTimeLength = config.WaveType.get_Item(1) + 1;
					tickTime = (int)DRandom.Random((uint)randomTimeLength);
					randomType = 3;
					break;
				default:
					isInit = false;
					Debug.LogError($"配置了不存在类型的ID  {configInput.value} {config.WaveType.get_Item(0)} ");
					break;
				}
				time = 0;
				index = 0;
				camp = campInput.value;
				monsterList = new List<int>(config.WaveMonster);
				initOut.Call(f);
			}
		});
		AddFlowInput("update", delegate(Flow f)
		{
			if (!isInit)
			{
				updateEnd.Call(f);
			}
			else if (randomType == 1)
			{
				for (int i = 0; i < monsterList.Count; i++)
				{
					MonsterSpawnerConfig config = ConfigHelper.GetInstance().GetConfig<MonsterSpawnerConfig>(monsterList[i]);
					if (config != null)
					{
						CreateEnemyByData.CreateEntity(positionInput: new Int3(config.Position.get_Item(0), config.Position.get_Item(1), config.Position.get_Item(2)), forwardInput: new Int3(config.Forward.get_Item(0), config.Forward.get_Item(1), config.Forward.get_Item(2)), mSimContext: base.mSimContext, hpInput: config.BaseAttribute.get_Item(0), attackInput: config.BaseAttribute.get_Item(1), defendInput: config.BaseAttribute.get_Item(2), levelInput: config.BaseAttribute.get_Item(3), enemyTypeInput: config.Type, campInput: camp, AIIDInput: triggerID.value, roleIDInput: config.ConfigId, viewRangeInput: 0, sourceSpacePercentInput: config.BreakPercent, attrIDInput: new List<int>(config.AttributeId), attrValueInput: new List<int>(config.AttributeValue), initIDInput: config.InitId, skinID: config.SkinId, entityID: out entityID);
					}
					ai_id = config.PlayId;
					updateOut.Call(f);
				}
				isInit = false;
			}
			else
			{
				time += CommonProcessor.GetLogicConstTick();
				if (time >= tickTime)
				{
					MonsterSpawnerConfig config2 = ConfigHelper.GetInstance().GetConfig<MonsterSpawnerConfig>(monsterList[index]);
					if (config2 != null)
					{
						CreateEnemyByData.CreateEntity(positionInput: new Int3(config2.Position.get_Item(0), config2.Position.get_Item(1), config2.Position.get_Item(2)), forwardInput: new Int3(config2.Forward.get_Item(0), config2.Forward.get_Item(1), config2.Forward.get_Item(2)), mSimContext: base.mSimContext, hpInput: config2.BaseAttribute.get_Item(0), attackInput: config2.BaseAttribute.get_Item(1), defendInput: config2.BaseAttribute.get_Item(2), levelInput: config2.BaseAttribute.get_Item(3), enemyTypeInput: config2.Type, campInput: camp, AIIDInput: triggerID.value, roleIDInput: config2.ConfigId, viewRangeInput: 0, sourceSpacePercentInput: config2.BreakPercent, attrIDInput: new List<int>(config2.AttributeId), attrValueInput: new List<int>(config2.AttributeValue), initIDInput: config2.InitId, skinID: config2.SkinId, entityID: out entityID);
					}
					time -= tickTime;
					if (randomType == 3)
					{
						tickTime = (int)DRandom.Random((uint)randomTimeLength);
					}
					index++;
					ai_id = config2.PlayId;
					if (index >= monsterList.Count)
					{
						isInit = false;
					}
				}
				updateOut.Call(f);
			}
		});
		AddFlowInput("end", delegate
		{
			isInit = false;
		});
	}
}
