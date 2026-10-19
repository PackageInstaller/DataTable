using ACT.Config;
using ACT.Core;
using ACT.RichText;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CommonSubWorldEntranceTargetItem : MonoBehaviour
{
	[SerializeField]
	private GameObject _unCompleteBG;

	[SerializeField]
	private GameObject _completeBG;

	[SerializeField]
	private GameObject _lastCompleteBG;

	[SerializeField]
	private GameObject _star;

	[SerializeField]
	private GameObject _starBG;

	[SerializeField]
	private TextMeshProUGUI _description;

	[SerializeField]
	private TextMeshProUGUI _progress;

	[SerializeField]
	private Color _completeColor;

	[SerializeField]
	private Color _unCompleteColor;

	[SerializeField]
	private GameObject _lastComplete;

	[SerializeField]
	private GameObject _complete;

	[SerializeField]
	private GameObject _newComplete;

	[SerializeField]
	private GameObject _unComplete;

	private string[] targetDescriptions = new string[3]
	{
		string.Empty,
		"Ⅰ：",
		"Ⅱ："
	};

	public void RefreshUI(int index, int rulesId, bool isComplete, int progress, bool lastIsComplete = false, bool preferMissionDescription = false)
	{
		Rules data = CoreUtils.GetData(rulesId, RuntimeConfigs.data.ruless);
		if (data == null)
		{
			gameObject.SetActive(value: false);
			return;
		}
		string description = (preferMissionDescription ? ChallengeTargetTextUtility.GetText(rulesId) : CustomTagParser.ReplaceBattleRuleDataText(data, data.number, data.param));
		int targetProgress = ((progress >= 0) ? data.number : (-1));
		RefreshUI(index, description, isComplete, progress, targetProgress, lastIsComplete);
	}

	public void RefreshUI(int index, string description, bool isComplete, int progress = -1, int targetProgress = -1, bool lastIsComplete = false)
	{
		_description.text = description;
		RefreshState(isComplete, progress, targetProgress, lastIsComplete);
	}

	public void RefreshState(bool isComplete, bool lastIsComplete = false)
	{
		RefreshState(isComplete, -1, -1, lastIsComplete);
	}

	private void RefreshState(bool isComplete, int progress, int targetProgress, bool lastIsComplete)
	{
		_unCompleteBG.SetActive(!isComplete && !lastIsComplete);
		_completeBG.SetActive(isComplete);
		_lastCompleteBG.SetActive(!isComplete & lastIsComplete);
		_star.SetActive(isComplete);
		_starBG.SetActive(value: true);
		bool flag = progress >= 0 && targetProgress >= 0;
		_progress.gameObject.SetActive(flag);
		_progress.text = (flag ? $"（{Mathf.Min(progress, targetProgress)}/{targetProgress}）" : string.Empty);
		_description.color = (isComplete ? _completeColor : _unCompleteColor);
		_progress.color = (isComplete ? _completeColor : _unCompleteColor);
		_lastComplete.SetActive(lastIsComplete && !isComplete);
		_complete.SetActive(isComplete);
		_newComplete.SetActive(isComplete && !lastIsComplete);
		_unComplete.SetActive(!isComplete && !lastIsComplete);
	}
}
