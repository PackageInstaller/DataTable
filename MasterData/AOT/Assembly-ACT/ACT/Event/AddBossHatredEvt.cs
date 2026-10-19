using Bamboo.ECS;

namespace ACT.Event;

public class AddBossHatredEvt : BaseEventContent
{
	public EntityId entityId;

	public int id;

	public int level;

	public int basicMaxHp;

	public int curMaxHp;

	public int curHp;

	public float curHpPercentage;

	public bool inPosture;

	public int maxPosture;

	public int curPosture;

	public float curPosturePercentage;

	public bool inWeak;

	public int maxWeak;

	public int curWeak;

	public float curWeakPercentage;

	public bool inBurst;

	public int maxBurst;

	public int curBurst;

	public float curBurstPercentage;

	public int damageType;

	public bool shareBossInfoUI;

	public int bossInfoGroupUid;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		id = (level = 0);
		basicMaxHp = (curMaxHp = (curHp = 0));
		curHpPercentage = 0f;
		inPosture = false;
		maxPosture = (curPosture = 0);
		curPosturePercentage = 0f;
		inWeak = false;
		maxWeak = (curWeak = 0);
		curWeakPercentage = 0f;
		inBurst = false;
		maxBurst = (curBurst = 0);
		curBurstPercentage = 0f;
		damageType = 0;
		shareBossInfoUI = false;
		bossInfoGroupUid = -1;
	}
}
