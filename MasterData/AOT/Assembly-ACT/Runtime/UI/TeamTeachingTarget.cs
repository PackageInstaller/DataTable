using ACT.Config;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace Runtime.UI;

public class TeamTeachingTarget : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent _localizeString;

	[SerializeField]
	private GameObject _finished;

	[SerializeField]
	private GameObject _unFinished;

	[SerializeField]
	private GameObject _failed;

	[SerializeField]
	private Color _finishedColor = new Color(1f, 1f, 1f, 1f);

	[SerializeField]
	private Color _unFinishedColor = new Color(172f / 255f, 172f / 255f, 172f / 255f, 1f);

	[SerializeField]
	private Color _failedColor = new Color(1f, 80f / 255f, 80f / 255f, 1f);

	private TextMeshProUGUI _conditionText;

	private bool _isFinished;

	private bool _isFailed;

	private void Awake()
	{
		_conditionText = ((_localizeString != null) ? _localizeString.GetComponent<TextMeshProUGUI>() : null);
		if (_localizeString != null)
		{
			_localizeString.enabled = false;
		}
	}

	public void SetCondition(Rules rule, string targetText)
	{
		if (rule != null)
		{
			if (_conditionText == null)
			{
				_conditionText = ((_localizeString != null) ? _localizeString.GetComponent<TextMeshProUGUI>() : null);
			}
			if (_conditionText != null)
			{
				_conditionText.text = targetText;
			}
			_isFinished = false;
			_isFailed = false;
			RefreshState();
		}
	}

	public void SetFinished(bool finished)
	{
		_isFinished = finished;
		if (finished)
		{
			_isFailed = false;
		}
		RefreshState();
	}

	public void SetFailed(bool failed)
	{
		_isFailed = failed;
		if (failed)
		{
			_isFinished = false;
		}
		RefreshState();
	}

	private void RefreshState()
	{
		bool isFailed = _isFailed;
		bool flag = !isFailed && _isFinished;
		bool flag2 = !isFailed && !flag;
		if (_failed != null)
		{
			_failed.SetActive(isFailed);
		}
		if (_finished != null)
		{
			_finished.SetActive(flag);
		}
		if (_unFinished != null)
		{
			_unFinished.SetActive(flag2 || (isFailed && _failed == null));
		}
		if (!(_conditionText == null))
		{
			if (isFailed)
			{
				_conditionText.color = _failedColor;
			}
			else if (flag)
			{
				_conditionText.color = _finishedColor;
			}
			else
			{
				_conditionText.color = _unFinishedColor;
			}
		}
	}
}
