using ACT.Error;

namespace ACT;

internal class InitAPM : GameLoadingFlowBase
{
	private bool _debugMode;

	private GameLoadingData _data;

	internal override EGameLoadingStage Stage => EGameLoadingStage.InitAPM;

	internal InitAPM(bool debugMode)
	{
		_debugMode = debugMode;
	}

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Waiting;
		_data = data;
		LuminApplication.APM.Init(_debugMode, OnGPMInit);
	}

	private void OnGPMInit(bool success)
	{
		_data.ApmInitSuccess = true;
		if (!success)
		{
			Warning("APM初始化失败");
			LuminErrorAOT.ReportGameLoadingError("C01-1001", "01", 1, "APM性能监控初始化失败", retry: false, null, showDialog: false);
		}
		_loadState = EGameLoadingState.Succeed;
	}
}
