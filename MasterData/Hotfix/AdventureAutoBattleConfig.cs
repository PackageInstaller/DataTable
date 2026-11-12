using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "AutoBattleConfig", menuName = "BootConfig/AutoBattleConfig", order = 10)]
public class AdventureAutoBattleConfig : ScriptableObject
{
	[Serializable]
	public struct AutoBattleCommandStruct
	{
		public AdventureAutoBattleCommands.AutoBattleCommandType commandType;

		public float holdDuration;
	}

	public List<AutoBattleCommandStruct> autoBattleCommands = new List<AutoBattleCommandStruct>
	{
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.SkillUltimate
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.Skill
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_1
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.CastUltimate_2
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_1
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.CastSkill_2
		}
	};

	public List<AutoBattleCommandStruct> autoBattleCommandsDefault = new List<AutoBattleCommandStruct>
	{
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.Dodge
		},
		new AutoBattleCommandStruct
		{
			commandType = AdventureAutoBattleCommands.AutoBattleCommandType.Attack
		}
	};

	public float decisionInterval = 0.1f;

	public float presetAutoBattleTime = 300f;

	public float timeScale = 1f;
}
