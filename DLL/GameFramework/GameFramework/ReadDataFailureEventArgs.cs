namespace GameFramework;

public sealed class ReadDataFailureEventArgs : GameFrameworkEventArgs
{
	public string DataAssetName { get; private set; }

	public string ErrorMessage { get; private set; }

	public object UserData { get; private set; }

	public ReadDataFailureEventArgs()
	{
		DataAssetName = null;
		ErrorMessage = null;
		UserData = null;
	}

	public static ReadDataFailureEventArgs Create(string dataAssetName, string errorMessage, object userData)
	{
		ReadDataFailureEventArgs e = ReferencePool.Acquire<ReadDataFailureEventArgs>();
		e.DataAssetName = dataAssetName;
		e.ErrorMessage = errorMessage;
		e.UserData = userData;
		return e;
	}

	public override void Clear()
	{
		DataAssetName = null;
		ErrorMessage = null;
		UserData = null;
	}
}
