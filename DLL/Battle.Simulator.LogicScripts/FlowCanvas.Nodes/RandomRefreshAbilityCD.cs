using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]随机选取CD中技能并刷新", 0)]
[Category("Logic/Attribute")]
[Description("随机选取CD中技能并刷新，会刷新AbilityConfig表中记录的同步CD的技能的CD")]
public class RandomRefreshAbilityCD : FlowNode
{
	private int _selectAbilityID;

	private List<AbilityCD> _abilityInCDs = new List<AbilityCD>(3);

	protected FlowOutput _successOutput;

	protected FlowOutput _errorOutput;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("实体ID", "EntityID");
		AddValueOutput("选中的技能", () => _selectAbilityID);
		_successOutput = AddFlowOutput("成功");
		_errorOutput = AddFlowOutput("Error");
		ValueInput<int> exceptIDInput = AddValueInput<int>("要略过的ID");
		ValueInput<bool> isOnlyInSlotInput = AddValueInput<bool>("是否只选取技能槽中的技能").SetDefaultAndSerializedValue(v: false);
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			if (entityWithEntityID == null)
			{
				_errorOutput.Call(f);
			}
			else
			{
				_abilityInCDs.Clear();
				int value = exceptIDInput.value;
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId);
				for (int i = 0; i < config.AllSkills.Count; i++)
				{
					if (config.AllSkills.get_Item(i) != value && CDProcessor.GetCD(entityWithEntityID, config.AllSkills.get_Item(i), out var abilityCD) && abilityCD.CD > 0)
					{
						if (isOnlyInSlotInput.value)
						{
							if (entityWithEntityID.hasEntityBlackboard)
							{
								for (int j = 0; j < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length; j++)
								{
									if (entityWithEntityID.entityBlackboard.var.mAbilitySlots[j] == abilityCD.AbilityID)
									{
										_abilityInCDs.Add(abilityCD);
										break;
									}
								}
							}
						}
						else
						{
							_abilityInCDs.Add(abilityCD);
						}
					}
				}
				if (_abilityInCDs.Count > 0)
				{
					int index = (int)DRandom.Random((uint)_abilityInCDs.Count);
					AbilityCD abilityCD2 = _abilityInCDs[index];
					OnProcessAbility(entityWithEntityID, abilityCD2);
					AbilityConfig config2 = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(abilityCD2.AbilityID);
					if (config2 == null)
					{
						_errorOutput.Call(f);
						return;
					}
					for (int k = 0; k < config2.SyncCDSkillID.Count; k++)
					{
						CDProcessor.ShareCD(entityWithEntityID, abilityCD2.AbilityID, config2.SyncCDSkillID.get_Item(k));
					}
					_selectAbilityID = abilityCD2.AbilityID;
				}
				_successOutput.Call(f);
			}
		});
	}

	protected virtual void OnProcessAbility(SimEntity simEntity, AbilityCD abilityCD)
	{
		CDProcessor.SetCD(simEntity, abilityCD.AbilityID, 0, abilityCD.UsedCount);
	}
}
