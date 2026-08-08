using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("护盾抵挡伤害", 0)]
[Category("Logic/Attribute")]
[Description("护盾抵挡伤害")]
[ExposeAsDefinition]
public class OnGetHurtAndHasShield : FlowNode
{
	public const int SHIELD_BUFF_CLASS_ID = 102;

	public const int SHIELD_MAX_HP_BUFF_CLASS_ID = 108;

	private int _damage;

	private static int GetShieldPatternType(int type)
	{
		return type & 0xF;
	}

	private static int GetShieldElement(int type)
	{
		return type & 0xFF0;
	}

	private static bool IsElement(int type, int elementType)
	{
		int num = type >> 4;
		if (num != elementType)
		{
			return num == 255;
		}
		return true;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> damageInput = AddValueInput<int>("伤害值");
		ValueInput<SkillDamageType> damageElementInput = AddValueInput<SkillDamageType>("伤害属性");
		AddValueOutput("剩余伤害", () => _damage);
		FlowOutput noHurt = AddFlowOutput("吸收");
		FlowOutput beHurt = AddFlowOutput("伤害");
		AddFlowInput("", delegate(Flow f)
		{
			_ = damageElementInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int damage = damageInput.value;
			while (entityWithEntityID.hasEntityBuff && Process(base.mSimContext, entityWithEntityID, ref damage, damageElementInput.value) && damage > 0)
			{
			}
			_damage = damage;
			if (damage > 0)
			{
				beHurt.Call(f);
			}
			else
			{
				noHurt.Call(f);
			}
		});
	}

	private bool Process(SimContext simContext, SimEntity entity, ref int damage, SkillDamageType value)
	{
		if (!ProcessShieldWithstand(simContext, entity, (int)value, out var index, out var element, out var shieldPattern))
		{
			return false;
		}
		return ProcessDamage(entity, index, shieldPattern, element, ref damage);
	}

	public static bool ProcessShieldWithstand(SimContext simContext, SimEntity entity, int damageElement, out int index, out SkillDamageType element, out ShieldPatternType shieldPattern)
	{
		index = -1;
		element = SkillDamageType.Physics;
		shieldPattern = ShieldPatternType.None;
		int num = 0;
		int num2 = 0;
		EntityBuff entityBuff = entity.entityBuff;
		for (int num3 = entityBuff.mBuffClassIDArray.Count - 1; num3 >= 0; num3--)
		{
			int num4 = entityBuff.mBuffClassIDArray[num3];
			if ((102 == num4 || 108 == num4) && !entity.entityBuff.IsInPendingRemoveArray(entity.entityBuff.mBuffID[num3]))
			{
				BuffParams buffParams = entityBuff.mBuffParamsArray[num3];
				if (108 == num4 && !buffParams.v3.boolVar)
				{
					SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityBuff.mBuffCasterArray[num3]);
					public_buff config2;
					if (buffParams.v1.boolVar && entityWithEntityID != null)
					{
						if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityBuff.mBuffConfigID[num3], out var config))
						{
							entityBuff.mBuffParamsArray[num3] = new BuffParams
							{
								v1 = config.BuffparamBase.get_Item(0),
								v2 = entityWithEntityID.entityBlackboard.var.mMaxHP * (config.BuffparamBase.get_Item(1) + config.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1)) / 1000,
								v3 = true,
								v4 = entityWithEntityID.entityBlackboard.var.mMaxHP * (config.BuffparamBase.get_Item(1) + config.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1)) / 1000
							};
						}
						else
						{
							entityBuff.mBuffParamsArray[num3] = new BuffParams
							{
								v1 = buffParams.v1,
								v2 = entity.entityBlackboard.var.mMaxHP * buffParams.v2.intVar / 1000,
								v3 = true,
								v4 = entity.entityBlackboard.var.mMaxHP * buffParams.v2.intVar / 1000
							};
						}
					}
					else if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityBuff.mBuffConfigID[num3], out config2))
					{
						entityBuff.mBuffParamsArray[num3] = new BuffParams
						{
							v1 = config2.BuffparamBase.get_Item(0),
							v2 = entity.entityBlackboard.var.mMaxHP * (config2.BuffparamBase.get_Item(1) + config2.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1)) / 1000,
							v3 = true,
							v4 = entity.entityBlackboard.var.mMaxHP * (config2.BuffparamBase.get_Item(1) + config2.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1)) / 1000
						};
					}
					else
					{
						entityBuff.mBuffParamsArray[num3] = new BuffParams
						{
							v1 = buffParams.v1,
							v2 = entity.entityBlackboard.var.mMaxHP * buffParams.v2.intVar / 1000,
							v3 = true,
							v4 = entity.entityBlackboard.var.mMaxHP * buffParams.v2.intVar / 1000
						};
					}
					buffParams = entityBuff.mBuffParamsArray[num3];
				}
				if (num4 == 102 && !buffParams.v3.boolVar)
				{
					if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(entityBuff.mBuffConfigID[num3], out var config3))
					{
						entityBuff.mBuffParamsArray[num3] = new BuffParams
						{
							v1 = config3.BuffparamBase.get_Item(0),
							v2 = config3.BuffparamBase.get_Item(1) + config3.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1),
							v3 = true,
							v4 = config3.BuffparamBase.get_Item(1) + config3.BuffparamFactor.get_Item(1) * (entityBuff.mBuffFloor[num3] - 1)
						};
					}
					else
					{
						entityBuff.mBuffParamsArray[num3] = new BuffParams
						{
							v1 = buffParams.v1,
							v2 = buffParams.v2.intVar,
							v3 = true,
							v4 = buffParams.v2.intVar
						};
					}
					buffParams = entityBuff.mBuffParamsArray[num3];
				}
				int type = buffParams.v1;
				int shieldPatternType = GetShieldPatternType(type);
				int shieldElement = GetShieldElement(type);
				if (IsElement(type, damageElement) && (0 > index || shieldPatternType > num || (shieldPatternType == num && shieldElement < num2)))
				{
					index = num3;
					num = shieldPatternType;
					num2 = shieldElement;
				}
			}
		}
		if (index >= 0)
		{
			element = (SkillDamageType)num2;
			shieldPattern = (ShieldPatternType)num;
			return true;
		}
		return false;
	}

	private bool ProcessDamage(SimEntity entity, int index, ShieldPatternType shield, SkillDamageType element, ref int damage)
	{
		BuffParams value = entity.entityBuff.mBuffParamsArray[index];
		if (ShieldPatternType.ByTime == shield)
		{
			ref SimVar v = ref value.v2;
			v = (int)v - 1;
			damage = 0;
		}
		else if ((int)value.v2 < damage)
		{
			damage -= value.v2;
			value.v2 = 0;
		}
		else
		{
			ref SimVar v2 = ref value.v2;
			v2 = (int)v2 - damage;
			damage = 0;
		}
		if ((int)value.v2 <= 0)
		{
			entity.entityBuff.mBuffParamsArray[index] = value;
			BuffProcessor.RemoveBuffID(0, entity.creationIndex, entity.entityBuff.mBuffID[index]);
			return false;
		}
		entity.entityBuff.mBuffParamsArray[index] = value;
		return true;
	}
}
