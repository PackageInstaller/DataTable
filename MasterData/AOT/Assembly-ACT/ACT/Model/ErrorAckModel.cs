using System.Collections.Generic;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Model.ErrorAckJosn;
using Newtonsoft.Json;
using UnityEngine;

namespace ACT.Model;

public class ErrorAckModel : Model<ErrorAckModel>
{
	public class ErrorList
	{
		public List<ErrorMsg> errorMsg { get; set; }
	}

	private List<ErrorMsg> errorMsgs;

	private async UniTask ReadJSONFile()
	{
		string assetID = "Assets/Scripts/Model/ErrorAckJosn/ErrorAck.json";
		AssetLoadHandle handle = AssetStationManager.Root.LoadAsync<TextAsset>(assetID);
		await handle;
		TextAsset textAsset = handle.As<TextAsset>();
		if (textAsset != null)
		{
			errorMsgs = JsonConvert.DeserializeObject<ErrorList>(textAsset.text).errorMsg;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("Json 为空，检查json文件");
		}
		AssetStationManager.Root.Release(handle);
	}

	public int MatchErrorMsgToID(string content)
	{
		return 0;
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}
}
