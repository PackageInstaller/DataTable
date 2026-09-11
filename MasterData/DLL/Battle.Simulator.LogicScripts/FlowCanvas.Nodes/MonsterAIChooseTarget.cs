using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("怪物AI选择目标", 0)]
[Category("Logic/AI")]
[Description("怪物AI选择目标, 规则很杂, 用之前参考wiki(https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=202128011)")]
public class MonsterAIChooseTarget : FlowNode
{
	private List<SimEntity> targetToChoose = new List<SimEntity>();

	private List<int> ringCount = new List<int>();

	private List<int> randomWeight = new List<int>();

	private List<bool> ignoreFlag = new List<bool>();

	public static int RandomWeight(List<int> weight)
	{
		int num = 0;
		for (int i = 0; i < weight.Count; i++)
		{
			num += weight[i];
		}
		if (num <= 0)
		{
			return -1;
		}
		int num2 = (int)DRandom.Random((uint)num);
		num = 0;
		for (int j = 0; j < weight.Count; j++)
		{
			num += weight[j];
			if (num > num2)
			{
				return j;
			}
		}
		return -1;
	}

	public static int GetRingIndex(List<int> count, int cur)
	{
		int num = 0;
		for (int i = 0; i < count.Count; i++)
		{
			num += count[i];
		}
		if (num <= 0)
		{
			return -1;
		}
		int num2 = cur % num;
		num = 0;
		for (int j = 0; j < count.Count; j++)
		{
			num += count[j];
			if (num > num2)
			{
				return j;
			}
		}
		return -1;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<ChooseTargetMode> randomInput = AddValueInput<ChooseTargetMode>("模式");
		ValueInput<List<int>> ringCountListInput = AddValueInput<List<int>>("循环攻击次数").SetDefaultAndSerializedValue(new List<int> { 4, 2, 2 });
		ValueInput<List<int>> ringIgnoreAICommandSetInput = AddValueInput<List<int>>("不计数的指令集");
		ValueInput<List<int>> randomWeightInput = AddValueInput<List<int>>("随机参数").SetDefaultAndSerializedValue(new List<int> { 50, 25, 25 });
		ValueInput<int> lockRangeInput = AddValueInput<int>("锁定范围");
		ValueInput<List<bool>> ignorePlayerInput = AddValueInput<List<bool>>("白名单").SetDefaultAndSerializedValue(new List<bool> { true, true, true });
		ValueInput<List<int>> ignoreBuffClassInput = AddValueInput<List<int>>("屏蔽buff类型");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput output = AddFlowOutput("有目标");
		FlowOutput hasTargetOutRangeOutput = AddFlowOutput("范围无目标");
		FlowOutput hasTargetInRangeOutput = AddFlowOutput("筛选无目标");
		FlowOutput errorOutput = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOutput.Call(f);
			}
			else
			{
				targetToChoose.Clear();
				ringCount.Clear();
				randomWeight.Clear();
				ignoreFlag.Clear();
				Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
				List<int> value = ringCountListInput.value;
				List<int> value2 = randomWeightInput.value;
				List<bool> value3 = ignorePlayerInput.value;
				int num = 0;
				while (enumerator.MoveNext())
				{
					int mEntityID = enumerator.Current.Value.mEntityID;
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID);
					if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && AIProcessor.CanLockOfEntity(entityWithEntityID2))
					{
						int item = 0;
						if (value != null && value.Count > num)
						{
							item = value[num];
						}
						ringCount.Add(item);
						int item2 = 0;
						if (value2 != null && value2.Count > num)
						{
							item2 = value2[num];
						}
						randomWeight.Add(item2);
						bool item3 = true;
						if (value3 != null && value3.Count > num)
						{
							item3 = value3[num];
						}
						ignoreFlag.Add(item3);
						targetToChoose.Add(entityWithEntityID2);
					}
					num++;
				}
				bool flag = targetToChoose.Count > 0;
				int value4 = lockRangeInput.value;
				if (value4 > 0)
				{
					for (int num2 = targetToChoose.Count - 1; num2 >= 0; num2--)
					{
						bool flag2 = false;
						if (!entityWithEntityID.hasEntityPositon)
						{
							flag2 = true;
						}
						else if (MovementProcessor.SqrDistance(entityWithEntityID, targetToChoose[num2]) > value4 * value4)
						{
							flag2 = true;
						}
						if (flag2)
						{
							targetToChoose.RemoveAt(num2);
							ringCount.RemoveAt(num2);
							randomWeight.RemoveAt(num2);
							ignoreFlag.RemoveAt(num2);
						}
					}
				}
				bool flag3 = targetToChoose.Count > 0;
				List<int> value5 = ignoreBuffClassInput.value;
				for (int num3 = targetToChoose.Count - 1; num3 >= 0; num3--)
				{
					bool flag4 = false;
					if (!ignoreFlag[num3])
					{
						flag4 = true;
					}
					else if (value5 != null)
					{
						foreach (int item4 in value5)
						{
							if (BuffProcessor.HasBuffOfClassID(targetToChoose[num3], item4))
							{
								flag4 = true;
								break;
							}
						}
					}
					if (flag4)
					{
						targetToChoose.RemoveAt(num3);
						ringCount.RemoveAt(num3);
						randomWeight.RemoveAt(num3);
						ignoreFlag.RemoveAt(num3);
					}
				}
				if (targetToChoose.Count <= 0)
				{
					if (flag3)
					{
						hasTargetInRangeOutput.Call(f);
					}
					else if (flag)
					{
						hasTargetOutRangeOutput.Call(f);
					}
				}
				else if (randomInput.value == ChooseTargetMode.Random)
				{
					num = RandomWeight(randomWeight);
					if (num >= 0 && num < targetToChoose.Count)
					{
						targetID = targetToChoose[num].creationIndex;
						AIProcessor.ChangeTarget(entityWithEntityID, targetID);
						output.Call(f);
					}
					else
					{
						errorOutput.Call(f);
					}
				}
				else
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2215, out var baseValue, out var plusValue, out var tempPlusValue);
					num = GetRingIndex(ringCount, (int)baseValue);
					if (num >= 0 && num < targetToChoose.Count)
					{
						targetID = targetToChoose[num].creationIndex;
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2213, out var baseValue2, out tempPlusValue, out plusValue);
						bool flag5 = true;
						if (baseValue2 != 0L)
						{
							flag5 = false;
						}
						else
						{
							AIProcessor.ChangeTarget(entityWithEntityID, targetID);
						}
						AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2216, out var baseValue3, out plusValue, out tempPlusValue);
						List<int> value6 = ringIgnoreAICommandSetInput.value;
						if (value6 != null && value6.Contains((int)baseValue3))
						{
							flag5 = false;
						}
						if (flag5)
						{
							baseValue++;
						}
						AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2215, baseValue, 0L, 0L);
						output.Call(f);
					}
					else
					{
						errorOutput.Call(f);
					}
				}
			}
		});
	}
}
