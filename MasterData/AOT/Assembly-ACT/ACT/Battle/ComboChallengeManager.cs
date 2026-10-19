using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.Battle;

public class ComboChallengeManager : Singleton<ComboChallengeManager>
{
	private const string ConfigPath = "Configs/ComboChallengeConfigs";

	private const string LocalStringConfigPath = "Configs/ComboChallengeLocalStringConfig";

	private Dictionary<int, ComboChallengeConfig> _configsDic;

	private AssetLoadHandle _assetHandle;

	private AssetLoadHandle _localStringAssetHandle;

	private ComboChallengeLocalStringConfig _localStringConfig;

	private bool _isInit;

	private ComboChallengeConfig _currentConfig;

	private bool _isChallengeActive;

	private int _comboCount;

	private float _timeRemaining;

	private Looper _challengeLooper;

	private Delayer _deathAnimDelayer;

	private Delayer _bornAnimDelayer;

	private bool _isWaitingDeathAnim;

	private bool _isWaitingBornAnim;

	private GameObject _leaveField;

	private AssetLoadHandle _comboTargetModelHandle;

	private Entity _attackEntity;

	private Animator _comboTargetAnimator;

	private static readonly string[] StageAnimNames = new string[4] { null, "Hit01", "Hit02", "Hit03" };

	private const string DeathAnimName = "Die";

	private const int AttackableId = 10;

	private const int DefenceTowerId = 4;

	public override ContextType ContextType => ContextType.NET;

	public override void Init()
	{
		if (_configsDic == null)
		{
			_configsDic = new Dictionary<int, ComboChallengeConfig>();
		}
		if (!_localStringAssetHandle.IsValid)
		{
			_localStringAssetHandle = AssetStationManager.BattleStation.LoadAsync<ComboChallengeLocalStringConfig>("Configs/ComboChallengeLocalStringConfig");
			_localStringAssetHandle.Completed += (AssetLoadHandle handle) =>
			{
				_localStringConfig = handle.As<ComboChallengeLocalStringConfig>();
			};
		}
		if (!_assetHandle.IsValid)
		{
			_assetHandle = AssetStationManager.BattleStation.LoadAsync<ComboChallengeConfigs>("Configs/ComboChallengeConfigs");
			_assetHandle.Completed += (AssetLoadHandle handle) =>
			{
				ComboChallengeConfigs.ComboChallengeMode[] comboModeConfigs = handle.As<ComboChallengeConfigs>().ComboModeConfigs;
				for (int i = 0; i < comboModeConfigs.Length; i++)
				{
					ComboChallengeConfigs.ComboChallengeMode comboChallengeMode = comboModeConfigs[i];
					if (!_configsDic.ContainsKey(comboChallengeMode.id))
					{
						_configsDic.Add(comboChallengeMode.id, comboChallengeMode.config);
					}
				}
				_isInit = true;
			};
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChallengeExit, OnFailEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Player_Respawn, OnFailEvent);
		base.Init();
	}

