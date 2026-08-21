using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class KillRewardPropWindow : UGuiWindow
{
	[SerializeField]
	private KillRewardItem rewardPrefab;

	[SerializeField]
	private GameObject killMonsterShow;

	[SerializeField]
	private Animation killBossAni;

	[SerializeField]
	private GameObject blackMask;

	[SerializeField]
	private Transform taskRewardRoot;

	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Image headIcon1;

	[SerializeField]
	private Image headIcon2;

	private KillRewardViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<KillRewardViewModel>();
		BindingSet<KillRewardPropWindow, KillRewardViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((KillRewardPropWindow v) => v.OpenUguiWindow).To((KillRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((KillRewardPropWindow v) => v.OnDismissRequest).To((KillRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		ShowContent();
	}

	private async void ShowContent()
	{
		await SetBossIcon();
		ShowTitleType();
		ShowReward();
		DelayClickClose();
	}

	private void ShowTitleType()
	{
		killMonsterShow.SetActive(_viewModel.KillRewardType == KillRewardType.KillMonster);
		((Component)(object)killBossAni).gameObject.SetActive(_viewModel.KillRewardType == KillRewardType.KillBoss);
	}

	private void ShowReward()
	{
		blackMask.SetActive(_viewModel.RewardList.Count > 0);
		List<KnapsackItemViewModel> rewardList = _viewModel.RewardList;
		for (int i = 0; i < rewardList.Count; i++)
		{
			KillRewardItem killRewardItem = Object.Instantiate(rewardPrefab, taskRewardRoot, worldPositionStays: true);
			killRewardItem.Init(rewardList[i]);
			killRewardItem.gameObject.SetActive(value: true);
		}
	}

	private async UniTask SetBossIcon()
	{
		if (_viewModel.KillRewardType == KillRewardType.KillBoss && _viewModel != null && !string.IsNullOrEmpty(_viewModel.MonsterIcon))
		{
			Sprite sprite = await LoadSpriteAsync(SkinAssetUtility.GetBossIcon(_viewModel.MonsterIcon));
			if (!(sprite == null))
			{
				headIcon1.sprite = sprite;
				headIcon2.sprite = sprite;
			}
		}
	}

	private async void DelayClickClose()
	{
		if (!(closeBtn == null))
		{
			closeBtn.onClick.AddListener(CloseUI);
			closeBtn.interactable = false;
			await UniTask.WaitForSeconds(1);
			if (!(this == null))
			{
				closeBtn.interactable = true;
			}
		}
	}

	private void CloseUI()
	{
		closeBtn.interactable = false;
		float delay = 0f;
		if (_viewModel.KillRewardType == KillRewardType.KillBoss)
		{
			delay = 1f;
			killBossAni.Play("Root3_out");
		}
		DOTweenModuleUI.DOFade(CanvasGroup, 0f, 0.2f).SetDelay(delay).OnComplete(delegate
		{
			_viewModel.ItemOnClick(_viewModel);
		});
	}
}
