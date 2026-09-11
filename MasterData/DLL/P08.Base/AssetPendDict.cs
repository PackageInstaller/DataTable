using System;
using System.Collections.Generic;

[Serializable]
public class AssetPendDict
{
	public bool disable;

	public Dictionary<string, List<string>> pendDict;

	public Dictionary<string, List<string>> voiceDict;

	public List<string> allPend;

	public List<string> allVoice;

	public List<string> skipNewbiePermanentAllPend;

	public List<string> skipNewbiePermanentAllVoice;

	public List<string> skipAdvancePermanentAllPend;

	public List<string> skipAdvancePermanentAllVoice;

	public List<string> assetList;

	public List<string> voiceList;

	public List<string> newbieList;

	public List<string> advanceList;

	public List<string> permanentList;

	public AssetPendDict()
	{
		pendDict = new Dictionary<string, List<string>>();
		voiceDict = new Dictionary<string, List<string>>();
		allPend = new List<string>();
		allVoice = new List<string>();
		skipNewbiePermanentAllPend = new List<string>();
		skipNewbiePermanentAllVoice = new List<string>();
		skipAdvancePermanentAllPend = new List<string>();
		skipAdvancePermanentAllVoice = new List<string>();
		assetList = new List<string>();
		voiceList = new List<string>();
		newbieList = new List<string>();
		advanceList = new List<string>();
		permanentList = new List<string>();
	}
}
