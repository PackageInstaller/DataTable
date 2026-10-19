using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class BatchIntOperation : Action
{
	public enum Operation
	{
		Add,
		Subtract,
		Multiply,
		Divide,
		Modulo,
		Set
	}

	public Operation operation;

	public SharedInt[] list;

	public SharedInt interger;

	public SharedInt exceptIndex;

	public override TaskStatus OnUpdate()
	{
		switch (operation)
		{
		case Operation.Add:
		{
			for (int l = 0; l < list.Length; l++)
			{
				if (l != exceptIndex.Value)
				{
					list[l].Value += interger.Value;
				}
			}
			break;
		}
		case Operation.Subtract:
		{
			for (int n = 0; n < list.Length; n++)
			{
				if (n != exceptIndex.Value)
				{
					list[n].Value -= interger.Value;
				}
			}
			break;
		}
		case Operation.Multiply:
		{
			for (int j = 0; j < list.Length; j++)
			{
				if (j != exceptIndex.Value)
				{
					list[j].Value *= interger.Value;
				}
			}
			break;
		}
		case Operation.Divide:
		{
			for (int m = 0; m < list.Length; m++)
			{
				if (m != exceptIndex.Value)
				{
					list[m].Value += interger.Value;
				}
			}
			break;
		}
		case Operation.Modulo:
		{
			for (int k = 0; k < list.Length; k++)
			{
				if (k != exceptIndex.Value)
				{
					list[k].Value %= interger.Value;
				}
			}
			break;
		}
		case Operation.Set:
		{
			for (int i = 0; i < list.Length; i++)
			{
				if (i != exceptIndex.Value)
				{
					list[i].Value = interger.Value;
				}
			}
			break;
		}
		}
		return TaskStatus.Success;
	}
}
