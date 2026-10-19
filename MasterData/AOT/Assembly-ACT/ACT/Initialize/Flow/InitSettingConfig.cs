using System.Linq;
using ACT.Error;
using ACT.Net;
using ACT.Rendering;
using ACT.UI;

namespace ACT.Initialize.Flow;

public class InitSettingConfig : RuntimeLoadFlow
{
	public InitSettingConfig()
		: base("InitSettingConfig")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		WaitInitializer.Start(1L);
		RuntimeLoadFlow runtimeLoadFlow = LuminRuntimeInitializer.RunningFlows.FirstOrDefault((RuntimeLoadFlow x) => x is InitSound) ?? throw new LuminErrorException(CodeType.CLIENT, CodeModule.INITIALIZE_RUNTIME_LOGIC, 1, null, "系统提示", "游戏设置初始化异常");
		SettingsManager settingsManager = LuminRuntimeInitializer.GameLoader.GetComponent<SettingsManager>();
		RuntimeLoadFlow runtimeLoadFlow2 = ((settingsManager?.SettingsProviderAsset?.ShouldInitializeFromDeviceGrade == true) ? LuminRuntimeInitializer.RunningFlows.FirstOrDefault((RuntimeLoadFlow x) => x is InitDeviceGrade) : null);
		bool soundReady = false;
		bool deviceGradeReady = runtimeLoadFlow2 == null;
		bool initialized = false;
		runtimeLoadFlow.OnFlowComplete += () =>
		{
			soundReady = true;
			TryInitializeSettings();
		};
		if (runtimeLoadFlow2 != null)
		{
			runtimeLoadFlow2.OnFlowComplete += () =>
			{
				deviceGradeReady = true;
				TryInitializeSettings();
			};
		}
		void TryInitializeSettings()
		{
			if (!initialized && soundReady && deviceGradeReady)
			{
				initialized = true;
				LocalQualitySettings.ReadFromLocal();
				settingsManager?.Initialize();
				GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
				WaitInitializer.CompleteOne();
			}
		}
	}
}
