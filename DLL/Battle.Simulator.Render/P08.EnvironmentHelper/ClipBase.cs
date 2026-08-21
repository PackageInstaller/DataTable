namespace P08.EnvironmentHelper;

public class ClipBase
{
	public bool IsAuto = true;

	public float Length;

	public bool IsObsolete = true;

	public float Normalized;

	public void InitBaseData(bool pIsAuto, float pLength)
	{
		IsAuto = pIsAuto;
		Length = pLength;
		IsObsolete = false;
		Normalized = 0f;
	}

	public void ResetData()
	{
		IsAuto = true;
		IsObsolete = true;
		Normalized = 0f;
		Length = 0f;
	}
}
