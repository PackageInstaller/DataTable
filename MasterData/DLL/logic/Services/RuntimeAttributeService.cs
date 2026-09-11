namespace Services;

public class RuntimeAttributeService : IRuntimeAttributeService, IService
{
	private const int kMaxCount = 512;

	private EntityAttribute[] mEntityAttributeTable = new EntityAttribute[512];

	private int[] mEntityIDs = new int[512];

	public long mBattleID;

	private int mIDSeed = -1;

	public bool TryGetAttribute(int id, out EntityAttribute attribute)
	{
		if (id < 0 || id > mIDSeed)
		{
			attribute = null;
			return false;
		}
		attribute = mEntityAttributeTable[id];
		return attribute != null;
	}

	public int CreateAttribute(int entityID, out EntityAttribute entityAttribute)
	{
		mIDSeed++;
		entityAttribute = new EntityAttribute((int)mBattleID);
		mEntityAttributeTable[mIDSeed] = entityAttribute;
		mEntityIDs[mIDSeed] = entityID;
		return mIDSeed;
	}

	public void Shutdown()
	{
		mEntityAttributeTable = null;
		mIDSeed = -1;
		mEntityIDs = null;
		mBattleID = 0L;
	}

	public static int BinarySearch(int[] arr, int low, int high, int key)
	{
		if (low > high || low < 0 || high < 0)
		{
			return -1;
		}
		int num = (low + high) / 2;
		if (arr[num] == key)
		{
			return num;
		}
		if (arr[num] > key)
		{
			return BinarySearch(arr, low, num - 1, key);
		}
		return BinarySearch(arr, num + 1, high, key);
	}

	public int TryGetAttributeIDByEntityID(int id)
	{
		return BinarySearch(mEntityIDs, 0, mIDSeed, id);
	}
}
