using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LotteryActItem : UGuiView
{
	public int index;

	[SerializeField]
	private Button button;

	[SerializeField]
	private Image rewardIcon;

	[SerializeField]
	private GameObject skinIcon;

	[SerializeField]
	private TextMeshProUGUI rewardCountText;

	[SerializeField]
	private GameObject overlayMask;

	[SerializeField]
	private GameObject midMask;

	[SerializeField]
	private Animation lotteryAni;

	[SerializeField]
	private GameObject startEffect;

	[SerializeField]
	private GameObject finishEffect;

	private LotteryActItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<LotteryActItemData>(userData);
		BindingSet<LotteryActItem, LotteryActItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((LotteryActItemData vm) => vm.OnItemClick);
		bindingSet.Bind(rewardIcon).For((Image v) => v.sprite).To((LotteryActItemData vm) => vm.RewardIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rewardIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((LotteryActItemData vm) => !vm.ShowSpIcon && !string.IsNullOrEmpty(vm.RewardIcon));
		bindingSet.Bind(skinIcon).For((GameObject v) => v.activeSelf).To((LotteryActItemData vm) => vm.ShowSpIcon);
		bindingSet.Bind<TextMeshProUGUI>(rewardCountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActItemData vm) => vm.RewardCountText);
		bindingSet.Bind(overlayMask).For((GameObject v) => v.activeSelf).To((LotteryActItemData vm) => vm.ShowOverlayMask);
		bindingSet.Bind(midMask).For((GameObject v) => v.activeSelf).To((LotteryActItemData vm) => vm.ShowMidMask);
		bindingSet.Bind().For((LotteryActItem v) => v.PlayLotteryAni).To((LotteryActItemData vm) => vm.PlayLotteryAniRst);
		bindingSet.Bind(startEffect).For((GameObject v) => v.activeSelf).ToExpression((LotteryActItemData vm) => !vm.Finished);
		bindingSet.Bind(finishEffect).For((GameObject v) => v.activeSelf).To((LotteryActItemData vm) => vm.Finished);
		bindingSet.Build();
	}

	private void PlayLotteryAni(object sender, InteractionEventArgs e)
	{
		Action callback = (Action)e.Context;
		PlayAni(callback);
	}

	private async UniTask PlayAni(Action callback)
	{
		float length = lotteryAni.clip.length;
		_viewModel.UpdateWindowMaskTime(length);
		lotteryAni.Play();
		await UniTask.WaitForSeconds(length);
		callback?.Invoke();
	}
}
