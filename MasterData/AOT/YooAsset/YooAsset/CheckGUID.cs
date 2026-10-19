namespace YooAsset;

public class CheckGUID
{
	public static bool IsUnityGUID(string guid)
	{
		if (string.IsNullOrEmpty(guid) || guid.Length != 32)
		{
			return false;
		}
		foreach (char c in guid)
		{
			if ((c < '0' || c > '9') && (c < 'a' || c > 'f') && (c < 'A' || c > 'F'))
			{
				return false;
			}
		}
		return true;
	}
}
