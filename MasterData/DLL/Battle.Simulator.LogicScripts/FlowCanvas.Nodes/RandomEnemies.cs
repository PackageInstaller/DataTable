using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机敌人阵营(逻辑)", 0)]
[Category("Logic/PosAndRot")]
[Description("不放回随机敌人阵营,若随机数量大于剩余敌人数,则直接遍历剩余敌人")]
public class RandomEnemies : FlowControlNodeOfLogic
{
	private int _entityID;

	protected override void RegisterPorts()
	{
		ValueInput<int> numInput = AddValueInput<int>("数量", "num").SetDefaultAndSerializedValue(1);
		FlowOutput doOut = AddFlowOutput("Do", "do");
		FlowOutput doneOut = AddFlowOutput("Done", "done");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_entityID = 0;
			if (numInput.value <= 0)
			{
				doneOut.Call(f);
			}
			else
			{
				List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.mSimContext);
				int num = numInput.value;
				int count = allEnemy.Count;
				if (num >= count)
				{
					for (int num2 = allEnemy.Count - 1; num2 >= 0; num2--)
					{
						_entityID = allEnemy[num2];
						doOut.Call(f);
					}
				}
				else
				{
					List<int> list = FrameListPool<int>.Claim();
					do
					{
						int index = GetIndex(list, count, (int)DRandom.Random((uint)count));
						list.Add(index);
						num--;
						_entityID = allEnemy[index];
						doOut.Call(f);
					}
					while (num > 0);
					FrameListPool<int>.Release(list);
				}
				doneOut.Call(f);
			}
		});
		AddFlowInput("仅存活可重复随机", "repeatable", delegate(Flow f)
		{
			_entityID = 0;
			int num = numInput.value;
			if (num <= 0)
			{
				doneOut.Call(f);
			}
			else
			{
				List<int> allEnemy = SpawnProcessor.GetAllEnemy(base.mSimContext);
				if (allEnemy.Count <= 0)
				{
					doneOut.Call(f);
				}
				else
				{
					do
					{
						int num2 = (int)DRandom.Random((uint)allEnemy.Count);
						int indexForAliveEntity = GetIndexForAliveEntity(base.graph.mSimContext, allEnemy, num2, num2);
						if (indexForAliveEntity == -1)
						{
							doneOut.Call(f);
							break;
						}
						num--;
						_entityID = allEnemy[indexForAliveEntity];
						doOut.Call(f);
					}
					while (num > 0);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityID);
	}

	private int GetIndex(List<int> list, int count, int index)
	{
		if (list.Contains(index))
		{
			index = (index + 1) % count;
			index = GetIndex(list, count, index);
		}
		return index;
	}

	private int GetIndexForAliveEntity(SimContext pSimContext, List<int> enemies, int startIndex, int curIndex)
	{
		if (!CommonProcessor.IsAliveRole(pSimContext.GetEntityWithEntityID(enemies[curIndex])))
		{
			curIndex = (curIndex + 1) % enemies.Count;
			if (curIndex == startIndex)
			{
				return -1;
			}
			return GetIndexForAliveEntity(pSimContext, enemies, startIndex, curIndex);
		}
		return curIndex;
	}
}