	public override void UnInit()
	{
		StopChallenge(success: false, showTips: false);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChallengeExit, OnFailEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Player_Respawn, OnFailEvent);
		base.UnInit();
	}

	private void OnFailEvent(BaseEventContent obj)
	{
		if (_isChallengeActive)
		{
			StopChallenge(success: false);
		}
	}

	public override void OnDestroy()
	{
		if (_assetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_assetHandle);
		}
		if (_localStringAssetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_localStringAssetHandle);
		}
		base.OnDestroy();
	}

	public ComboChallengeConfig GetConfigById(int id)
	{
		if (!_isInit)
		{
			return null;
		}
		return _configsDic.GetValueOrDefault(id);
	}

	public void StartChallenge(int configId, Transform parent)
	{
		ComboChallengeConfig configById = GetConfigById(configId);
		if (configById == null)
		{
			Debug.LogError($"ComboChallengeManager: 找不到配置ID {configId}");
			return;
		}
		if (_isChallengeActive)
		{
			Debug.LogWarning("ComboChallengeManager: 挑战已在进行中，先停止当前挑战");
			StopChallenge(success: false);
		}
		_currentConfig = configById;
		_comboCount = 0;
		_isChallengeActive = true;
		if (parent != null)
		{
			LoadComboTarget(parent, configById);
			CreateTriggerExitField(parent, configById);
		}
		ChangeLinkedObjectStates(configById.StateConfig, (ChallengeStateConfig cfg) => cfg.StartState);
		ShowChallengePrompts();
		SetProgressTitle();
		StartChallengeTimer();
	}

	public void StopChallenge(bool success, bool showTips = true)
	{
		if (_isChallengeActive)
		{
			UpdateTimer(ACT.Event.EventType.stop, _currentConfig.TimeLimit, 0f);
			if (showTips)
			{
				ChallengeTipComponentData uiData = new ChallengeTipComponentData
				{
					challengeTipShowType = ((!success) ? ChallengeTipShowType.Failure : ChallengeTipShowType.Success)
				};
				OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
				evt.position = UIPosition.UpperMiddle;
				evt.type = HudComponentType.ChallengeTip;
				evt.uiData = uiData;
				evt.timeOutDuration = 15f;
				evt.priorityInQueue = 1;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			ChangeLinkedObjectStates(_currentConfig.StateConfig, (ChallengeStateConfig cfg) => (!success) ? cfg.FailState : cfg.SuccessState);
			if (success)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldSuccess, null);
			}
			else
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWorldFail, null);
			}
			_isChallengeActive = false;
			_isWaitingDeathAnim = false;
			_isWaitingBornAnim = false;
			_challengeLooper.Cancel();
			_deathAnimDelayer.Cancel();
			_bornAnimDelayer.Cancel();
			_comboCount = 0;
			_currentConfig = null;
			CleanupComboTarget();
			if (_leaveField != null)
			{
				UnityEngine.Object.Destroy(_leaveField);
			}
		}
	}

	private void OnComboHit()
	{
		if (!_isChallengeActive || _currentConfig == null || _isWaitingDeathAnim || _isWaitingBornAnim)
		{
			return;
		}
		_comboCount++;
		Debug.Log($"ComboChallengeManager: 连击 {_comboCount}/{_currentConfig.ComboCountNeed}");
		UpdateComboAnimation();
		UpdateComboProgress();
		if (_comboCount >= _currentConfig.ComboCountNeed)
		{
			_isWaitingDeathAnim = true;
			PlayAnim("Die");
			_challengeLooper.Cancel();
			Debug.Log("ComboChallengeManager: 连击达标，等待死亡动画播完");
			int delayMs = Mathf.Max(0, (int)(_currentConfig.DeathAnimDuration * 1000f));
			_deathAnimDelayer = FixedUpdateTimer.Default.DelayMs(delayMs, () =>
			{
				StopChallenge(success: true);
			});
		}
		else
		{
			int currentStageIndex = GetCurrentStageIndex();
			if (currentStageIndex > 0 && currentStageIndex < StageAnimNames.Length)
			{
				PlayAnim(StageAnimNames[currentStageIndex]);
			}
		}
	}

	private void StartChallengeTimer()
	{
		_timeRemaining = _currentConfig.TimeLimit;
		UpdateTimer(ACT.Event.EventType.start, _currentConfig.TimeLimit, _timeRemaining);
		UpdateComboProgress();
		int delayMs = Mathf.Max(0, (int)(_currentConfig.BornAnimDuration * 1000f));
		_isWaitingBornAnim = true;
		_bornAnimDelayer = FixedUpdateTimer.Default.DelayMs(delayMs, () =>
		{
			_challengeLooper = FixedUpdateTimer.Default.LoopMs(1000, () =>
			{
				_isWaitingBornAnim = false;
				UpdateTimer(ACT.Event.EventType.tick, _currentConfig.TimeLimit, _timeRemaining);
				if (_timeRemaining <= 0f)
				{
					_challengeLooper.Cancel();
					Debug.LogWarning($"ComboChallengeManager: 超时！连击 {_comboCount}/{_currentConfig.ComboCountNeed}");
					StopChallenge(success: false);
				}
				else
				{
					_timeRemaining -= (MonoECS.instance.running ? 1 : 0);
				}
			});
		});
	}

	private void UpdateComboAnimation()
	{
		BigWordComboChallenge evt = Singleton<EventManager>.instance.GetEvt<BigWordComboChallenge>();
		evt.ComboCount = _comboCount.ToString();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ComboChallengeCount, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private int GetCurrentStageIndex()
	{
		if (_currentConfig == null)
		{
			return 0;
		}
		if (IsInStage(_currentConfig.ComboStageConfig1))
		{
			return 1;
		}
		if (IsInStage(_currentConfig.ComboStageConfig2))
		{
			return 2;
		}
		if (IsInStage(_currentConfig.ComboStageConfig3))
		{
			return 3;
		}
		return 0;
	}

	private bool IsInStage(ComboStageConfig stage)
	{
		if (stage != null && _comboCount >= stage.StartComboCount)
		{
			return _comboCount <= stage.EndComboCount;
		}
		return false;
	}

	private void PlayAnim(string animName)
	{
		if (_comboTargetAnimator != null && !string.IsNullOrEmpty(animName))
		{
			_comboTargetAnimator.CrossFadeInFixedTime(animName, 0f);
		}
	}

	private void LoadComboTarget(Transform parent, ComboChallengeConfig config)
	{
		if (!GameUtility.RuntimeGuidIsValid(config.ComboTargetModelGuid))
		{
			Debug.LogWarning("ComboChallengeManager: 受击模型GUID无效，跳过模型生成");
			return;
		}
		_comboTargetModelHandle = AssetStationManager.BattleStation.Instantiate(config.ComboTargetModelGuid, parent);
		GameObject gameObject = _comboTargetModelHandle.AsGameObject();
		gameObject.transform.localPosition = config.ComboTargetLocalPosition;
		_comboTargetAnimator = gameObject.GetComponentInChildren<Animator>();
		Vector3 position = gameObject.transform.position;
		Quaternion rotation = gameObject.transform.rotation;
		_attackEntity = GameManager.entities.factory.CreateAttackEntity();
		MonoECS.instance.SpawnAttackInteractObject(_attackEntity, 10, 0, 4, position, Alliance.Netural, Vector3.one, rotation);
		CompAbility? compAbility = _attackEntity.GetCompAbility();
		compAbility.comboDamageable = (Action<Entity, Entity>)Delegate.Combine(compAbility.comboDamageable, (Action<Entity, Entity>)((Entity _, Entity _) =>
		{
			OnComboHit();
		}));
	}

	private void CleanupComboTarget()
	{
		if (_attackEntity.IsAlive())
		{
			MonoECS.instance.TryRemoveBehave(_attackEntity);
		}
		_attackEntity = default;
		_comboTargetAnimator = null;
		if (_comboTargetModelHandle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(_comboTargetModelHandle);
		}
		_comboTargetModelHandle = default;
	}

	private void CreateTriggerExitField(Transform parent, ComboChallengeConfig config)
	{
		if (config.TriggerBounds != null && config.TriggerBounds.Length != 0)
		{
			_leaveField = new GameObject();
			_leaveField.transform.SetParent(parent, worldPositionStays: false);
			_leaveField.AddComponent<TemporaryArea>().Init(config.TriggerBounds, null, OnTriggerExit);
		}
	}

	private void OnTriggerExit()
	{
		StopChallenge(success: false);
	}

	private void ChangeLinkedObjectStates(ChallengeStateConfig[] stateConfigs, Func<ChallengeStateConfig, int> stateSelector)
	{
		if (stateConfigs != null && stateConfigs.Length != 0)
		{
			RuleManager ruleManager = MonoECS.instance.ruleManager;
			StateChangeInfo[] array = new StateChangeInfo[stateConfigs.Length];
			for (int i = 0; i < stateConfigs.Length; i++)
			{
				array[i] = new StateChangeInfo
				{
					uid = stateConfigs[i].StateWorldUid,
					stateId = stateSelector(stateConfigs[i])
				};
			}
			ruleManager.SharedChangeStates(array);
		}
	}

	private void UpdateTimer(ACT.Event.EventType type, float totalTime, float remainingTime)
	{
		BigWordTimeDate evt = Singleton<EventManager>.instance.GetEvt<BigWordTimeDate>();
		evt._Type = type;
		evt._total = totalTime;
		evt._remaining = remainingTime;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_BigWordChangeTimer, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void UpdateComboProgress()
	{
		BigWordProgressData evt = Singleton<EventManager>.instance.GetEvt<BigWordProgressData>();
		List<string> list = ListPool<string>.Get();
		list.Add(_comboCount.ToString());
		list.Add(_currentConfig.ComboCountNeed.ToString());
		evt.values = list;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshBigWorldProgress, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		ListPool<string>.Release(list);
	}

	private void SetProgressTitle()
	{
		if (!(_localStringConfig == null) && !(_currentConfig == null))
		{
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			LocalizedString localizedString = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.MainProgressText.TableReference, _currentConfig.CustomLocalStringConfig.MainProgressText.TableEntryReference) : new LocalizedString(_localStringConfig.MainProgressText.TableReference, _localStringConfig.MainProgressText.TableEntryReference));
			localizedString["0"] = new StringVariable
			{
				Value = _currentConfig.TimeLimit.ToString()
			};
			localizedString["1"] = new StringVariable
			{
				Value = _currentConfig.ComboCountNeed.ToString()
			};
			list.Add(localizedString);
			LocalizedString localizedString2 = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.SubProgressTip.TableReference, _currentConfig.CustomLocalStringConfig.SubProgressTip.TableEntryReference) : new LocalizedString(_localStringConfig.SubProgressTip.TableReference, _localStringConfig.SubProgressTip.TableEntryReference));
			localizedString2["0"] = new StringVariable
			{
				Value = _comboCount.ToString()
			};
			localizedString2["1"] = new StringVariable
			{
				Value = _currentConfig.ComboCountNeed.ToString()
			};
			list.Add(localizedString2);
			Model<BigWorldChallengeProgressModel>.Interface.StartChallenge(list);
			ListPool<LocalizedString>.Release(list);
		}
	}

	private void ShowChallengePrompts()
	{
		if (!(_localStringConfig == null) && !(_currentConfig == null))
		{
			LocalizedString localizedString = (_currentConfig.CustomLocalStringConfig.CustomLocalString ? new LocalizedString(_currentConfig.CustomLocalStringConfig.MainTipText.TableReference, _currentConfig.CustomLocalStringConfig.MainTipText.TableEntryReference) : new LocalizedString(_localStringConfig.MainTipText.TableReference, _localStringConfig.MainTipText.TableEntryReference));
			localizedString["0"] = new StringVariable
			{
				Value = _currentConfig.TimeLimit.ToString()
			};
			localizedString["1"] = new StringVariable
			{
				Value = _currentConfig.ComboCountNeed.ToString()
			};
			List<LocalizedString> list = ListPool<LocalizedString>.Get();
			list.Add(localizedString);
			Model<ChallengePromptsModel>.Interface.SetStringList(list);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHALLENGEPROMPTS);
			ListPool<LocalizedString>.Release(list);
		}
	}
}
