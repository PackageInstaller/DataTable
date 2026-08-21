using System.Collections;
using System.Collections.Generic;
using System.IO;
using Google.Protobuf;
using UnityEngine;

public class GlobalStaticLoader
{
	public static bool sIsInitConfig;

	public static int battleVersionCode;

	public static Dictionary<int, IMessage> stringConfig;

	public IEnumerator Load()
	{
		DownloadManager.Destroy();
		DownloadManager.Create();
		BattleVersionCode battleVersionCode = Asset.Load<BattleVersionCode>("BattleVersionCode");
		if (battleVersionCode != null)
		{
			GlobalStaticLoader.battleVersionCode = battleVersionCode.versionCode;
		}
		ShaderVariantCollection shaderVariantCollection = null;
		if (shaderVariantCollection == null)
		{
			shaderVariantCollection = Asset.Load<ShaderVariantCollection>("AllShaders");
			if (shaderVariantCollection != null && !shaderVariantCollection.isWarmedUp)
			{
				shaderVariantCollection.WarmUp();
			}
			yield return null;
			Asset.Unload("AllShaders");
			yield return null;
		}
		TextAsset textAsset = Asset.Load<TextAsset>("Config");
		if (null == textAsset)
		{
			Debug.Log("Can't Load Config");
		}
		using (MemoryStream input = new MemoryStream(textAsset.bytes))
		{
			using BinaryReader binaryReader = new BinaryReader(input);
			ConfigHelper.GetInstance().Initialize(binaryReader);
		}
		Asset.Unload("Config");
		sIsInitConfig = true;
		yield return null;
	}
}
