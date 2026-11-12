public class PlayerVirtualSpawnPoint : BaseSpawnPointGizmo
{
	public int waveIndex;

	public float meleeInnerRadius;

	public float meleeOuterRadius;

	public float meleeAngle;

	public float meleeRotation;

	public bool showMeleeFan;

	public float remotelyInnerRadius;

	public float remotelyOuterRadius;

	public float remotelyAngle;

	public float remotelyRotation;

	public bool showRemotelyFan;

	public bool isInitialMonsterSameTimeBattle;

	public bool isReplenishMonsterSameTimeBattle;

	public float replenishMonsterInterval;

	public float waveRefreshInterval;

	public MonsterStrollSchemes monsterStrollSchemes;

	public MonsterStrollSchemes.MonsterStrollScheme[] MonsterStrollSchemes
	{
		get
		{
			if (!(null == monsterStrollSchemes))
			{
				return monsterStrollSchemes.monsterStrollSchemes;
			}
			return null;
		}
	}
}
