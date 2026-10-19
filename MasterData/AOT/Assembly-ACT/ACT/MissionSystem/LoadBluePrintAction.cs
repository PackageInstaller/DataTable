using System;
using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.MissionSystem;

public class LoadBluePrintAction : MissionAction
{
	public class RuntimeBluePrintData : IDisposable
	{
		public AssetLoadHandle assetHandle;

		public GameObject bluePrint;

		public void Dispose()
		{
			if (assetHandle.IsValid)
			{
				AssetStationManager.BattleStation.Release(assetHandle);
			}
			if ((bool)bluePrint)
			{
				UnityEngine.Object.Destroy(bluePrint);
			}
		}
	}

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		LoadBluePrintActionParam param = Param as LoadBluePrintActionParam;
		AssetLoadHandle handle = AssetStationManager.BattleStation.Load<GameObject>("Mission_" + param.key);
		await handle;
		if (token.IsCancellationRequested)
		{
			AssetStationManager.BattleStation.Release(handle);
			return;
		}
		GameObject gameObject = handle.As<GameObject>();
		if (gameObject == null)
		{
			if (handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(handle);
			}
			return;
		}
		GameObject gameObject2 = null;
		try
		{
			gameObject2 = UnityEngine.Object.Instantiate(gameObject, Flow.Env.transform);
			gameObject2.GetComponent<ScriptMachine>().enabled = true;
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		try
		{
			Flow.Blackboard.Add("RuntimeBluePrintData:" + param.key, new RuntimeBluePrintData
			{
				assetHandle = handle,
				bluePrint = gameObject2
			});
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
		}
	}
}
