namespace ACT.World;

public class TransferLinkTrackMonsterPointRule
{
	private static int _l1Max = 100;

	private static int _l2Max = 200;

	private static int _l3Max = 300;

	public static int maxValidDistance => _l3Max;

	public static MonsterPointCollectionLevel GetMonsterPointCollectionLevel(float distance)
	{
		if (distance < (float)_l1Max)
		{
			return MonsterPointCollectionLevel.L1;
		}
		if (distance < (float)_l2Max)
		{
			return MonsterPointCollectionLevel.L2;
		}
		if (distance < (float)_l3Max)
		{
			return MonsterPointCollectionLevel.L3;
		}
		return MonsterPointCollectionLevel.None;
	}
}
