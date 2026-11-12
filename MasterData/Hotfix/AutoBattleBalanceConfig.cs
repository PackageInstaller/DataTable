using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "AutoBattleBalanceConfig", menuName = "BootConfig/AutoBattleBalanceConfig", order = 11)]
public class AutoBattleBalanceConfig : ScriptableObject
{
	public List<ABTeam> ABTeamlist = new List<ABTeam>();
}
