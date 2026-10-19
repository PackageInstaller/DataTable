using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TextLibraryInfo : MonoBehaviour
{
	public TextLibraryView view;

	public GameObject viewPortImageRoot;

	public BImage curTextLIbraryShowImage;

	public BImage curViewPortShowImage;

	public ActButton curViewPortIamgeBtn;

	public LocalizeStringEvent describeLocalize;

	public LocalizeStringEvent titleLocalize;

	[SerializeField]
	private LocalizeStringEvent _scenicSpotNameLocalize;

	[SerializeField]
	private LocalizeStringEvent _scenicSpotDesLocalize;

	[SerializeField]
	private TextMeshProUGUI _getTimeText;

	public ScrollRect scrollView;

	private int _curTextLibraryId;

	private TextLibraryContent _curTextLibraryTableData;

	private TextLibraryMediaType _mediaType;

	private TextLibraryContent _textLibraryTableData;

	private List<int> _imageIdList = new List<int>();

	private List<int> _describeIdList = new List<int>();

	public void Init(TextLibraryData textLibraryData)
	{
		if (_curTextLibraryId == textLibraryData.contentId)
		{
			return;
		}
		view?.betterAnimation.GetSequence("Change01").Play();
		_curTextLibraryId = textLibraryData.contentId;
		_curTextLibraryTableData = CoreUtils.GetData(_curTextLibraryId, RuntimeConfigs.data.textLibraryContents);
		_imageIdList.Clear();
		_describeIdList.Clear();
		viewPortImageRoot.SetActive(value: false);
		curTextLIbraryShowImage.icon.gameObject.SetActive(value: false);
		_textLibraryTableData = CoreUtils.GetData(textLibraryData.contentId, RuntimeConfigs.data.textLibraryContents);
		_mediaType = ((_textLibraryTableData.resName != 0) ? TextLibraryMediaType.Image : TextLibraryMediaType.Des);
		curTextLIbraryShowImage.icon.gameObject.SetActive(_curTextLibraryTableData.type == 1 && _textLibraryTableData.resName != 0);
		curViewPortShowImage.icon.gameObject.SetActive(_curTextLibraryTableData.type == 2);
		if (_mediaType == TextLibraryMediaType.Image)
		{
			_imageIdList.Add(_textLibraryTableData.resName);
			switch (_curTextLibraryTableData.type)
			{
			case 1:
				if (_textLibraryTableData.resName != 0)
				{
					curTextLIbraryShowImage.icon.gameObject.SetActive(value: true);
					view.Station.LoadImage(101, _imageIdList[0], curTextLIbraryShowImage);
				}
				break;
			case 2:
			{
				curViewPortIamgeBtn.SetBtnClick(() =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_VIEWPORT, new ViewportViewData
					{
						viewportItems = null,
						viewportId = _curTextLibraryId,
						isInGame = true,
						isFirstCatch = false
					});
				});
				viewPortImageRoot.gameObject.SetActive(value: true);
				view.Station.LoadImage(133, _imageIdList[0], curViewPortShowImage);
				_scenicSpotNameLocalize.SetTable(LocalizationUtility.localizeTableName_shortcommon);
				_scenicSpotNameLocalize.StringReference.TableEntryReference = _textLibraryTableData.titleName;
				_scenicSpotDesLocalize.SetTable(LocalizationUtility.localizeTableName_longcommon);
				_scenicSpotDesLocalize.StringReference.TableEntryReference = _textLibraryTableData.content;
				System.DateTime rDateTime = TimeManager.TimeStampToDateTime(textLibraryData.unLockTime);
				_getTimeText.text = TimeManager.GetDateTimeString(rDateTime);
				break;
			}
			}
		}
		_describeIdList.Add(_textLibraryTableData.content);
		bool flag = _curTextLibraryTableData.type != 2 && _curTextLibraryTableData.type != 0;
		describeLocalize.gameObject.SetActive(flag);
		if (flag)
		{
			describeLocalize.SetTable(LocalizeTable.LongCommon);
			describeLocalize.StringReference.TableEntryReference = _describeIdList[0];
		}
		titleLocalize.gameObject.SetActive(_curTextLibraryTableData.type != 2);
		titleLocalize.SetTable(LocalizeTable.ShortCommon);
		titleLocalize.StringReference.TableEntryReference = _textLibraryTableData.titleName;
		if (!Model<TextLibraryModel>.Interface.readTextLibraryIdList.Contains(_curTextLibraryId) && !textLibraryData.isRead)
		{
			Model<TextLibraryModel>.Interface.readTextLibraryIdList.Add(_curTextLibraryId);
		}
	}

	public void UnInit()
	{
		_curTextLibraryId = -1;
	}
}
