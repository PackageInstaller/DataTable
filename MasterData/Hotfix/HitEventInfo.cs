using System.Collections.Generic;
using Nova.Hotfix;

public class HitEventInfo
{
	public HitDamage hitDamageConfig;

	public int uniqueAttackId;

	public int onceAttackTargetCount;

	public List<int> hitElementTypes;

	public HitEventInfo(HitDamage hitDamageConfig, int uniqueAttackId, int onceAttackTargetCount, List<int> hitElementTypes)
	{
		this.hitDamageConfig = hitDamageConfig;
		this.uniqueAttackId = uniqueAttackId;
		this.onceAttackTargetCount = onceAttackTargetCount;
		this.hitElementTypes = hitElementTypes;
	}

	public void Clear()
	{
		hitDamageConfig = null;
		uniqueAttackId = 0;
		onceAttackTargetCount = 0;
		hitElementTypes?.Clear();
		hitElementTypes = null;
	}
}
