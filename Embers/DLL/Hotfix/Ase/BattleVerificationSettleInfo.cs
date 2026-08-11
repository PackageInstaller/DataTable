using Newtonsoft.Json;

namespace Ase;

public class BattleVerificationSettleInfo
{
	public int deaths;

	public int passTime;

	public float bossHpLeft;

	public bool result;

	public long roomId;

	public SingleBattleDamage playerMaxDamage;

	public SingleBattleDamage realMaxDamage;

	public string ToJson()
	{
		return JsonConvert.SerializeObject(this);
	}
}
