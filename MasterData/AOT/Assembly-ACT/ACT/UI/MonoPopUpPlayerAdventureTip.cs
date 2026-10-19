using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonoPopUpPlayerAdventureTip : BaseUIComponent, IBattleMainComponent
{
	public class ExpChangeData
	{
		public int beforeLevel;

		public int addExp;

		public long beforeExp;

		public long currentExp;

		public int currentLevel;

		public bool isWorldLevel;
	}

	private enum PlayState
	{
		Idle,
		Show,
		Filling,
		LevelUp,
		Hide
	}

	private readonly int AnimShow = Animator.StringToHash("PlayAdventureLvShow");

	private readonly int AnimLevelUp = Animator.StringToHash("PlayAdventureLvUp");

	private readonly int AnimHide = Animator.StringToHash("PlayAdventureLvHide");

	private readonly int AnimLevelUpHide = Animator.StringToHash("LevelUpHide");

	public TextMeshProUGUI adventureRemainExp;

	public TextMeshProUGUI adventureTotalExp;

	public TargetValueMaskBar expSlider;

	public TextMeshProUGUI addExp;

	public CanvasGroup canvasGroup;

	public CanvasGroup expCanvasGroup;

	public Color expBeforeAddColor;

	public Color expOnAddColor;

	public CanvasGroup sliderCanvasGroup;

	public Animator animator;

	[Header("玩家等级相关")]
	public TextMeshProUGUI playerLevelText;

	public TextMeshProUGUI playerLevelUpText;

	private ExpChangeData _data;

	private PlayState _state;

	private bool _isLevelUp;

	private bool _playedLevelUp;

	private int _oldMaxExp;

	private int _newMaxExp;

	private int _segmentMaxExp;

	private int _countStartExp;

	private int _countTargetExp;

	private int _lastDisplayExp = int.MinValue;

	private bool _isCounting;

	public bool isShowing { get; private set; }

	public void Init(ExpChangeData data, Action openFail)
	{
		try
		{
			StopPlay();
			if (data == null)
			{
				openFail?.Invoke();
				gameObject.SetActive(value: false);
				return;
			}
			isShowing = true;
			onClose = () =>
			{
				Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.Top);
			};
			if (data.isWorldLevel)
			{
				UnInit();
			}
			else
			{
				StartGainExp(data);
			}
		}
		catch (Exception arg)
		{
			StopPlay();
			isShowing = false;
			onClose = null;
			openFail?.Invoke();
			gameObject.SetActive(value: false);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"玩家经验打开失败：{arg}");
			}
		}
	}

	public void UnInit()
	{
		StopPlay();
		isShowing = false;
		onClose?.Invoke();
		onClose = null;
		gameObject.SetActive(value: false);
	}

	private void StopPlay()
	{
		_state = PlayState.Idle;
		_isCounting = false;
		_data = null;
		_lastDisplayExp = int.MinValue;
		_playedLevelUp = false;
	}

	private void StartGainExp(ExpChangeData data)
	{
		_data = data;
		_isLevelUp = data.currentLevel != data.beforeLevel;
		_playedLevelUp = false;
		PlayerLevelData data2 = CoreUtils.GetData(_isLevelUp ? data.beforeLevel : data.currentLevel, RuntimeConfigs.data.playerLevelDatas);
		PlayerLevelData playerLevelData = (_isLevelUp ? CoreUtils.GetData(data.currentLevel, RuntimeConfigs.data.playerLevelDatas) : data2);
		_oldMaxExp = data2.xpEachLv;
		_newMaxExp = playerLevelData.xpEachLv;
		canvasGroup.alpha = 1f;
		expCanvasGroup.alpha = 1f;
		sliderCanvasGroup.alpha = 1f;
		if (_isLevelUp)
		{
			playerLevelText.SetText(data.beforeLevel.FastToString());
			playerLevelUpText.SetText(data.currentLevel.FastToString());
		}
		else
		{
			playerLevelText.SetText(data.currentLevel.FastToString());
		}
		addExp.SetText(data.addExp.FastToString());
		adventureTotalExp.SetText(_oldMaxExp.FastToString());
		int num = (int)data.beforeExp;
		SetDisplayExp(num, isOnAdd: false);
		expSlider.Value = ToBarValue(num, _oldMaxExp);
		expSlider.SetTargetImmediate(expSlider.Value);
		PrepareCount(num, (int)(_isLevelUp ? _oldMaxExp : data.currentExp), _oldMaxExp);
		_state = PlayState.Show;
		gameObject.SetActive(value: true);
		animator.Play(AnimShow);
	}

	private void SwitchToNewLevel()
	{
		adventureTotalExp.SetText(_newMaxExp.FastToString());
		playerLevelUpText.SetText(_data.currentLevel.FastToString());
		expSlider.Value = 0f;
		SetDisplayExp(0, isOnAdd: true);
		PrepareCount(0, (int)_data.currentExp, _newMaxExp);
		expSlider.SetTargetImmediate(ToBarValue(_countTargetExp, _segmentMaxExp));
	}

	private void PrepareCount(int fromExp, int toExp, int maxExp)
	{
		_countStartExp = fromExp;
		_countTargetExp = toExp;
		_segmentMaxExp = maxExp;
	}

	private void ApplyWhiteBar()
	{
		expSlider.SetTargetImmediate(ToBarValue(_countTargetExp, _segmentMaxExp));
	}

	private void StartFillMotion()
	{
		ApplyWhiteBar();
		adventureRemainExp.color = expOnAddColor;
		_isCounting = _countStartExp != _countTargetExp && expSlider.duration > 0f;
		if (!_isCounting)
		{
			SetDisplayExp(_countTargetExp, isOnAdd: true);
		}
		expSlider.PlayValueToTarget();
		_state = PlayState.Filling;
		if (!_isCounting && expSlider.ChangeFinish)
		{
			OnFillFinished();
		}
	}

	private void OnFillFinished()
	{
		if (_state == PlayState.Filling)
		{
			if (_isLevelUp && !_playedLevelUp)
			{
				_playedLevelUp = true;
				_state = PlayState.LevelUp;
				SwitchToNewLevel();
				animator.Play(AnimLevelUp);
			}
			else
			{
				PlayHide();
			}
		}
	}

	private void PlayHide()
	{
		_state = PlayState.Hide;
		animator.Play(_isLevelUp ? AnimLevelUpHide : AnimHide);
	}

	private float ToBarValue(int exp, int maxExp)
	{
		if (maxExp <= 0)
		{
			return 0f;
		}
		return Mathf.Clamp01((float)exp / (float)maxExp);
	}

	private void Update()
	{
		if (_state != PlayState.Filling)
		{
			return;
		}
		if (_isCounting)
		{
			float a = ToBarValue(_countStartExp, _segmentMaxExp);
			float b = ToBarValue(_countTargetExp, _segmentMaxExp);
			float t = (Mathf.Approximately(a, b) ? 1f : Mathf.Clamp01(Mathf.InverseLerp(a, b, expSlider.Value)));
			int exp = (expSlider.ChangeFinish ? _countTargetExp : Mathf.RoundToInt(Mathf.Lerp(_countStartExp, _countTargetExp, t)));
			SetDisplayExp(exp, isOnAdd: true);
			if (expSlider.ChangeFinish)
			{
				_isCounting = false;
			}
		}
		if (!_isCounting && expSlider.ChangeFinish)
		{
			OnFillFinished();
		}
	}

	private void SetDisplayExp(int exp, bool isOnAdd)
	{
		exp = Mathf.Max(0, exp);
		adventureRemainExp.color = (isOnAdd ? expOnAddColor : expBeforeAddColor);
		if (exp != _lastDisplayExp)
		{
			_lastDisplayExp = exp;
			adventureRemainExp.SetText(exp.FastToString());
			if (_isCounting)
			{
				PlayExpSliderChangeSound();
			}
		}
	}

	public void OnAddExpSlideStart()
	{
		if (_state == PlayState.Show)
		{
			ApplyWhiteBar();
		}
	}

	public void OnAddExpSlideEnd()
	{
		if (_state == PlayState.Show)
		{
			StartFillMotion();
		}
	}

	public void OnLevelUpAnimEnd()
	{
		if (_state == PlayState.LevelUp)
		{
			StartFillMotion();
		}
	}

	public void OnHideAnimEnd()
	{
		if (_state == PlayState.Hide)
		{
			UnInit();
		}
	}

	public void PlayLevelUpSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Level_Up");
	}

	public void PlayAddExpSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Get_Experience");
	}

	public void PlayHideSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/LevelUpClose");
	}

	private void PlayExpSliderChangeSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Get_Experience_Scroll");
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		int exp = (int)G.detailUserInfo.Attributes[93];
		int playerLevel = SystemUnlockManager.playerLevel;
		if (RuntimeConfigs.data.playerLevelDatas.TryGetValue(playerLevel, out var value))
		{
			float num = ToBarValue(exp, value.xpEachLv);
			expSlider.Value = num;
			expSlider.SetTargetImmediate(num);
		}
		else
		{
			Debug.LogError("【请检查】玩家等级配置表中没有找到当前玩家等级数据，等级[" + playerLevel + "]的配置，请检查配置表！");
		}
	}

	public void UnInitialize()
	{
		if (isShowing)
		{
			UnInit();
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
