using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class BigWorldChallengeManager : Singleton<BigWorldChallengeManager>
{
	private bool _isChallengeActive;

	private ChallengeType _activeChallengeType;

	private int _activeConfigId;

	private Transform _activeParent;

	public override ContextType ContextType => ContextType.NET;

	public bool IsChallengeActive => _isChallengeActive;

	public ChallengeType ActiveChallengeType => _activeChallengeType;

	public int ActiveConfigId => _activeConfigId;

	public Transform ActiveParent => _activeParent;

	public void StartChallenge(ChallengeType challengeType, int configId, Transform parent)
	{
		if (_isChallengeActive)
		{
			Debug.LogWarning($"BigWorldChallengeManager: 已有挑战进行中 [类型:{_activeChallengeType} 配置:{_activeConfigId}]，先停止当前挑战");
			StopCurrentChallenge(success: false, showTips: false);
		}
		_activeChallengeType = challengeType;
		_activeConfigId = configId;
		_activeParent = parent;
		_isChallengeActive = true;
		switch (challengeType)
		{
		case ChallengeType.Break:
			Singleton<BreakChallengeManager>.instance.StartChallenge(configId, parent);
			break;
		case ChallengeType.Combo:
			Singleton<ComboChallengeManager>.instance.StartChallenge(configId, parent);
			break;
		case ChallengeType.Battle:
			Singleton<BattleChallengeManager>.instance.StartChallenge(configId, parent);
			break;
		case ChallengeType.Running:
			Singleton<RunningChallengeManager>.instance.StartChallenge(configId, parent);
			break;
		default:
			Debug.LogError($"BigWorldChallengeManager: 未实现的挑战类型 {challengeType}");
			_isChallengeActive = false;
			break;
		}
	}

	public void StopCurrentChallenge(bool success, bool showTips = true)
	{
		if (_isChallengeActive)
		{
			switch (_activeChallengeType)
			{
			case ChallengeType.Break:
				Singleton<BreakChallengeManager>.instance.StopChallenge(success, showTips);
				break;
			case ChallengeType.Combo:
				Singleton<ComboChallengeManager>.instance.StopChallenge(success, showTips);
				break;
			case ChallengeType.Battle:
				Singleton<BattleChallengeManager>.instance.StopChallenge(success, showTips);
				break;
			case ChallengeType.Running:
				Singleton<RunningChallengeManager>.instance.StopChallenge(success, showTips);
				break;
			default:
				Debug.LogError($"BigWorldChallengeManager: 未实现的挑战类型 {_activeChallengeType}");
				break;
			}
			_isChallengeActive = false;
			_activeConfigId = 0;
			_activeParent = null;
		}
	}

	public override void Init()
	{
		base.Init();
	}

	public override void UnInit()
	{
		if (_isChallengeActive)
		{
			StopCurrentChallenge(success: false, showTips: false);
		}
		base.UnInit();
	}
}
