using FMOD.Studio;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StoryDialogueView : UIView
{
	[SerializeField]
	private float itemHeight;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private LoopGridView loopList;

	[SerializeField]
	private GameObject arrowUp;

	[SerializeField]
	private GameObject arrowDown;

	private StoryDialogueViewModel _viewModel;

	private RectTransform content;

	private float viewPortHeight;

	private float contentYShowUpArrow;

	private float contentYShowDownArrow;

	private VoiceGroup _voiceGroup;

	private StoryDialogueItem curItem;

	public void Init(StoryDialogueViewModel viewModel)
	{
		_viewModel = viewModel;
		_voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.StoryDialogue);
		this.CreateBindingSet(_viewModel).Build();
		btnClose.onClick.AddListener(delegate
		{
			CanvasGroup.blocksRaycasts = false;
			CanvasGroup.alpha = 0f;
		});
		InitLoopList();
	}

	public void Refresh()
	{
		loopList.SetListItemCount(_viewModel.StoryDialogues.Count);
		loopList.RefreshAllShownItem();
		loopList.MovePanelToItemByIndex(_viewModel.StoryDialogues.Count);
		loopList.FinishSnapImmediately();
	}

	private async void InitLoopList()
	{
		loopList.InitGridView(_viewModel.StoryDialogues.Count, OnGetItemByIndex);
		loopList.MovePanelToItemByIndex(_viewModel.StoryDialogues.Count);
		loopList.FinishSnapImmediately();
		viewPortHeight = loopList.ViewPortHeight;
		content = loopList.ScrollRect.content;
	}

	private void Update()
	{
		if (!(content == null))
		{
			arrowUp.SetActive(content.anchoredPosition.y > itemHeight * 4f / 5f);
			arrowDown.SetActive(content.anchoredPosition.y < content.sizeDelta.y - viewPortHeight - itemHeight * 4f / 5f);
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		StoryDialogue storyDialogue = _viewModel.StoryDialogues[index];
		if (storyDialogue == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = (storyDialogue.IsAsides ? loopList.NewListViewItem("AsidesItem") : ((!storyDialogue.SaidByPlayer) ? loopList.NewListViewItem("DialogueItem") : loopList.NewListViewItem("PlayerDialogueItem")));
		StoryDialogueItem component = loopGridViewItem.GetComponent<StoryDialogueItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(storyDialogue);
		}
		else
		{
			component.RefreshData(storyDialogue);
		}
		component.playVoiceFunc = PlayVoice;
		return loopGridViewItem;
	}

	private float PlayVoice(StoryDialogueItem item)
	{
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		if (item == null || item.ViewModel == null)
		{
			return -1f;
		}
		if (GameEntry.DataTable.GetDataRow<DRAudio>(item.ViewModel.AudioId) == null)
		{
			return -1f;
		}
		_voiceGroup.Stop();
		if (curItem != null && curItem.ViewModel.AudioPlaying)
		{
			curItem.ManualFinishVoice();
		}
		curItem = item;
		_voiceGroup.Play(item.ViewModel.AudioId);
		EventInstance curVoice = _voiceGroup.GetCurVoice();
		EventDescription val = default(EventDescription);
		((EventInstance)(ref curVoice)).getDescription(ref val);
		int num = default(int);
		((EventDescription)(ref val)).getLength(ref num);
		return (float)num / 1000f;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		_viewModel = null;
	}
}
