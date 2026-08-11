namespace Ase;

public struct AutoFightStatistics
{
	public int OpenCount;

	public int AutoFightTimer;

	public string OpenAutoFightTime;

	public string CloseAutoFightTime;

	public bool TimerOutAutoOpen;

	public bool OpenUseProp;

	public bool UseLastAutoFightState;

	public bool AutoFightState;

	public void Clear()
	{
		OpenCount = 0;
		AutoFightTimer = 0;
		OpenAutoFightTime = string.Empty;
		CloseAutoFightTime = string.Empty;
		TimerOutAutoOpen = false;
		AutoFightState = false;
	}
}
