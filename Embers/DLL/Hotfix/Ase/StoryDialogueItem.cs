using System;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StoryDialogueItem : UGuiView
{
	[SerializeField]
	private GameObject headIconGo;

	[SerializeField]
	private Image headIcon;

	[SerializeField]
	private GameObject nameGo;

	[SerializeField]
	private Text speakerName;

	[SerializeField]
	private GameObject branchOptionTag;

	[SerializeField]
	private Text content;

	[SerializeField]
	private Text branchOptionContent;

	[SerializeField]
	private GameObject voicePart;

	[SerializeField]
	private Button btnPlayVoice;

	[SerializeField]
	private GameObject voicePlaying;

	private StoryDialogue _viewModel;

	private string headIconUrl;

	private bool headIconLoaded;

	public Func<StoryDialogueItem, float> playVoiceFunc;

	public StoryDialogue ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<StoryDialogue>(userData);
		BindingSet<StoryDialogueItem, StoryDialogue> bindingSet = this.CreateBindingSet(_viewModel);
		if (voicePart != null)
		{
			bindingSet.Bind(voicePart).For((GameObject v) => v.activeSelf).ToExpression((StoryDialogue vm) => vm.AudioId > 0);
		}
		if (nameGo != null)
		{
			bindingSet.Bind(nameGo).For((GameObject v) => v.activeSelf).ToExpression((StoryDialogue vm) => !vm.IsAsides && !vm.IsBranchOption);
		}
		if (speakerName != null)
		{
			bindingSet.Bind(speakerName).For((Text v) => v.text).To((StoryDialogue vm) => vm.SpeakerName);
		}
		if (branchOptionTag != null)
		{
			bindingSet.Bind(branchOptionTag).For((GameObject v) => v.activeSelf).To((StoryDialogue vm) => vm.IsBranchOption);
		}
		if (content != null)
		{
			bindingSet.Bind(content).For((Text v) => v.text).To((StoryDialogue vm) => vm.Content);
			bindingSet.Bind(content.gameObject).For((GameObject v) => v.activeSelf).ToExpression((StoryDialogue vm) => !vm.IsBranchOption);
		}
		if (branchOptionContent != null)
		{
			bindingSet.Bind(branchOptionContent).For((Text v) => v.text).To((StoryDialogue vm) => vm.Content);
			bindingSet.Bind(branchOptionContent.gameObject).For((GameObject v) => v.activeSelf).To((StoryDialogue vm) => vm.IsBranchOption);
		}
		bindingSet.Build();
		if (btnPlayVoice != null)
		{
			btnPlayVoice.onClick.AddListener(PlayVoice);
		}
		LoadHeadIcon();
	}

	private void PlayVoice()
	{
		if (!_viewModel.AudioPlaying && _viewModel.AudioId > 0)
		{
			float num = playVoiceFunc?.Invoke(this) ?? (-1f);
			if (num > 0f)
			{
				_viewModel.AudioPlaying = true;
				voicePlaying.SetActive(value: true);
				CancelInvoke("OnVoiceFinished");
				Invoke("OnVoiceFinished", num);
			}
		}
	}

	private void OnVoiceFinished()
	{
		_viewModel.AudioPlaying = false;
		voicePlaying.SetActive(value: false);
	}

	public void ManualFinishVoice()
	{
		CancelInvoke("OnVoiceFinished");
		OnVoiceFinished();
	}

	public void RefreshData(StoryDialogue storyDialogue)
	{
		_viewModel = storyDialogue;
		this.SetDataContext(_viewModel);
		LoadHeadIcon();
	}

	private async void LoadHeadIcon()
	{
		if (!(headIcon == null))
		{
			headIconUrl = _viewModel.HeadIconUrl;
			headIconLoaded = string.IsNullOrEmpty(headIconUrl);
			SetHeadIconVisible(visible: false);
			GetHeadIcon();
		}
	}

	private void GetHeadIcon()
	{
		if (!headIconLoaded && !(headIcon == null))
		{
			headIcon.sprite = _viewModel.HeadIcon(headIconUrl);
			if (headIcon.sprite != null)
			{
				headIconLoaded = true;
				SetHeadIconVisible(visible: true);
			}
		}
	}

	private void SetHeadIconVisible(bool visible)
	{
		if (headIconGo != null)
		{
			headIconGo.SetActive(visible);
		}
		if (headIcon != null)
		{
			headIcon.gameObject.SetActive(visible);
		}
	}

	private void Update()
	{
		GetHeadIcon();
	}

	protected override void OnDestroy()
	{
		CancelInvoke("OnVoiceFinished");
		if (!string.IsNullOrEmpty(headIconUrl))
		{
			headIcon.sprite = null;
			GameEntry.Resource.UnloadAsset(AssetUtility.GetFGImageSprite(headIconUrl));
		}
		_viewModel = null;
		base.OnDestroy();
	}
}
