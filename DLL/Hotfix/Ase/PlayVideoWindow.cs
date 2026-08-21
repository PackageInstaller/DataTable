using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class PlayVideoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private VideoPlayer videoPlayer;

	private PlayVideoViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		videoPlayer.targetTexture.Release();
		base.OnCreate(bundle);
		_viewModel = GetData<PlayVideoViewModel>();
		BindingSet<PlayVideoWindow, PlayVideoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((PlayVideoWindow v) => v.OnDismissRequest).To((PlayVideoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((PlayVideoWindow v) => v.OpenUguiWindow).To((PlayVideoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<VideoPlayer>(videoPlayer).For((Expression<Func<VideoPlayer, string>>)((VideoPlayer v) => v.url)).To((PlayVideoViewModel vm) => vm.Url);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PlayVideoViewModel vm) => vm.Close);
		bindingSet.Build();
	}
}
