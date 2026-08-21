using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指挥官攻击逻辑", 0)]
[Category("Logic/AI")]
[Description("指挥官攻击逻辑(http://wiki.in.ys4fun.com/pages/viewpage.action?pageId=33129636)")]
public class CommanderAttackLogic : FlowNode
{
	private List<int> targetList = new List<int>();

	private Dictionary<int, int> weights = new Dictionary<int, int>();

	private List<SimEntity> enemyList = new List<SimEntity>();

	private static bool GetWeightedRandom(Dictionary<int, int> weights, uint maxWeight, out int key)
	{
		key = 0;
		uint num = DRandom.Random(maxWeight);
		int num2 = 0;
		Dictionary<int, int>.Enumerator enumerator = weights.GetEnumerator();
		while (enumerator.MoveNext())
		{
			num2 += enumerator.Current.Value;
			if (num2 > num)
			{
				key = enumerator.Current.Key;
				return true;
			}
		}
		return false;
	}

	private static int GetTargetBuffNumber(SimEntity target, charactor_param entityConfig)
	{
		int num = 0;
		if (target.hasEntityBuff)
		{
			for (int i = 0; i < entityConfig.TargetDebuffArray.Count; i++)
			{
				if (target.entityBuff.mBuffConfigID.Contains(entityConfig.TargetDebuffArray.get_Item(i)))
				{
					num++;
				}
			}
		}
		return num;
	}

	private static bool HasBuff(SimEntity target)
	{
		if (target == null)
		{
			return false;
		}
		if (!target.hasEntityBuff)
		{
			return false;
		}
		bool result = false;
		for (int i = 0; i < target.entityBuff.mBuffConfigID.Count; i++)
		{
			int id = target.entityBuff.mBuffConfigID[i];
			if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(id, out var config) && config != null && config.Type == "BUFF")
			{
				result = true;
				break;
			}
		}
		return result;
	}

	private static bool ChooseEnemyToAttack(List<SimEntity> enemyList, SimEntity target, out SimEntity entity)
	{
		entity = null;
		if (enemyList.Count <= 0)
		{
			return false;
		}
		if (target == null)
		{
			return false;
		}
		int num = 0;
		bool flag = false;
		bool flag2 = false;
		int index = 0;
		int num2 = 0;
		for (int i = 0; i < enemyList.Count; i++)
		{
			SimEntity simEntity = enemyList[i];
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(simEntity.ENTITY_CONFIG_ID);
			if (config == null || config.AttackRate < num)
			{
				continue;
			}
			if (config.AttackRate > num)
			{
				num = config.AttackRate;
				flag = GetTargetBuffNumber(target, config) > 0;
				flag2 = HasBuff(simEntity);
				entity = simEntity;
				index = i;
				num2 = 1;
				continue;
			}
			int targetBuffNumber = GetTargetBuffNumber(target, config);
			if (flag && targetBuffNumber <= 0)
			{
				continue;
			}
			if (!flag && targetBuffNumber > 0)
			{
				flag = true;
				flag2 = HasBuff(simEntity);
				entity = simEntity;
				index = i;
				num2 = 1;
				continue;
			}
			bool flag3 = HasBuff(simEntity);
			if (flag2 && !flag3)
			{
				continue;
			}
			if (!flag2 & flag3)
			{
				flag2 = true;
				entity = simEntity;
				index = i;
				num2 = 1;
				continue;
			}
			num2++;
			if (DRandom.Random((uint)num2) == 0)
			{
				entity = simEntity;
				index = i;
			}
		}
		if (entity == null)
		{
			return false;
		}
		enemyList.RemoveAt(index);
		return true;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		enemyList.Clear();
		weights.Clear();
		targetList.Clear();
	}

	protected override void RegisterPorts()
	{
		AddFlowInput("", delegate
		{
			SimWorldState worldState = CommonProcessor.GetWorldState();
			if (worldState != null)
			{
				int difficulty = worldState.difficulty;
				ConfigHelper.GetInstance().TryGetConfig<diffculty>(difficulty, out var config);
				if (config != null)
				{
					int num = config.B1;
					int b = config.B2;
					targetList.Clear();
					weights.Clear();
					Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = worldState.mRoomMembers.GetEnumerator();
					while (enumerator.MoveNext())
					{
						SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enumerator.Current.Value.mEntityID);
						if (AIProcessor.CanLockOfEntity(entityWithEntityID))
						{
							targetList.Add(entityWithEntityID.creationIndex);
						}
					}
					int num2 = 100;
					if (targetList.Count > 0)
					{
						if (targetList.Count == 1)
						{
							weights[targetList[0]] = num2;
						}
						else if (targetList.Count == 2)
						{
							weights[targetList[0]] = b;
							weights[targetList[1]] = num2 - b;
						}
						else if (targetList.Count == 3)
						{
							weights[targetList[0]] = b;
							weights[targetList[1]] = (num2 - b) / 2;
							weights[targetList[2]] = num2 - weights[targetList[0]] - weights[targetList[1]];
						}
						targetList.Clear();
						int key;
						while (num > 0 && weights.Count > 0 && GetWeightedRandom(weights, (uint)num2, out key))
						{
							num2 -= weights[key];
							targetList.Add(key);
							weights.Remove(key);
							num--;
						}
						enemyList.Clear();
						for (int i = 0; i < worldState.mEnemys.Count; i++)
						{
							SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(worldState.mEnemys[i]);
							if (entityWithEntityID2 != null && !entityWithEntityID2.hasEntityHitRecover && entityWithEntityID2.entityBlackboard.var.enemyType == EnemyType.MonsterNormal)
							{
								AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityWithEntityID2.entityID.mID), 2196, out var baseValue, out var _, out var _);
								if (baseValue <= 0)
								{
									AttributeProcessor.GetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, 2208, out var baseValue2, out var plusValue2, out var tempPlusValue2);
									if (baseValue2 <= 0)
									{
										AttributeProcessor.GetAttributeWithIntName(entityWithEntityID2.entityBlackboard.var.mAttributeID, 2209, out baseValue2, out plusValue2, out tempPlusValue2);
										if (baseValue2 < 3)
										{
											enemyList.Add(entityWithEntityID2);
										}
									}
								}
							}
						}
						for (int j = 0; j < targetList.Count; j++)
						{
							SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(targetList[j]);
							int b2 = config.B3;
							long num3 = 0L;
							if (worldState.whoAttackRoles.TryGetValue(entityWithEntityID3.creationIndex, out var value))
							{
								for (int num4 = value.Count - 1; num4 >= 0; num4--)
								{
									int mID = value[num4];
									if (base.mSimContext.GetEntityWithEntityID(mID) == null)
									{
										value.RemoveAt(num4);
									}
								}
								num3 = value.Count;
							}
							SimEntity entity;
							while (num3 < b2 && ChooseEnemyToAttack(enemyList, base.mSimContext.GetEntityWithEntityID(targetList[j]), out entity))
							{
								AIProcessor.ChangeTarget(entity, targetList[j]);
								AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2209, 3L, 0L, 0L);
								base.mSimContext.GetSimInterface().mCommanderCommandEvent?.Invoke(entity.creationIndex, AICommanderEventType.Attack);
								AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2208, entityWithEntityID3.creationIndex, 0L, 0L);
								if (value == null)
								{
									value = new List<int> { entity.creationIndex };
									worldState.whoAttackRoles[entityWithEntityID3.creationIndex] = value;
								}
								else if (!value.Contains(entity.creationIndex))
								{
									value.Add(entity.creationIndex);
								}
								num3 = value.Count;
							}
						}
					}
				}
			}
		});
	}
}
