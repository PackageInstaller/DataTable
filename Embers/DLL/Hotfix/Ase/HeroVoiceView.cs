using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class HeroVoiceView : UGuiView
{
	[SerializeField]
	private TabItem tabTouch;

	[SerializeField]
	private TabItem tabBattle;

	[SerializeField]
	private GameObject voicePlaying;

	[SerializeField]
	private GameObject voiceTextGo;

	[SerializeField]
	private TextMeshProUGUI voiceText;

	[SerializeField]
	private LoopListView2 scrollRect;

	[SerializeField]
	private TextMeshProUGUI cv;

	private HeroVoiceViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<HeroVoiceViewModel>(userData);
		tabTouch.Init(_viewModel.TabDataTouch);
		tabBattle.Init(_viewModel.TabDataBattle);
		BindingSet<HeroVoiceView, HeroVoiceViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(voicePlaying).For((GameObject v) => v.activeSelf).ToExpression((HeroVoiceViewModel vm) => vm.PlayingLeftTime > 0f);
		bindingSet.Bind(voiceTextGo).For((GameObject v) => v.activeSelf).ToExpression((HeroVoiceViewModel vm) => !string.IsNullOrEmpty(vm.VoiceText));
		bindingSet.Bind<TextMeshProUGUI>(voiceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroVoiceViewModel vm) => vm.VoiceText);
		bindingSet.Bind<TextMeshProUGUI>(cv).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroVoiceViewModel vm) => vm.CvText.Replace("\\n", "\n"));
		bindingSet.Bind().For((HeroVoiceView v) => v.RefreshVoiceList).To((HeroVoiceViewModel vm) => vm.OnVoiceDataChanged);
		bindingSet.Build();
		scrollRect.InitListView(_viewModel.VoiceDatas.Count, OnGetItemByIndex);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.VoiceDatas.Count)
		{
			return null;
		}
		KeyValuePair<DRVoice, bool> keyValuePair = _viewModel.VoiceDatas[index];
		if (keyValuePair.Key == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollRect.NewListViewItem("HeroVoiceItem");
		HeroVoiceItemData heroVoiceItemData = new HeroVoiceItemData(_viewModel, keyValuePair.Key, keyValuePair.Value);
		HeroVoiceItem component = loopListViewItem.GetComponent<HeroVoiceItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(heroVoiceItemData);
		}
		else
		{
			component.SetDataContext(heroVoiceItemData);
		}
		return loopListViewItem;
	}

	private void RefreshVoiceList(object sender, InteractionEventArgs e)
	{
		scrollRect.SetListItemCount(_viewModel.VoiceDatas.Count);
		scrollRect.RefreshAllShownItem();
		RectTransform content = scrollRect.ScrollRect.content;
		content.anchoredPosition = new Vector2(content.anchoredPosition.x, 0f);
	}

	protected override void OnDisable()
	{
		_viewModel.StopVoice();
		base.OnDisable();
	}

	private void Update()
	{
		if (!(_viewModel.PlayingLeftTime <= 0f))
		{
			_viewModel.PlayingLeftTime -= Time.deltaTime;
		}
	}
}
