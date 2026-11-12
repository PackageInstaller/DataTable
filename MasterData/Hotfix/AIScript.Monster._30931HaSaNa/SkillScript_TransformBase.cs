using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_TransformBase : SkillSimpleBase
{
	private readonly List<int> teammateIndexes_Device = new List<int> { 1, 2, 3, 4 };

	protected readonly string linkFx = "fx_30931JiGuanZhuangZhi_loop_charge_link_2";

	protected readonly List<MonsterAdventureActor> _activeDevices = new List<MonsterAdventureActor>(4);

	protected readonly List<MonsterAdventureActor> _deactiveDevices = new List<MonsterAdventureActor>(4);

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_activeDevices.Clear();
		_deactiveDevices.Clear();
	}

	protected int GetActiveDeviceCount()
	{
		int num = 0;
		foreach (int item in teammateIndexes_Device)
		{
			int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, item);
			List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
			if (list == null || list.Count <= 0)
			{
				continue;
			}
			foreach (LogicEntity item2 in list)
			{
				if (item2 is MonsterAdventureActor monsterAdventureActor)
				{
					if (GetLogicTagToggleValue(monsterAdventureActor, "IsActive"))
					{
						num++;
						_activeDevices.Add(monsterAdventureActor);
					}
					else
					{
						_deactiveDevices.Add(monsterAdventureActor);
					}
				}
			}
		}
		if (GetLogicTagFpValue(_actor, "Difficulty") == 1)
		{
			return 0;
		}
		return num;
	}
}
