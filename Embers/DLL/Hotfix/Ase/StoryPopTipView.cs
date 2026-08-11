using System;
using System.Linq.Expressions;
using System.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StoryPopTipView : UGuiView
{
	public Image headIcon;

	public TextMeshProUGUI tipText;

	public TextMeshProUGUI nameText;

	public AlphaAnimation alphaAnimation;

	private string headIconUrl;

	private StoryPopTipViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<StoryPopTipViewModel>(userData);
		BindingSet<StoryPopTipView, StoryPopTipViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((StoryPopTipView v) => v.headIconUrl).To((StoryPopTipViewModel vm) => vm.HeadIconName);
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StoryPopTipViewModel vm) => vm.TipText);
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, int>>)((TextMeshProUGUI v) => ((TMP_Text)v).maxVisibleCharacters)).To((StoryPopTipViewModel vm) => vm.MaxVisibleCharacters);
		if ((bool)(UnityEngine.Object)(object)nameText)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StoryPopTipViewModel vm) => vm.NameText);
		}
		bindingSet.Bind(alphaAnimation).For((AlphaAnimation v) => v.duration).To((StoryPopTipViewModel vm) => vm.ExitDuration);
		bindingSet.Bind().For((StoryPopTipView v) => v.OnPopupTipShow).To((StoryPopTipViewModel vm) => vm.OnPopupTipShow);
		bindingSet.Bind().For((StoryPopTipView v) => v.OnPopupTipHide).To((StoryPopTipViewModel vm) => vm.OnPopupTipHide);
		bindingSet.Bind().For((StoryPopTipView v) => v.OnPopupTipRest).To((StoryPopTipViewModel vm) => vm.OnPopupTipRest);
		bindingSet.Build();
		viewModel.SetBind(tipText);
		Alpha = 0f;
	}

	private async Task LoadHeadIcon()
	{
		if (headIcon == null)
		{
			return;
		}
		if (string.IsNullOrEmpty(headIconUrl))
		{
			headIcon.gameObject.SetActive(value: false);
			return;
		}
		Image image = headIcon;
		image.sprite = await LoadSpriteAsync(AssetUtility.GetFGImageSprite(headIconUrl));
		if (headIcon.sprite == null)
		{
			headIcon.gameObject.SetActive(value: false);
			return;
		}
		headIcon.gameObject.SetActive(value: true);
		headIcon.SetNativeSize();
	}

	private void OnPopupTipRest(object sender, InteractionEventArgs e)
	{
		Alpha = 0f;
		StopAllCoroutines();
	}

	private async void OnPopupTipShow(object sender, InteractionEventArgs args)
	{
		await LoadHeadIcon();
		Alpha = 1f;
	}

	private void OnPopupTipHide(object sender, InteractionEventArgs e)
	{
		ExitAnimation.Play();
	}
}
