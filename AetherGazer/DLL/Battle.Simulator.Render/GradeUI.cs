using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class GradeUI : MonoBehaviour
{
	private const int MAX_LEVEL = 5;

	public Slider slider;

	public Text Descript;

	public List<string> effectPath = new List<string>(8);

	public float baseFov = 55f;

	public int baseWidth = 2340;

	public int baseHeight = 1080;

	public RectTransform effectPos;

	public float cameraEffectDistanceToCamera = 0.4f;

	public BattleUI battleUI;

	private int _lastLevel = -1;

	private BBHumanoid _blackboard;

	private List<string> _levelDescript = new List<string>(8);

	private List<CombatScore> _levelConfigs = new List<CombatScore>(8);

	private GameObject currentEffect;

	private Camera mainCamera;

	private Camera uiCamera;

	private Canvas rootCanvas;

	private bool active;

	private const int LEVEL_DESCRIPT_TIP_ID = 19;

	private const int Race_China_ID = 10;

	private const int Race_Long_Num = 3;

	private bool _lastActive = true;

	public int maxGradeBuffClassID = 100020510;

	private void Awake()
	{
		BattleScene battleScene = (BattleScene)NScene.GetCurrentScene();
		RefreshDescript(battleScene.ready.SceneDataForExcehange.IndexOfMaxCountRace, battleScene.ready.SceneDataForExcehange.NumOfMaxCountRace);
		BattleUI obj = battleUI;
		obj.onBattleUIActiveEvent = (Action<bool>)Delegate.Combine(obj.onBattleUIActiveEvent, new Action<bool>(OnBattleUIActiveEventHandler));
	}

	public void RefreshDescript(int Racetype, int RaceNum)
	{
		_levelDescript.Clear();
		_levelConfigs.Clear();
		CombatScore config;
		for (int i = ((Racetype == 9 && RaceNum == 3) ? 10 : 0); ConfigHelper.GetInstance().TryGetConfig<CombatScore>(i, out config); i++)
		{
			if (config.ExposedAdd > 0)
			{
				_levelDescript.Add(string.Format(WorldStateManager.GetTipsContent(19), config.ExposedAdd, config.AttackAdd));
			}
			else
			{
				_levelDescript.Add(string.Empty);
			}
			_levelConfigs.Add(config);
		}
	}

	private void OnDestroy()
	{
		BattleUI obj = battleUI;
		obj.onBattleUIActiveEvent = (Action<bool>)Delegate.Remove(obj.onBattleUIActiveEvent, new Action<bool>(OnBattleUIActiveEventHandler));
	}

	private void OnBattleUIActiveEventHandler(bool enable)
	{
		active = enable;
		if (!enable && currentEffect != null)
		{
			PooledAsset.DestroyOrReturn(currentEffect);
			currentEffect = null;
			_lastLevel = -1;
		}
	}

	public void OnMainPlayerUpdate(NAgent agent)
	{
		_blackboard = agent.Blackboard as BBHumanoid;
		UpdateUI();
	}

	private void Update()
	{
		if (active)
		{
			UpdateUI();
		}
	}

	private void UpdateUI()
	{
		if (null == _blackboard || _blackboard.m_NextSimFrameData == null)
		{
			return;
		}
		CombatScore combatScore = _levelConfigs[0];
		CombatScore combatScore2 = _levelConfigs[1];
		int mCombatScore = _blackboard.m_NextSimFrameData.mCombatScore;
		for (int i = 0; i <= 5; i++)
		{
			combatScore = _levelConfigs[i];
			combatScore2 = _levelConfigs[i + 1];
			if (combatScore.FloorValue <= mCombatScore && combatScore2.FloorValue > mCombatScore)
			{
				break;
			}
		}
		int num = combatScore.ID % 10;
		SetActive(num > 0);
		if (num <= 0)
		{
			return;
		}
		int num2 = num;
		if (_lastLevel != num2)
		{
			if (currentEffect != null)
			{
				PooledAsset.DestroyOrReturn(currentEffect);
				currentEffect = null;
			}
			if (!string.IsNullOrEmpty(effectPath[num2]))
			{
				currentEffect = Asset.Instantiate(effectPath[num2]);
				PlayCameraEffect();
			}
			Descript.text = _levelDescript[num2];
			_lastLevel = num2;
		}
		if (num2 == 5)
		{
			slider.value = GetMaxLevelSliderValue();
		}
		else
		{
			slider.value = (float)(mCombatScore - combatScore.FloorValue) * 1f / (float)(combatScore2.FloorValue - combatScore.FloorValue);
		}
	}

	private void SetActive(bool active)
	{
		if (_lastActive != active)
		{
			if (slider != null)
			{
				slider.gameObject.SetActive(active);
			}
			Descript.enabled = active;
			_lastActive = active;
			if (currentEffect != null && !active)
			{
				PooledAsset.DestroyOrReturn(currentEffect);
				currentEffect = null;
				_lastLevel = -1;
			}
		}
	}

	private void PlayCameraEffect()
	{
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		currentEffect.transform.parent = mainCamera.transform;
		SetCameraEffectPos();
		EffectController effectController = EffectController.GetEffectController(currentEffect);
		if (!(effectController == null))
		{
			effectController.Initialize(isLoop: true, 1f, 1f, EEffectQuality.Fantastic, null);
			effectController.Simulator(0f);
		}
	}

	private float GetMaxLevelSliderValue()
	{
		if (null == _blackboard || _blackboard.m_NextSimFrameData == null)
		{
			return 0f;
		}
		List<BuffState> buffStateArray = _blackboard.m_NextSimFrameData.BuffStateArray;
		for (int i = 0; i < buffStateArray.Count; i++)
		{
			if (buffStateArray[i].mBuffClassID == maxGradeBuffClassID)
			{
				return (float)buffStateArray[i].mDuring / (float)buffStateArray[i].mBuffKeepTime;
			}
		}
		return 0f;
	}

	private void OnEnable()
	{
		active = true;
	}

	private void OnDisable()
	{
		active = false;
		if (!MonoManager.isQuiting)
		{
			SetActive(active: false);
		}
	}

	private void SetCameraEffectPos()
	{
		if (!(currentEffect == null) && !(effectPos == null))
		{
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			if (uiCamera == null)
			{
				uiCamera = CanvasManager.Instance.uiCamera;
			}
			if (rootCanvas == null)
			{
				rootCanvas = GetComponentInParent<Canvas>().rootCanvas;
			}
			Vector3 vector = uiCamera.WorldToScreenPoint(effectPos.position);
			Vector4 vector2 = mainCamera.ScreenToWorldPoint(vector.NewZ(cameraEffectDistanceToCamera));
			vector2.w = 1f;
			currentEffect.transform.localPosition = mainCamera.transform.worldToLocalMatrix * vector2;
			float num = (float)baseHeight / (rootCanvas.transform as RectTransform).rect.height;
			float num2 = Mathf.Tan(MathF.PI / 180f * mainCamera.fieldOfView * 0.5f) / Mathf.Tan(MathF.PI / 180f * baseFov * 0.5f);
			num *= num2;
			currentEffect.transform.localScale = new Vector3(num, num, num);
			currentEffect.transform.localRotation = Quaternion.identity;
		}
	}

	private void LateUpdate()
	{
		SetCameraEffectPos();
	}
}
