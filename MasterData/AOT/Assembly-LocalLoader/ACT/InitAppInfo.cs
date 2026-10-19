using System.Collections;
using ACT.Error;
using UnityEngine;

namespace ACT;

internal class InitAppInfo : GameLoadingFlowBase
{
	private MonoBehaviour _mono;

	internal override EGameLoadingStage Stage => EGameLoadingStage.ReadAppInfo;

	internal InitAppInfo(MonoBehaviour mono)
	{
		_mono = mono;
	}

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Waiting;
		if (_mono == null)
		{
			Error("InitAppInfo MonoBehaviour为空");
			LuminErrorAOT.ReportGameLoadingError("C01-1101", "01", 0, "读取应用信息失败");
			_loadState = EGameLoadingState.Failed;
		}
		else
		{
			_mono.StartCoroutine(ReadAppInfo());
			_mono.StartCoroutine(ReadAppLogEnableState());
		}
	}

	private IEnumerator ReadAppLogEnableState()
	{
		yield return LuminApplication.LoadDebugLogEnableState();
	}

	private IEnumerator ReadAppInfo()
	{
		yield return LuminApplication.LoadAppInfo();
		_loadState = EGameLoadingState.Succeed;
	}
}
