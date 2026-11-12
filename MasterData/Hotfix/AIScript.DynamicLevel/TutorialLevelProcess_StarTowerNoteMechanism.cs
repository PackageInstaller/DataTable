using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TutorialLevelProcess_StarTowerNoteMechanism : TutorialLevelProcessBase
{
	private readonly int buffId_Room = 911210110;

	private readonly Dictionary<int, string> operationTipsDic = new Dictionary<int, string>
	{
		[1210701] = "Tutorial_NoteGuide_1",
		[1210702] = "Tutorial_NoteGuide_2",
		[1210703] = "Tutorial_GuideEnd"
	};

	private readonly Dictionary<int, FP> waitTimeDic = new Dictionary<int, FP>
	{
		[1210701] = 3.5,
		[1210702] = 1
	};

	private readonly List<int> showNoteIdList = new List<int> { 90013, 90015, 90014 };

	private readonly Dictionary<int, Dictionary<int, int>> dropNoteDic = new Dictionary<int, Dictionary<int, int>>
	{
		[1210701] = new Dictionary<int, int>
		{
			[90013] = 5,
			[90014] = 5,
			[90015] = 5
		},
		[1210702] = new Dictionary<int, int>
		{
			[90013] = 5,
			[90014] = 5,
			[90015] = 5
		}
	};

	private readonly Dictionary<int, List<int>> activeNoteSkillDic = new Dictionary<int, List<int>>
	{
		[1210701] = new List<int>(),
		[1210702] = new List<int> { 3003101 }
	};

	private readonly string dropItemPath_Note = "Actor/Item/Drop_Tutorial/Drop_Note";

	private readonly string monsterSpawnWave_Note = "Wave_1";

	private readonly int dropNoteIndexInWave_Note = 2;

	private readonly string monsterSpawnWave_NoteSkill = "Wave_2";

	private readonly int dropNoteIndexInWave_NoteSkill = 4;

	private readonly int tutorialCardId_NoteSkill = 300119;

	private readonly FP delay_TutorialCard_NoteSkill = 4;

	private readonly FP waitTime_FreeBattle = 5;

	private readonly string interactiveId_FreeBattle = "TutorialEnd";

	private readonly Dictionary<int, int> _noteDic = new Dictionary<int, int>(10);

	private int _diedMonsterIndex;

	private int _dropNoteMonsterIndex;

	public override void OnLevelStart()
	{
		base.OnLevelStart();
		_noteDic.Clear();
		_dropNoteMonsterIndex = -1;
		foreach (int showNoteId in showNoteIdList)
		{
			_noteDic.Add(showNoteId, 0);
		}
		AddRoomBuff(buffId_Room);
		StartWaitTime(0.5, () =>
		{
			TriggerNextTask(300118, isLevelStart: true);
		});
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}

	public override void OnTriggerNextTask(int taskId)
	{
		base.OnTriggerNextTask(taskId);
		if (operationTipsDic.TryGetValue(taskId, out var value))
		{
			UpdateOperationTips(value);
		}
		switch (_subProcessIndex)
		{
		case 1:
			ActiveMonsterSpawnWave(monsterSpawnWave_Note);
			_dropNoteMonsterIndex = dropNoteIndexInWave_Note;
			break;
		case 2:
			ActiveMonsterSpawnWave(monsterSpawnWave_NoteSkill);
			_dropNoteMonsterIndex = dropNoteIndexInWave_NoteSkill;
			break;
		case 3:
			StartWaitTime(waitTime_FreeBattle, () =>
			{
				AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
				adventureInteractiveIDTrigger.interactiveID = interactiveId_FreeBattle;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
			});
			break;
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender } && !sender.IsSummoned(out var _, out var _) && _dropNoteMonsterIndex > 0)
		{
			_diedMonsterIndex++;
			if (_diedMonsterIndex == _dropNoteMonsterIndex)
			{
				ILRuntimeAPI.PlayDrop(_actor, dropItemPath_Note, sender.tsTransform.Position);
				_diedMonsterIndex = 0;
				_dropNoteMonsterIndex = -1;
			}
		}
	}

	private void UpdateNoteData(Dictionary<int, int> dropNoteInfo, List<int> activeNoteSkillIds)
	{
		if (dropNoteInfo == null || dropNoteInfo.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in dropNoteInfo)
		{
			int key = item.Key;
			int value = item.Value;
			if (_noteDic.ContainsKey(key))
			{
				_noteDic.get_Item(key) += value;
			}
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("TutorialRefreshNoteCount", _noteDic, dropNoteInfo, activeNoteSkillIds);
	}

	public override void OnTaskFinish(int taskId, bool isLastTask = false)
	{
		base.OnTaskFinish(taskId, isLastTask);
		if (dropNoteDic.TryGetValue(taskId, out var dropNoteInfo))
		{
			List<int> activeSkillIds = new List<int>();
			if (activeNoteSkillDic.TryGetValue(taskId, out var value) && value.Count > 0)
			{
				activeSkillIds.AddRange(value);
			}
			StartWaitTime(1, () =>
			{
				UpdateNoteData(dropNoteInfo, activeSkillIds);
			});
		}
		if (_subProcessIndex == 2)
		{
			StartWaitTime(delay_TutorialCard_NoteSkill, () =>
			{
				OpenTutorialCard(tutorialCardId_NoteSkill);
			});
		}
		if (!isLastTask && waitTimeDic.TryGetValue(taskId, out var value2))
		{
			StartWaitTime(value2, () =>
			{
				TriggerNextTask();
			});
		}
		else
		{
			TriggerNextTask();
		}
	}

	public override void OnLevelEnd()
	{
		base.OnLevelEnd();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}
}
