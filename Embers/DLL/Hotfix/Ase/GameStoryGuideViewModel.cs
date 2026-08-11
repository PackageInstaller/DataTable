using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GameStoryGuideViewModel : OptionBase
{
	private List<TabItemNormalData> chapterDataList;

	private List<TabItemNormalData> storyTypeList;

	private TabItemNormalData btnSwitch;

	private TabItemNormalData curChapterTab;

	private TabItemNormalData curStoryTypeTab;

	private Dictionary<int, List<GameStoryGuideItemData>> originalTimeLineDataDic;

	private Dictionary<int, List<GameStoryGuideItemData>> originalPhotoDataDic;

	private List<GameStoryGuideItemData> showTimeLineDataList;

	private List<GameStoryGuideItemData> showPhotoDataList;

	private InteractionRequest refreshDataRequest;

	private bool isEmpty;

	public TabItemNormalData BtnSwitch => btnSwitch;

	public List<TabItemNormalData> ChapterDataList => chapterDataList;

	public List<TabItemNormalData> StoryTypeList => storyTypeList;

	public InteractionRequest RefreshDataRequest => refreshDataRequest;

	public List<GameStoryGuideItemData> ShowTimeLineDataList
	{
		get
		{
			return showTimeLineDataList;
		}
		private set
		{
			Set(ref showTimeLineDataList, value, "ShowTimeLineDataList");
		}
	}

	public List<GameStoryGuideItemData> ShowPhotoDataList
	{
		get
		{
			return showPhotoDataList;
		}
		private set
		{
			Set(ref showPhotoDataList, value, "ShowPhotoDataList");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		private set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public GameStoryGuideViewModel(OptionBase parent, List<GameStoryGuideItemData> originalTimeLineDataList, List<GameStoryGuideItemData> originalPhotoDataList, List<TabItemNormalData> storyTabDataList)
	{
		base.parent = parent;
		btnSwitch = new TabItemNormalData(this, "empty");
		showTimeLineDataList = new List<GameStoryGuideItemData>();
		showPhotoDataList = new List<GameStoryGuideItemData>();
		refreshDataRequest = new InteractionRequest();
		chapterDataList = new List<TabItemNormalData>();
		storyTypeList = storyTabDataList;
		foreach (TabItemNormalData storyType in storyTypeList)
		{
			storyType.SetParent(this);
			storyType.IsSelected = false;
		}
		HandleData(originalTimeLineDataList, originalPhotoDataList);
		SwitchStoryType(storyTypeList[0]);
		CheckRedPoint();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GameStoryGuideItemData gameStoryGuideItemData)
			{
				if (!"Open".Equals(optionArg.OptionName))
				{
					return;
				}
				if (btnSwitch.IsSelected)
				{
					OpenPhoto(gameStoryGuideItemData);
				}
				else
				{
					PlayStory(gameStoryGuideItemData);
				}
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			if ("Chapter".Equals(tabItemNormalData.MarkName))
			{
				ClearRedPoint();
				SwitchChapter(tabItemNormalData);
				CheckSwitchBtnRedPoint();
			}
			else if ("StoryType".Equals(tabItemNormalData.MarkName))
			{
				ClearRedPoint();
				SwitchStoryType(tabItemNormalData);
			}
			else
			{
				btnSwitch.IsSelected = !btnSwitch.IsSelected;
				CheckSwitchBtnRedPoint();
			}
		}
		CheckRedPoint();
	}

	private void HandleData(List<GameStoryGuideItemData> originalTimeLineDataList, List<GameStoryGuideItemData> originalPhotoDataList)
	{
		originalTimeLineDataDic = new Dictionary<int, List<GameStoryGuideItemData>>();
		originalPhotoDataDic = new Dictionary<int, List<GameStoryGuideItemData>>();
		foreach (GameStoryGuideItemData originalTimeLineData in originalTimeLineDataList)
		{
			originalTimeLineData.SetParent(this);
			if (!originalTimeLineDataDic.ContainsKey(originalTimeLineData.Chapter))
			{
				List<GameStoryGuideItemData> list = new List<GameStoryGuideItemData>();
				list.Add(originalTimeLineData);
				originalTimeLineDataDic.Add(originalTimeLineData.Chapter, list);
			}
			else
			{
				originalTimeLineDataDic[originalTimeLineData.Chapter].Add(originalTimeLineData);
			}
		}
		foreach (GameStoryGuideItemData originalPhotoData in originalPhotoDataList)
		{
			originalPhotoData.SetParent(this);
			if (!originalPhotoDataDic.ContainsKey(originalPhotoData.Chapter))
			{
				List<GameStoryGuideItemData> list2 = new List<GameStoryGuideItemData>();
				list2.Add(originalPhotoData);
				originalPhotoDataDic.Add(originalPhotoData.Chapter, list2);
			}
			else
			{
				originalPhotoDataDic[originalPhotoData.Chapter].Add(originalPhotoData);
			}
		}
	}

	private void ReSetChapter()
	{
		chapterDataList.Clear();
		List<int> chapterId = new List<int>();
		foreach (KeyValuePair<int, List<GameStoryGuideItemData>> item in originalTimeLineDataDic)
		{
			if (item.Value.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID).Count > 0)
			{
				chapterId.Add(item.Key);
			}
		}
		chapterId.Sort();
		for (int num = 0; num < chapterId.Count; num++)
		{
			int i1 = num;
			DRGameGuideView dataRow = GameEntry.DataTable.GetDataRow((DRGameGuideView p) => p.Type == 1 && p.SubType == 2 && p.MarkId == chapterId[i1]);
			if (dataRow != null)
			{
				TabItemNormalData tabItemNormalData = new TabItemNormalData(dataRow.Name, dataRow.MarkId, this);
				tabItemNormalData.MarkName = "Chapter";
				tabItemNormalData.SetCanOnClick(value: true);
				chapterDataList.Add(tabItemNormalData);
			}
		}
	}

	private void OpenPhoto(GameStoryGuideItemData gameStoryGuideItemData)
	{
		int index = 1;
		for (int i = 0; i < ShowPhotoDataList.Count; i++)
		{
			if (ShowPhotoDataList[i].ID == gameStoryGuideItemData.ID)
			{
				index = i + 1;
				break;
			}
		}
		GameStoryCGViewModel userData = new GameStoryCGViewModel(this, index, ShowPhotoDataList, gameStoryGuideItemData);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameStoryCGWindow), userData));
	}

	private async void PlayStory(GameStoryGuideItemData gameStoryGuideItemData)
	{
		await Singleton<Story>.Instance.PlayStory(0u, gameStoryGuideItemData.ID);
	}

	private void SwitchChapter(TabItemNormalData tab)
	{
		if (tab == null)
		{
			return;
		}
		curChapterTab?.SetSelected(value: false);
		curChapterTab = tab;
		curChapterTab.SetSelected(value: true);
		ShowTimeLineDataList.Clear();
		if (originalTimeLineDataDic.TryGetValue(tab.ID, out var value))
		{
			ShowTimeLineDataList = value.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
		}
		bool flag = true;
		foreach (GameStoryGuideItemData showTimeLineData in ShowTimeLineDataList)
		{
			showTimeLineData.UpDown = flag;
			flag = !flag;
		}
		ShowPhotoDataList.Clear();
		if (originalPhotoDataDic.TryGetValue(tab.ID, out var value2))
		{
			ShowPhotoDataList = value2.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
		}
		IsEmpty = ShowTimeLineDataList.Count == 0;
		refreshDataRequest.Raise();
	}

	private void SwitchStoryType(TabItemNormalData tab)
	{
		curStoryTypeTab?.SetSelected(value: false);
		curStoryTypeTab = tab;
		curStoryTypeTab.SetSelected(value: true);
		ReSetChapter();
		if (ChapterDataList.Count > 0)
		{
			SwitchChapter(ChapterDataList[0]);
		}
		else
		{
			IsEmpty = true;
		}
		if (!IsEmpty)
		{
			refreshDataRequest.Raise();
		}
		CheckSwitchBtnRedPoint();
	}

	private void ClearRedPoint()
	{
		if (btnSwitch.IsSelected)
		{
			foreach (GameStoryGuideItemData showPhotoData in ShowPhotoDataList)
			{
				showPhotoData.SetRedPoint();
			}
		}
		else
		{
			foreach (GameStoryGuideItemData showTimeLineData in ShowTimeLineDataList)
			{
				showTimeLineData.SetRedPoint();
			}
		}
		if (curChapterTab != null)
		{
			curChapterTab.RedPoint = false;
		}
	}

	private void CheckRedPoint()
	{
		foreach (TabItemNormalData chapterData in ChapterDataList)
		{
			CheckChapterRedPoint(chapterData);
		}
		CheckStoryRedPoint();
	}

	private void CheckSwitchBtnRedPoint()
	{
		if (curChapterTab == null)
		{
			BtnSwitch.RedPoint = false;
			return;
		}
		if (BtnSwitch.IsSelected)
		{
			originalTimeLineDataDic.TryGetValue(curChapterTab.ID, out var value);
			List<GameStoryGuideItemData> list = value?.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
			if (list != null)
			{
				foreach (GameStoryGuideItemData item in list)
				{
					if (item.IsNew)
					{
						BtnSwitch.RedPoint = true;
						return;
					}
				}
			}
			BtnSwitch.RedPoint = false;
			return;
		}
		originalPhotoDataDic.TryGetValue(curChapterTab.ID, out var value2);
		List<GameStoryGuideItemData> list2 = value2?.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
		if (list2 != null)
		{
			foreach (GameStoryGuideItemData item2 in list2)
			{
				if (item2.IsNew)
				{
					BtnSwitch.RedPoint = true;
					return;
				}
			}
		}
		BtnSwitch.RedPoint = false;
	}

	private void CheckChapterRedPoint(TabItemNormalData chapterItem)
	{
		if (btnSwitch.IsSelected)
		{
			originalPhotoDataDic.TryGetValue(chapterItem.ID, out var value);
			List<GameStoryGuideItemData> list = value?.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
			if (list != null)
			{
				foreach (GameStoryGuideItemData item in list)
				{
					if (item.IsNew)
					{
						chapterItem.RedPoint = true;
						return;
					}
				}
			}
			chapterItem.RedPoint = false;
			return;
		}
		originalTimeLineDataDic.TryGetValue(chapterItem.ID, out var value2);
		List<GameStoryGuideItemData> list2 = value2?.FindAll((GameStoryGuideItemData p) => p.StoryType == curStoryTypeTab.ID);
		if (list2 != null)
		{
			foreach (GameStoryGuideItemData item2 in list2)
			{
				if (item2.IsNew)
				{
					chapterItem.RedPoint = true;
					return;
				}
			}
		}
		chapterItem.RedPoint = false;
	}

	private void CheckStoryRedPoint()
	{
		foreach (TabItemNormalData storyType in storyTypeList)
		{
			storyType.RedPoint = false;
			foreach (KeyValuePair<int, List<GameStoryGuideItemData>> item in originalPhotoDataDic)
			{
				foreach (GameStoryGuideItemData item2 in item.Value)
				{
					if (item2.StoryType == storyType.ID && item2.IsNew)
					{
						storyType.RedPoint = true;
						break;
					}
				}
			}
			foreach (KeyValuePair<int, List<GameStoryGuideItemData>> item3 in originalTimeLineDataDic)
			{
				foreach (GameStoryGuideItemData item4 in item3.Value)
				{
					if (item4.StoryType == storyType.ID && item4.IsNew)
					{
						storyType.RedPoint = true;
						break;
					}
				}
			}
		}
	}

	public override void Close()
	{
		ClearRedPoint();
		parent?.ItemOnClick(new OptionArg(this, ""));
		base.Close();
	}
}
