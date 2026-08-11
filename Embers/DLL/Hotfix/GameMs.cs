public struct GameMs
{
	public long SendTimeStamp;

	public long ReceiveTimeStamp;

	public long Ms;

	public void GetMs()
	{
		Ms = ReceiveTimeStamp - SendTimeStamp;
	}

	public void Clear()
	{
		SendTimeStamp = 0L;
		ReceiveTimeStamp = 0L;
		Ms = 0L;
	}
}
