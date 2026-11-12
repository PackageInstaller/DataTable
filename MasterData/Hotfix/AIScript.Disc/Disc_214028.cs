using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214028 : DiscScriptBase
{
	private const int discId = 214028;

	private List<int> skillId_s3 = new List<int> { 4028201, 4028202, 4028203, 4028204, 4028205 };

	private int count_3 = 10;

	private List<int> buffId_3 = new List<int> { 4028201, 4028202, 4028203, 4028204, 4028205 };

	private List<FP> cd_3 = new List<FP> { 10, 10, 10, 10, 10 };

	private int stage;

	private int lv_s3;

	private Dictionary<LogicEntity, FP> hitCdDic = new Dictionary<LogicEntity, FP>();

	private Dictionary<LogicEntity, int> hitCountDic = new Dictionary<LogicEntity, int>();

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage, lv_s3) = GetDiscInfo(214028, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		hitCdDic.Clear();
		hitCountDic.Clear();
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor monster, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, monster, damageEvent);
		if (lv_s3 <= 0 || monster.buffComponent.CheckBuffByBuffID(buffId_3.get_Item(stage)))
		{
			return;
		}
		bool flag = false;
		if (hitCountDic.TryGetValue(monster, out var value))
		{
			value++;
			if (value >= count_3)
			{
				flag = true;
			}
			hitCountDic.set_Item((LogicEntity)monster, value);
		}
		else
		{
			value++;
			hitCountDic.Add(monster, value);
		}
		bool flag2 = false;
		if (flag)
		{
			if (hitCdDic.TryGetValue(monster, out var value2))
			{
				if (_actor.LogicTime - value2 > cd_3.get_Item(stage))
				{
					hitCdDic.set_Item((LogicEntity)monster, _actor.LogicTime);
					flag2 = true;
				}
			}
			else
			{
				hitCdDic.Add(monster, _actor.LogicTime);
				flag2 = true;
			}
		}
		if (flag & flag2)
		{
			hitCountDic.set_Item((LogicEntity)monster, 0);
			monster.buffComponent.AddBuff(buffId_3.get_Item(stage), actor);
		}
	}
}
