using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

namespace ACT.UI;

public class TextLibraryCell : MonoBehaviour
{
	public ActButton self;

	public GameObject selected;

	public LocalizeStringEvent txtLibraryContent;

	public RedDotItem redDot;

	public TextMeshProUGUI contentText;

	public ACT.ViewControl.SelectableEx selectableEx;

	public VerticalLayoutGroup parentLayout;

	private string _rootRedDotPath;

	private TextLibraryView _parentView;

	public TextLibraryData data { get; private set; }

	public bool isSelected { get; set; }

	public void UpdateDisPlay(TextLibraryData cellData, string rootRedDotPath, Action onCellSelected)
	{
		data = cellData;
		_rootRedDotPath = rootRedDotPath;
		self.SetBtnClick(() =>
		{
			if (!isSelected)
			{
				OnSelected();
				if (EventSystemHelper.Available && selectableEx != null)
				{
					EventSystemHelper.SetSelectedGameObject(selectableEx.gameObject);
				}
				onCellSelected?.Invoke();
			}
		});
		_parentView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_TEXTLIBRARY) as TextLibraryView;
		if (_parentView != null && _parentView.curSelectedContent?.contentId == data.contentId)
		{
			if (EventSystemHelper.Available && selectableEx != null)
			{
				EventSystemHelper.SetSelectedGameObject(selectableEx.gameObject);
			}
			OnSelected();
			_parentView.SetSelectedCell(this);
		}
		else
		{
			SetSelectedState(active: false);
		}
		TextLibraryContent textLibraryContent = CoreUtils.GetData(cellData.contentId, RuntimeConfigs.data.textLibraryContents);
		txtLibraryContent.SetTable(LocalizeTable.ShortCommon);
		if (textLibraryContent == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id:{cellData.contentId}的词条，文本库词条组里配了，词条表里没有，检查配表");
			}
		}
		else
		{
			txtLibraryContent.StringReference.TableEntryReference = textLibraryContent.titleName;
		}
		if (_parentView != null && !string.IsNullOrEmpty(_parentView.SearchText))
		{
			string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", textLibraryContent.titleName, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null);
			localizedString = localizedString.Replace(_parentView.SearchText, "<color=#EBE27B>" + _parentView.SearchText + "</color>");
			contentText.SetText(localizedString);
		}
		redDot?.gameObject.SetActive(!cellData.isRead);
	}

	public void OnSelected()
	{
		if (!isSelected)
		{
			SetSelectedState(active: true);
		}
		if (_parentView != null)
		{
			_parentView.curSelectedContent = data;
			_parentView.SetSelectedCell(this);
		}
		_parentView?.textLibraryInfo?.Init(data);
		if (MonoECS.instance.IsGamePadMode())
		{
			_parentView?.RefreshOperatePromptState();
		}
		if (!data.isRead)
		{
			data.isRead = true;
			redDot?.gameObject.SetActive(value: false);
		}
		LibraryContentEvent evt = EventTrackSolver.Instance.GetEvt<LibraryContentEvent>();
		evt.contentId = data.contentId;
		evt.libraryId = data.belongGroupId;
		evt.mainId = data.belongParentId;
		if (RuntimeConfigs.data.textLibraryContents.TryGetValue(data.contentId, out var value))
		{
			evt.type = value.type;
		}
		evt.isRednote = data.isRead;
		evt.op = 1;
		EventTrackSolver.Instance.Dispatch(evt);
		bool active = Model<TextLibraryModel>.Interface.GroupHasUnReadTextLibrary(data.belongGroupId);
		if (!string.IsNullOrEmpty(_rootRedDotPath))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(_rootRedDotPath, active);
		}
		bool active2 = Model<TextLibraryModel>.Interface.TypeHasUnReadTextLibrary(data.belongParentId);
		int belongParentId = data.belongParentId;
		string nodeFullPath = belongParentId switch
		{
			1 => RedDotPathDefine.TextLibrary, 
			2 => RedDotPathDefine.ViewPort, 
		};
		Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active2);
	}

	public void SetSelectedState(bool active)
	{
		selected.SetActive(active);
		isSelected = active;
	}

	private void OnDestroy()
	{
		SetSelectedState(active: false);
	}
}
