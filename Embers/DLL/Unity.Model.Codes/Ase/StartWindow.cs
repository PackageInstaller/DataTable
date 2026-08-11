using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class StartWindow : UGuiWindow
{
	[SerializeField]
	private VariableArray variables;

	[SerializeField]
	private VideoPlayer videoPlayer;

	[SerializeField]
	private RawImage videoDisplay;

	private RenderTexture renderTexture;

	private Vector2 videoSize;

	private StartViewModel viewModel;

	protected override void OnInit()
	{
		viewModel = new StartViewModel(GameEntry.LaunchType);
		BindingSet<StartWindow, StartViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((StartWindow v) => v.OnDismissRequest).To((StartViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(variables.Get<GameObject>("loadingRoot")).For((GameObject v) => v.activeSelf).To((StartViewModel vm) => vm.IsLoading);
		bindingSet.Bind<TextMeshProUGUI>(variables.Get<TextMeshProUGUI>("versionInfo")).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StartViewModel vm) => vm.VersionInfo);
		bindingSet.Bind(variables.Get<GameObject>("progressRoot")).For((GameObject v) => v.activeSelf).To((StartViewModel vm) => vm.ProgressBar.Enable);
		bindingSet.Bind(variables.Get<GameObject>("downloadRoot")).For((GameObject v) => v.activeSelf).To((StartViewModel vm) => vm.ProgressBar.EnableDownload);
		bindingSet.Bind(variables.Get<Image>("loadingBar")).For((Image v) => v.fillAmount).To((StartViewModel vm) => vm.ProgressBar.Progress);
		bindingSet.Bind<TextMeshProUGUI>(variables.Get<TextMeshProUGUI>("loadingTip")).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StartViewModel vm) => vm.ProgressBar.Tip);
		bindingSet.Bind<TextMeshProUGUI>(variables.Get<TextMeshProUGUI>("loadingProgress")).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((StartViewModel vm) => $"{FileSizeUtility.ToMb(vm.ProgressBar.CurrentDownloadBytes)}/{FileSizeUtility.ToMb(vm.ProgressBar.TotalDownloadBytes)} MB");
		bindingSet.Bind(variables.Get<Button>("repairButton")).For((Button v) => v.onClick).To((StartViewModel vm) => vm.RepairCmd);
		bindingSet.Build();
		videoSize = new Vector2(videoPlayer.clip.width, videoPlayer.clip.height);
		renderTexture = new RenderTexture((int)videoSize.x, (int)videoSize.y, 24);
		videoPlayer.targetTexture = renderTexture;
		videoDisplay.texture = renderTexture;
		AdaptAspectRatio();
	}

	protected override async void OnShow()
	{
		await UniTask.WaitUntil(() => ((Component)(object)videoPlayer).gameObject.activeSelf);
		videoPlayer.Prepare();
		await UniTask.WaitUntil(() => videoPlayer.isPrepared);
		videoPlayer.Play();
		viewModel.Start();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		renderTexture.Release();
		renderTexture = null;
	}

	private void AdaptAspectRatio()
	{
		float num = (float)Screen.width / (float)Screen.height;
		float num2 = videoSize.x / videoSize.y;
		if (num > num2)
		{
			float y = num / num2;
			float x = 1f;
			videoDisplay.rectTransform.localScale = new Vector3(x, y, 1f);
		}
		else
		{
			float x2 = num2 / num;
			float y2 = 1f;
			videoDisplay.rectTransform.localScale = new Vector3(x2, y2, 1f);
		}
	}
}
