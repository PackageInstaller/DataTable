namespace Ase;

public class FileSizeUtility
{
	public static float GetTotalSize(long totalSize, UNIT unit = UNIT.BYTE)
	{
		return unit switch
		{
			UNIT.KB => (float)totalSize / 1024f, 
			UNIT.MB => (float)totalSize / 1048576f, 
			UNIT.GB => (float)totalSize / 1.0737418E+09f, 
			_ => totalSize, 
		};
	}

	public static string ToMb(long totalSize)
	{
		return $"{GetTotalSize(totalSize, UNIT.MB):F1}";
	}

	public static string GetTotalSize(long totalSize)
	{
		return $"{GetTotalSize(totalSize, UNIT.MB):F2}MB";
	}
}
