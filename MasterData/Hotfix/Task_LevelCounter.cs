using UnityEngine;

[AddComponentMenu("触发器结果/触发器内部事件/关卡计数器", 0)]
public class Task_LevelCounter : TaskCellBase
{
	public enum OpType
	{
		Add,
		Minus,
		Assign
	}

	public string counter;

	public OpType opType;

	public int target;

	protected override void OnExecute()
	{
		base.OnExecute();
		AdventureLevelController levelInstance = ModuleController<AdventureModuleController>.Instance.levelInstance;
		if (!levelInstance.dicLevelCounter.ContainsKey(counter))
		{
			levelInstance.dicLevelCounter.Add(counter, 0);
		}
		switch (opType)
		{
		case OpType.Add:
			levelInstance.dicLevelCounter.get_Item(counter) += target;
			break;
		case OpType.Minus:
			levelInstance.dicLevelCounter.get_Item(counter) -= target;
			break;
		case OpType.Assign:
			levelInstance.dicLevelCounter.set_Item(counter, target);
			break;
		}
		AdventureLevelCounterEvent adventureLevelCounterEvent = AdventureLevelCounterEvent.Generate();
		adventureLevelCounterEvent.counter = counter;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelCounterEvent);
		EndAction();
	}
}
