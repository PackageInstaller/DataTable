using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public abstract class CommonTaskItemBase : MonoBehaviour
{
	[SerializeField]
	protected LocalizeStringEvent _totalTime;

	[SerializeField]
	protected TextMeshProUGUI _title;

	private const int SecLocalId = 597;

	private const int MinLocalId = 619;

	private const int HourLocalId = 2473;

	protected void UpdateTotalTime(int totalSeconds)
	{
		if (totalSeconds < 60)
		{
			_totalTime.StringReference.TableEntryReference = 597L;
			_totalTime.StringReference.GetVariable<int>("0").Value = totalSeconds;
		}
		else if (totalSeconds < 3600)
		{
			int value = totalSeconds / 60;
			int value2 = totalSeconds % 60;
			_totalTime.StringReference.TableEntryReference = 619L;
			_totalTime.StringReference.GetVariable<int>("0").Value = value;
			_totalTime.StringReference.GetVariable<int>("1").Value = value2;
		}
		else
		{
			int value3 = totalSeconds / 3600;
			int value4 = totalSeconds % 3600 / 60;
			int value5 = totalSeconds % 60;
			_totalTime.StringReference.TableEntryReference = 2473L;
			_totalTime.StringReference.GetVariable<int>("0").Value = value3;
			_totalTime.StringReference.GetVariable<int>("1").Value = value4;
			_totalTime.StringReference.GetVariable<int>("2").Value = value5;
		}
	}

	public virtual void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}

	public abstract void Refresh(SettlementType settlementType);

	public virtual void PlayItemAnimation(SettlementType settlementType)
	{
	}

	public void Refresh()
	{
		Refresh(SettlementType.Success);
	}
}
