using System;
using System.Collections.Generic;

[Serializable]
public class BattleDataContainer
{
	public List<SingleBattleFrameMessage> SingleBattleFrameMessage { get; set; }

	public List<SingleBattleDamage> SingleBattleDamage { get; set; }
}
