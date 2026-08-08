using System;

[Serializable]
public class ClientVersionStatus
{
	public int build;

	public int version;

	public int channel;

	public string versionName = "";

	public string voicePackageName = "zh";

	public string resBranchUrl = "";
}
