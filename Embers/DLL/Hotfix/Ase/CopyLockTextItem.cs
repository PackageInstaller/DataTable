#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using TMPro;
using UnityEngine;

namespace Ase;

public class CopyLockTextItem : MonoBehaviour
{
	public string defaultColor = "dba062";

	public TextMeshProUGUI textTask;

	public TextMeshProUGUI textLevel;

	public TextMeshProUGUI textPreviousOpen;

	private bool isTaskLock;

	private bool isLevelLock;

	private bool isPreviousOpenLock;

	private CopyData copyData;

	public CopyData CopyData
	{
		get
		{
			return copyData;
		}
		set
		{
			copyData = value;
			IsTaskLock = copyData.IsTaskLock;
			IsLevelLock = copyData.IsLevelLock;
			IsPreviousOpenLock = copyData.IsPreviousOpenLock;
		}
	}

	public bool IsTaskLock
	{
		get
		{
			return isTaskLock;
		}
		set
		{
			isTaskLock = value;
			((Component)(object)textTask).gameObject.SetActive(isTaskLock);
			if (isTaskLock)
			{
				DRTask dataRow = GameEntry.DataTable.GetDataRow((DRTask p) => p.Id == copyData.TaskIdComplete);
				if (dataRow != null)
				{
					((TMP_Text)textTask).text = "完成主线<color=#" + defaultColor + ">" + dataRow.TaskName + "</color>";
				}
				else
				{
					Log.Error($"Task表找不到任务Id为{copyData.TaskIdComplete}的任务！");
					((TMP_Text)textTask).text = "完成主线<color=#" + defaultColor + ">???</color>";
				}
			}
		}
	}

	public bool IsLevelLock
	{
		get
		{
			return isLevelLock;
		}
		set
		{
			isLevelLock = value;
			((Component)(object)textLevel).gameObject.SetActive(isLevelLock);
			if (isLevelLock)
			{
				((TMP_Text)textLevel).text = $"传火等级达到<color=#{defaultColor}>Lv{copyData.AdvLevel}</color>";
			}
		}
	}

	public bool IsPreviousOpenLock
	{
		get
		{
			return isPreviousOpenLock;
		}
		set
		{
			if (isLevelLock || isTaskLock)
			{
				isPreviousOpenLock = false;
			}
			else
			{
				isPreviousOpenLock = value;
			}
			((Component)(object)textPreviousOpen)?.gameObject.SetActive(isPreviousOpenLock);
		}
	}
}
