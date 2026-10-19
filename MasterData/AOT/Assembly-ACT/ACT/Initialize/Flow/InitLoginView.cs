using System;
using ACT.Battle;
using ACT.Game;
using ACT.Local;
using ACT.LocalLoader;
using ACT.UI;
using Fundamental;
using UnityEngine;
using bamboosdk;

namespace ACT.Initialize.Flow;

public class InitLoginView : RuntimeLoadFlow
{
	private MonoHotUpdate _monoHotUpdate;

	public override int Weight => 0;

	public InitLoginView()
		: base("InitLoginView")
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		Singleton<NewUIManager>.instance.UidTxt.gameObject.SetActive(value: false);
		_monoHotUpdate = UnityEngine.Object.FindFirstObjectByType<MonoHotUpdate>();
		if ((bool)_monoHotUpdate)
		{
			_monoHotUpdate.SetProgressBarActive(active: true);
			_monoHotUpdate.progress.value = 0f;
			_monoHotUpdate.progressText.SetText("初始化数据中...");
			_monoHotUpdate.progressNum.SetText(string.Empty);
			LuminRuntimeInitializer.WaitInstruction.onUpdate -= UpdateSliderValue;
			LuminRuntimeInitializer.WaitInstruction.onUpdate += UpdateSliderValue;
			UpdateSliderValue();
		}
		WaitInitializer.Start(LuminRuntimeInitializer.RunningFlows.Count - 1);
		OnFlowComplete += CoModeSelection;
		foreach (RuntimeLoadFlow runningFlow in LuminRuntimeInitializer.RunningFlows)
		{
			if (runningFlow != this)
			{
				runningFlow.OnFlowComplete += () =>
				{
					WaitInitializer.CompleteOne();
				};
			}
		}
	}

	private void UpdateSliderValue()
	{
		if (!(_monoHotUpdate == null))
		{
			float percent = LuminRuntimeInitializer.WaitInstruction.Percent;
			_monoHotUpdate.progress.value = percent;
			_monoHotUpdate.percentText.text = MonoHotUpdate.ToPercentage(percent, 0);
		}
	}

	private void CoModeSelection()
	{
		LuminRuntimeInitializer.WaitInstruction.onUpdate -= UpdateSliderValue;
		if ((bool)_monoHotUpdate)
		{
			_monoHotUpdate.SetProgressBarActive(active: false);
		}
		Singleton<NewUIManager>.instance.UidTxt.gameObject.SetActive(value: false);
		switch (LuminRuntimeInitializer.GameLoader.mode)
		{
		case GameLoader.GameMode.ConfigSave:
			G.service = new LocalGameService();
			throw new NotImplementedException("ConfigSave模式无法在非编辑器模式下运行");
		case GameLoader.GameMode.Local:
			G.service = new LocalGameService();
			(G.service as LocalGameService).LoadGame();
			GameStartWithOutUI();
			break;
		case GameLoader.GameMode.Network:
		case GameLoader.GameMode.Selection:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LOGINWAITCLICK, true).GetAwaiter().OnCompleted(ReportInitComplete);
			break;
		}
	}

	private void ReportInitComplete()
	{
	}

	private void GameStartWithOutUI()
	{
		ReportInitComplete();
		MonoECS.instance.StartWorld();
		if (LuminRuntimeInitializer.GameLoader.mode == GameLoader.GameMode.Network)
		{
			BamBooSdk.getInstance().enterGame(LoginUtility.RoleInfo);
		}
	}
}
