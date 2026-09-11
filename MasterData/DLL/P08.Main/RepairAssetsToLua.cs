public class RepairAssetsToLua
{
	public static void VerifyAssets()
	{
		RepairAssets.VerifyAssets();
	}

	public static bool HasError()
	{
		return RepairAssets.HasError();
	}

	public static int GetTotalVerifyCount()
	{
		return RepairAssets.GetTotalVerifyCount();
	}

	public static int GetCurrentVerifyIndex()
	{
		return RepairAssets.GetCurrentVerifyIndex();
	}

	public static bool IsVerifying()
	{
		return RepairAssets.IsVerifying();
	}

	public static void StopVerify()
	{
		RepairAssets.StopVerify();
	}
}
