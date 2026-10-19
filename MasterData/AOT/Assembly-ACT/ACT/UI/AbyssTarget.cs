using ACT.Model;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AbyssTarget : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _localizeString;

	[SerializeField]
	private GameObject _finished;

	[SerializeField]
	private GameObject _unFinished;

	[SerializeField]
	private Color _finishedColor = new Color(1f, 1f, 1f, 1f);

	[SerializeField]
	private Color _unFinishedColor = new Color(172f / 255f, 172f / 255f, 172f / 255f, 1f);

	public void OnUpdate(int targetTime)
	{
		bool flag = Model<AbyssModel>.Interface.GetAbyssTotalTime() < targetTime;
		int value = targetTime / 60;
		int value2 = targetTime % 60;
		_localizeString.StringReference.TableEntryReference = 615L;
		_localizeString.StringReference.GetVariable<int>("0").Value = value;
		_localizeString.StringReference.GetVariable<int>("1").Value = value2;
		_localizeString.GetComponent<TextMeshProUGUI>().color = (flag ? _finishedColor : _unFinishedColor);
		_finished.SetActive(flag);
		_unFinished.SetActive(!flag);
	}
}
