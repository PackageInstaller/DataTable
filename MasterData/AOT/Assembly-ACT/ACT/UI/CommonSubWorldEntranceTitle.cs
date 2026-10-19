using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CommonSubWorldEntranceTitle : MonoBehaviour
{
	[SerializeField]
	private GameObject _perfect;

	[SerializeField]
	private LocalizeStringEvent _title;

	[SerializeField]
	private GameObject _recommendedLevel;

	[SerializeField]
	private TextMeshProUGUI _level;

	[SerializeField]
	private GameObject _record;

	[SerializeField]
	private LocalizeStringEvent _recordTime;

	public void RefreshUI(int titleLocalizeId, bool isComplete, int recommenddedLevel = -1, int recordTime = -1, bool isPerfect = false)
	{
		RefreshUI(LocalizationUtility.localizeTableName_shortcommon, titleLocalizeId, isComplete, recommenddedLevel, recordTime, isPerfect);
	}

	public void RefreshUI(string tableName, int titleLocalizeId, bool isComplete, int recommenddedLevel = -1, int recordTime = -1, bool isPerfect = false)
	{
		_title.SetTable(tableName);
		_title.StringReference.TableEntryReference = titleLocalizeId;
		RefreshPresentation(recommenddedLevel, recordTime, isPerfect);
	}

	public void RefreshUI(string title, bool isComplete, int recommenddedLevel = -1, int recordTime = -1, bool isPerfect = false)
	{
		_title.GetComponent<TextMeshProUGUI>().text = title;
		RefreshPresentation(recommenddedLevel, recordTime, isPerfect);
	}

	private void RefreshPresentation(int recommenddedLevel, int recordTime, bool isPerfect)
	{
		_recommendedLevel.SetActive(recommenddedLevel > 0);
		if (recommenddedLevel > 0)
		{
			_level.text = recommenddedLevel.ToString();
		}
		_record.SetActive(recordTime > 0);
		_perfect.SetActive(isPerfect);
		if (recordTime > 0)
		{
			int num = recordTime / 60;
			int num2 = recordTime % 60;
			_recordTime.GetVariable<string>("0").Value = $"{num:D2}";
			_recordTime.GetVariable<string>("1").Value = $"{num2:D2}";
		}
	}
}
