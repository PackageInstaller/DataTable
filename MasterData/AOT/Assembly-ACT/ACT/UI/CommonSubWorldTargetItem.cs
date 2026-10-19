using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.RichText;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CommonSubWorldTargetItem : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GameObject _completeBG;

	[SerializeField]
	private Color _completeColor;

	[SerializeField]
	private GameObject _normalBG;

	[SerializeField]
	private Color _normalColor;

	[SerializeField]
	private GameObject _unCompleteBG;

	[SerializeField]
	private Color _unCompleteColor;

	[SerializeField]
	private TextMeshProUGUI _description;

	private int _targetId;

	private Rules _rulesConfig;

	private string _externalDescription;

	private bool _preferMissionDescription;

	private bool _isTrackerListenerRegistered;

	private void OnEnable()
	{
		EnsureTrackerListener();
		RefreshDescription();
		RefreshState();
	}

	private void OnDisable()
	{
		RemoveTrackerListener();
	}

	public void UpdateState(int targetId)
	{
		_externalDescription = null;
		_preferMissionDescription = false;
		UpdateStateInternal(targetId);
	}

	public void UpdateState(int targetId, bool preferMissionDescription)
	{
		_externalDescription = null;
		_preferMissionDescription = preferMissionDescription;
		UpdateStateInternal(targetId);
	}

	private void UpdateStateInternal(int targetId)
	{
		_targetId = targetId;
		if (RuntimeConfigs.data.ruless.TryGetValue(targetId, out _rulesConfig))
		{
			RefreshDescription();
			EnsureTrackerListener();
			RefreshState();
		}
	}

	public void UpdateState(int targetId, string description)
	{
		UpdateState(targetId);
		if (_rulesConfig != null && !string.IsNullOrEmpty(description))
		{
			_externalDescription = description;
			RefreshDescription();
		}
	}

	private void RefreshDescription()
	{
		if (_rulesConfig != null)
		{
			string baseDescription = GetBaseDescription();
			string text = baseDescription;
			if (Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.TryRecordTargetProgress(_targetId, out var current, out var total))
			{
				text = $"{baseDescription}（{current}/{total}）";
			}
			if (_description.text != text)
			{
				_description.text = text;
			}
		}
	}

	private string GetBaseDescription()
	{
		if (!string.IsNullOrEmpty(_externalDescription))
		{
			return _externalDescription;
		}
		if (_preferMissionDescription)
		{
			return ChallengeTargetTextUtility.GetText(_targetId);
		}
		return CustomTagParser.ReplaceBattleRuleDataText(_rulesConfig, _rulesConfig.number, _rulesConfig.param);
	}

	private void RefreshState()
	{
		if (_rulesConfig != null)
		{
			if (IsTrackerTargetFailed())
			{
				SetState(CommonSubWorldTargetItemState.UnComplete);
			}
			else if (IsTrackerTargetCompleted())
			{
				SetState(CommonSubWorldTargetItemState.Complete);
			}
			else
			{
				SetState(CommonSubWorldTargetItemState.Normal);
			}
		}
	}

	private void SetState(CommonSubWorldTargetItemState state)
	{
		_completeBG.SetActive(state == CommonSubWorldTargetItemState.Complete);
		_normalBG.SetActive(state == CommonSubWorldTargetItemState.Normal);
		_unCompleteBG.SetActive(state == CommonSubWorldTargetItemState.UnComplete);
		switch (state)
		{
		case CommonSubWorldTargetItemState.Normal:
			_description.color = _normalColor;
			_betterAnimation.GetSequence("Normal").Play();
			break;
		case CommonSubWorldTargetItemState.Complete:
			_description.color = _completeColor;
			_betterAnimation.GetSequence("Complete").Play();
			break;
		case CommonSubWorldTargetItemState.UnComplete:
			_description.color = _unCompleteColor;
			_betterAnimation.GetSequence("Fail").Play();
			break;
		}
	}

	private void EnsureTrackerListener()
	{
		if (!_isTrackerListenerRegistered && _targetId > 0 && Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.Interface.TargetCompletedChanged += OnTargetCompletedChanged;
			Model<ChallengeTargetTrackerModel>.Interface.TargetFailedChanged += OnTargetFailedChanged;
			Model<ChallengeTargetTrackerModel>.Interface.TargetChanged += OnTargetChanged;
			_isTrackerListenerRegistered = true;
		}
	}

	private void RemoveTrackerListener()
	{
		if (_isTrackerListenerRegistered)
		{
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.TargetCompletedChanged -= OnTargetCompletedChanged;
				Model<ChallengeTargetTrackerModel>.Interface.TargetFailedChanged -= OnTargetFailedChanged;
				Model<ChallengeTargetTrackerModel>.Interface.TargetChanged -= OnTargetChanged;
			}
			_isTrackerListenerRegistered = false;
		}
	}

	private void OnTargetCompletedChanged(int targetId, bool completed)
	{
		if (targetId == _targetId && completed)
		{
			RefreshDescription();
			SetState(CommonSubWorldTargetItemState.Complete);
		}
	}

	private void OnTargetFailedChanged(int targetId, bool fail)
	{
		if (targetId == _targetId && fail)
		{
			RefreshDescription();
			SetState(CommonSubWorldTargetItemState.UnComplete);
		}
	}

	private void OnTargetChanged(int targetId, int progress)
	{
		if (targetId == _targetId && progress >= 0 && _rulesConfig != null && Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.TryRecordTargetProgress(_targetId, out var _, out var _))
		{
			RefreshDescription();
		}
	}

	private bool IsTrackerTargetCompleted()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || !Model<ChallengeTargetTrackerModel>.Interface.IsPrepared)
		{
			return false;
		}
		return Model<ChallengeTargetTrackerModel>.Interface.IsTargetCompleted(_targetId);
	}

	private bool IsTrackerTargetFailed()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance() || !Model<ChallengeTargetTrackerModel>.Interface.IsPrepared)
		{
			return false;
		}
		return Model<ChallengeTargetTrackerModel>.Interface.IsTargetFailed(_targetId);
	}
}
