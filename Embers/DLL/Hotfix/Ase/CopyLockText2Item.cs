using System;
using TMPro;
using UnityEngine;

namespace Ase;

public class CopyLockText2Item : MonoBehaviour
{
	public string timeColor;

	public TextMeshProUGUI textLockDesc;

	private CopyTypeData copyTypeData;

	private Action<long> GetServerTime;

	private bool isLockTime;

	private long serverTime;

	public CopyTypeData CopyTypeData
	{
		get
		{
			return copyTypeData;
		}
		set
		{
			copyTypeData = value;
			isLockTime = copyTypeData.IsLockTime;
			((Component)(object)textLockDesc).gameObject.SetActive(copyTypeData.IsLock);
			if (copyTypeData.IsLockCondition)
			{
				SetConditionLockDesc();
			}
			else if (copyTypeData.IsLockPrevious)
			{
				((TMP_Text)textLockDesc).text = "";
			}
		}
	}

	public void UpdateServerTime(long serverTime)
	{
		if (!isLockTime)
		{
			return;
		}
		this.serverTime = serverTime;
		if (copyTypeData.IsLockCondition)
		{
			SetConditionLockDesc();
		}
		else if (copyTypeData.IsLockTime)
		{
			if (copyTypeData.StartTime - serverTime > 86400)
			{
				((TMP_Text)textLockDesc).text = "<color=#" + timeColor + ">" + Utility.DateTime.GetLeftDateHourExact(copyTypeData.StartTime - serverTime, "dd\\天hh\\小\\时mm\\分") + "后</color>解锁";
			}
			else
			{
				((TMP_Text)textLockDesc).text = "<color=#" + timeColor + ">" + Utility.DateTime.GetLeftDateHourExact(copyTypeData.StartTime - serverTime, "hh\\小\\时mm\\分") + "后</color>解锁";
			}
		}
		else if (copyTypeData.IsLockPrevious)
		{
			((TMP_Text)textLockDesc).text = "";
		}
		isLockTime = copyTypeData.IsLockTime;
	}

	private void SetConditionLockDesc()
	{
		if (!copyTypeData.IsLockCondition)
		{
			return;
		}
		if (copyTypeData.OpenType == 2)
		{
			DRPermit dataRow = GameEntry.DataTable.GetDataRow((DRPermit p) => p.Id == copyTypeData.OpenCondition);
			if (dataRow != null)
			{
				((TMP_Text)textLockDesc).text = dataRow.Name + "后解锁";
			}
			else
			{
				((TMP_Text)textLockDesc).text = "讨伐许可等级达到???后解锁";
			}
		}
		else if (copyTypeData.OpenType == 3)
		{
			((TMP_Text)textLockDesc).text = $"需传火等级达到{copyTypeData.OpenCondition}级时开放";
		}
	}
}
