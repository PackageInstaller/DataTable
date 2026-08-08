using System;

[Serializable]
public class CriAtomCueSheet
{
	public string name = "";

	public string acbFile = "";

	public string awbFile = "";

	public CriAtomExAcb acb;

	public CriAtomExAcbLoader.Status loaderStatus;

	public bool IsLoading => loaderStatus == CriAtomExAcbLoader.Status.Loading;

	public bool IsError
	{
		get
		{
			if (loaderStatus != CriAtomExAcbLoader.Status.Error)
			{
				if (!IsLoading)
				{
					return acb == null;
				}
				return false;
			}
			return true;
		}
	}
}
