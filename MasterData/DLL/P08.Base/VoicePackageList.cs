using System;
using System.Collections.Generic;

[Serializable]
public class VoicePackageList
{
	public List<VoicePackageVersionInfo> infos;

	public VoicePackageList()
	{
		infos = new List<VoicePackageVersionInfo>();
	}
}
