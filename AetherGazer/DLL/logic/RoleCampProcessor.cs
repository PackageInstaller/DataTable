using Config;

public class RoleCampProcessor
{
	public const uint CAMP_MASK = 255u;

	public const uint ALL_MASK = uint.MaxValue;

	public static void Set(ref uint roleCamp, uint type)
	{
		roleCamp |= type;
	}

	public static void Del(ref uint roleCamp, uint type)
	{
		roleCamp ^= type;
	}

	public static bool Is(uint mask, uint roleCamp)
	{
		return (mask & roleCamp) == roleCamp;
	}

	public static uint GetCamp(uint roleCamp)
	{
		return roleCamp & 0xFF;
	}

	public static uint GetInterestCamp(uint roleCamp)
	{
		uint mask = 0u;
		for (int i = 0; i < 32; i++)
		{
			if ((roleCamp & (1 << i)) != 0L && ConfigHelper.GetInstance().HasConfig<InterestConfig>(1 << i))
			{
				ConfigHelper.GetInstance().GetConfig<InterestConfig>(1 << i).ToMask(ref mask);
			}
		}
		return mask;
	}

	public static uint GetInterestCamp(uint pRoleCamp, uint pExcludeRoleCamp)
	{
		uint interestCamp = GetInterestCamp(pRoleCamp);
		return interestCamp & ~pExcludeRoleCamp;
	}

	public static uint GetInterestCamp(RoleType pRoleType, RoleType pExcludeRoleType1)
	{
		return GetInterestCamp((uint)pRoleType, (uint)pExcludeRoleType1);
	}

	public static uint GetInterestCamp(RoleType pRoleType, RoleType pExcludeRoleType1, RoleType pExcludeRoleType2)
	{
		return GetInterestCamp((uint)pRoleType, (uint)(pExcludeRoleType1 | pExcludeRoleType2));
	}

	public static uint GetInterestCampWithoutBunkerAndAvoidShadow(uint pRoleCamp)
	{
		return GetInterestCamp(pRoleCamp, 520u);
	}

	public static int GetCampWhoInterestedWithMe(uint roleCamp)
	{
		int num = 0;
		for (int i = 0; i < 32; i++)
		{
			if (!ConfigHelper.GetInstance().HasConfig<InterestConfig>(1 << i))
			{
				continue;
			}
			InterestConfig config = ConfigHelper.GetInstance().GetConfig<InterestConfig>(1 << i);
			for (int j = 0; j < config.Group.Count; j++)
			{
				if ((long)config.Group.get_Item(j) == roleCamp)
				{
					num |= 1 << i;
				}
			}
		}
		return num;
	}

	public static bool CompareCamp(uint aCamp, uint bCamp)
	{
		uint num = aCamp & 0xFF;
		uint num2 = bCamp & 0xFF;
		return num == num2;
	}

	public static bool IsPlayer(uint roleCamp)
	{
		return Is(roleCamp, 1u);
	}

	public static bool IsEnemy(uint roleCamp)
	{
		return Is(roleCamp, 2u);
	}

	public static bool IsNeutral(uint roleCamp)
	{
		return Is(roleCamp, 4u);
	}

	public static bool IsBunker(uint roleCamp)
	{
		return Is(roleCamp, 8u);
	}

	public static bool IsTrigger(uint roleCamp)
	{
		return Is(roleCamp, 16u);
	}

	public static bool IsAvoidShadow(uint roleCamp)
	{
		return Is(roleCamp, 512u);
	}
}
