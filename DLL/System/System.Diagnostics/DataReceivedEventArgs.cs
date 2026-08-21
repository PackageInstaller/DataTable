namespace System.Diagnostics;

public class DataReceivedEventArgs : EventArgs
{
	private string data;

	internal DataReceivedEventArgs(string data)
	{
		this.data = data;
	}
}
