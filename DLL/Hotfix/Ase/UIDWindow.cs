using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UIDWindow : UGuiWindowBase
{
	public TextMeshProUGUI uid;

	private UIDViewModel viewModel;

	[SerializeField]
	private GameObject resDownloader;

	[SerializeField]
	private TextMeshProUGUI resDownloaderText;

	[SerializeField]
	private Vector2 downloadRootPosition_outer;

	[SerializeField]
	private Vector2 downloadRootPosition_level;

	[SerializeField]
	private string dowloadTipStringFormat;

	private RectTransform resDownloaderRect;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<UIDViewModel>();
		BindingSet<UIDWindow, UIDViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((UIDWindow v) => v.OnDismissRequest).To((UIDViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(uid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((UIDViewModel vm) => $"UID:{vm.UID}");
		bindingSet.Build();
		resDownloaderRect = resDownloader.GetComponent<RectTransform>();
		if (Singleton<SubrequestResHelper>.Instance != null)
		{
			((Graphic)(object)resDownloaderText).raycastTarget = false;
			resDownloader.GetOrAddComponent<Button>().onClick.AddListener(delegate
			{
				if (Singleton<SubrequestResHelper>.Instance.IsProcessing())
				{
					Singleton<SubrequestResHelper>.Instance.PauseDownload();
				}
				else
				{
					Singleton<SubrequestResHelper>.Instance.ResumeDownload();
				}
			});
		}
		else
		{
			resDownloader.SetActive(value: false);
		}
	}

	private void Update()
	{
		if (Singleton<SubrequestResHelper>.Instance == null)
		{
			return;
		}
		if (Singleton<SubrequestResHelper>.Instance.GetCurrentStatus() == SubrequestResHelper.DownloadStatus.Downloading || Singleton<SubrequestResHelper>.Instance.GetCurrentStatus() == SubrequestResHelper.DownloadStatus.Paused || Singleton<SubrequestResHelper>.Instance.GetCurrentStatus() == SubrequestResHelper.DownloadStatus.Idle)
		{
			if (Singleton<SubrequestResHelper>.Instance.GetCurDownloadGameProcess() == GameProcessType.Outer)
			{
				resDownloaderRect.anchoredPosition = downloadRootPosition_outer;
			}
			if (Singleton<SubrequestResHelper>.Instance.GetCurDownloadGameProcess() == GameProcessType.Story)
			{
				resDownloaderRect.anchoredPosition = downloadRootPosition_level;
			}
			if (Singleton<SubrequestResHelper>.Instance.GetCurDownloadGameProcess() == GameProcessType.Battle)
			{
				resDownloaderRect.anchoredPosition = Vector2.left * 1000f;
			}
			((TMP_Text)resDownloaderText).SetText(Singleton<SubrequestResHelper>.Instance.GetDownloadStatusInfo(dowloadTipStringFormat), true);
		}
		else
		{
			resDownloader.SetActive(value: false);
		}
	}
}
