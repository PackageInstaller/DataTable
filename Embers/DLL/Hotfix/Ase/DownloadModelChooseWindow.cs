using Cysharp.Text;
using GameFramework.Runtime;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class DownloadModelChooseWindow : UGuiWindow
{
	public TextMeshProUGUI downloadTip_1;

	public TextMeshProUGUI downloadTip_2;

	public Toggle downloadModelChooseToggle_1;

	public Toggle downloadModelChooseToggle_2;

	public Button confirmButton;

	public ToggleGroup toggleGroup;

	private DownloadModelChooseViewModel viewModel;

	public static IAsyncResult<int> Show(long downloadSize, string uiGroup = "DEFAULT")
	{
		DownloadModelChooseViewModel downloadModelChooseViewModel = new DownloadModelChooseViewModel
		{
			DownloadSize = downloadSize,
			Result = 0
		};
		GameEntry.UI.OpenWindow<DownloadModelChooseWindow>("User/DownloadModelChooseWindow", uiGroup, downloadModelChooseViewModel);
		TDAHandler.Instance.ResourceDownloadReport("resource_download_pop", FileSizeUtility.ToMb(downloadSize), "pop", 0.0, 0.0);
		return downloadModelChooseViewModel.OnComfirm;
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DownloadModelChooseViewModel>();
		((TMP_Text)(object)downloadTip_1).SetTextFormat("优先进入游戏，后台下载后续资源({0}MB)", FileSizeUtility.ToMb(viewModel.DownloadSize));
		((TMP_Text)(object)downloadTip_2).SetTextFormat("立即下载后续资源({0}MB)", FileSizeUtility.ToMb(viewModel.DownloadSize));
		if (toggleGroup != null)
		{
			downloadModelChooseToggle_1.group = toggleGroup;
			downloadModelChooseToggle_2.group = toggleGroup;
		}
		if (!downloadModelChooseToggle_1.isOn && !downloadModelChooseToggle_2.isOn)
		{
			downloadModelChooseToggle_1.isOn = true;
			viewModel.Result = 0;
		}
		downloadModelChooseToggle_1.onValueChanged.AddListener(delegate(bool isOn)
		{
			if (isOn)
			{
				viewModel.Result = 0;
			}
		});
		downloadModelChooseToggle_2.onValueChanged.AddListener(delegate(bool isOn)
		{
			if (isOn)
			{
				viewModel.Result = 1;
			}
		});
		confirmButton.onClick.AddListener(delegate
		{
			viewModel.Comfirm();
			Close();
		});
	}
}
