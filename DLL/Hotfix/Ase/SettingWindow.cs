using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SettingWindow : UGuiWindow
{
	public Button closeBtn;

	public Button lowResolution;

	public Button heightResolution;

	public List<Button> levelBtns;

	private SettingViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<SettingViewModel>();
		closeBtn.onClick.AddListener(DoDismiss);
		lowResolution.onClick.AddListener(delegate
		{
			ChangeResolution(useHeight: false);
		});
		heightResolution.onClick.AddListener(delegate
		{
			ChangeResolution(useHeight: true);
		});
		int num = 0;
		foreach (Button levelBtn in levelBtns)
		{
			_ = levelBtn;
			ChangeQuality(num);
			num++;
		}
	}

	private void ChangeQuality(int level)
	{
		QualitySettings.SetQualityLevel(level, applyExpensiveChanges: true);
	}

	private void ChangeResolution(bool useHeight)
	{
		if (useHeight)
		{
			Screen.SetResolution(2240, 1008, fullscreen: false);
		}
		else
		{
			Screen.SetResolution(1600, 720, fullscreen: false);
		}
	}
}
