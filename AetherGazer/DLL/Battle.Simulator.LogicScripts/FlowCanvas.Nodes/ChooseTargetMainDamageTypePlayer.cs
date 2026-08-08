using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("选择攻击力最高的主属性目标（芯片整合）", 0)]
[Category("Logic/装备")]
[Description("指定队伍中某个元素属性攻击力最高角色\nhttps://wiki.in.ys4fun.com/pages/viewpage.action?pageId=157637482")]
public class ChooseTargetMainDamageTypePlayer : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<SkillDamageType> damageTypeInput = AddValueInput<SkillDamageType>("主属性");
		ValueInput<int> aiChipID1Input = AddValueInput<int>("追从芯片ID");
		ValueInput<int> aiChipID2Input = AddValueInput<int>("协力芯片ID");
		ValueInput<int> aiChipID3Input = AddValueInput<int>("当先芯片ID");
		ValueInput<int> maxaiChipNumberInput = AddValueInput<int>("最大芯片数量").SetDefaultAndSerializedValue(20);
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput trueOut = AddFlowOutput("成功");
		FlowOutput falseOut = AddFlowOutput("无目标");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				falseOut.Call(f);
			}
			else
			{
				SkillDamageType value = damageTypeInput.value;
				long plusValue2;
				long tempPlusValue2;
				if (entityWithEntityID.hasEntityAIThink)
				{
					int num = 2130;
					int value2 = maxaiChipNumberInput.value;
					int value3 = aiChipID1Input.value;
					int value4 = aiChipID2Input.value;
					int value5 = aiChipID3Input.value;
					for (int i = 0; i < value2; i++)
					{
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num + i, out var baseValue, out var _, out var _);
						if (baseValue == 0L)
						{
							break;
						}
						if (value3 == baseValue)
						{
							bool flag = false;
							int num2 = CommonProcessor.GetWorldState().mLocalPlayerID;
							if (num2 == 0)
							{
								Dictionary<MemberPosition, RemoteMember> mRoomMembers = CommonProcessor.GetWorldState().mRoomMembers;
								RemoteMember value6 = null;
								if (mRoomMembers.TryGetValue(MemberPosition.First, out value6))
								{
									num2 = value6.mEntityID;
								}
							}
							SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(num2);
							if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityConfig)
							{
								int mId = entityWithEntityID2.entityConfig.mId;
								if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(mId, out var config))
								{
									SkillDamageType skillDamageType = config.MainDamageType;
									if (skillDamageType == SkillDamageType.Random)
									{
										AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(num2), 2222, out var baseValue2, out plusValue2, out tempPlusValue2);
										skillDamageType = (SkillDamageType)baseValue2;
									}
									if (value == skillDamageType)
									{
										flag = true;
									}
								}
							}
							if (flag)
							{
								targetID = num2;
								trueOut.Call(f);
							}
							else
							{
								targetID = 0;
								falseOut.Call(f);
							}
							return;
						}
						if (value4 == baseValue)
						{
							bool flag2 = false;
							int num3 = 0;
							Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
							while (enumerator.MoveNext())
							{
								num3 = enumerator.Current.Value.mEntityID;
								if (num3 != entityID)
								{
									SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(num3);
									if (entityWithEntityID3 != null && entityWithEntityID3.hasEntityBlackboard && entityWithEntityID3.entityBlackboard.var.mHP > 0 && entityWithEntityID3.hasEntityConfig && entityWithEntityID3.hasEntityAIThink)
									{
										int mId2 = entityWithEntityID3.entityConfig.mId;
										if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(mId2, out var config2))
										{
											SkillDamageType skillDamageType2 = config2.MainDamageType;
											if (skillDamageType2 == SkillDamageType.Random)
											{
												AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(num3), 2222, out var baseValue3, out tempPlusValue2, out plusValue2);
												skillDamageType2 = (SkillDamageType)baseValue3;
											}
											if (value == skillDamageType2)
											{
												flag2 = true;
												break;
											}
										}
									}
								}
							}
							if (flag2)
							{
								targetID = num3;
								trueOut.Call(f);
							}
							else
							{
								targetID = 0;
								falseOut.Call(f);
							}
							return;
						}
						if (value5 == baseValue)
						{
							bool flag3 = false;
							if (entityWithEntityID.hasEntityConfig)
							{
								int mId3 = entityWithEntityID.entityConfig.mId;
								if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(mId3, out var config3))
								{
									SkillDamageType skillDamageType3 = config3.MainDamageType;
									if (skillDamageType3 == SkillDamageType.Random)
									{
										AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityWithEntityID.creationIndex), 2222, out var baseValue4, out plusValue2, out tempPlusValue2);
										skillDamageType3 = (SkillDamageType)baseValue4;
									}
									if (value == skillDamageType3)
									{
										flag3 = true;
									}
								}
							}
							if (flag3)
							{
								targetID = entityID;
								trueOut.Call(f);
							}
							else
							{
								targetID = 0;
								falseOut.Call(f);
							}
							return;
						}
					}
				}
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator2 = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
				int num4 = 0;
				targetID = 0;
				while (enumerator2.MoveNext())
				{
					int mEntityID = enumerator2.Current.Value.mEntityID;
					SimEntity entityWithEntityID4 = base.mSimContext.GetEntityWithEntityID(mEntityID);
					if (entityWithEntityID4 != null && entityWithEntityID4.hasEntityBlackboard && entityWithEntityID4.entityBlackboard.var.mHP > 0 && entityWithEntityID4.hasEntityConfig)
					{
						int mId4 = entityWithEntityID4.entityConfig.mId;
						if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(mId4, out var config4))
						{
							SkillDamageType skillDamageType4 = config4.MainDamageType;
							if (skillDamageType4 == SkillDamageType.Random)
							{
								AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(mEntityID), 2222, out var baseValue5, out tempPlusValue2, out plusValue2);
								skillDamageType4 = (SkillDamageType)baseValue5;
							}
							if (value == skillDamageType4)
							{
								int num5 = (int)DamageFormula.GetFinalAttackValue(AttributeProcessor.GetAttributeIDByEntityID(mEntityID)) / 1000;
								if (num5 > num4)
								{
									num4 = num5;
									targetID = mEntityID;
								}
							}
						}
					}
				}
				if (targetID != 0)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
