using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;

public class AbilityButtonEffect : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public string CD_RERESH_EFFECT_PATH = "UI/BattlePanelEffect/CDRefresh_Skill";

	public string SWITCH_ABILITY_EFFECT_PATH = "UI/BattlePanelEffect/Switching_Skill";

	public string RELEASE_ABILITY_EFFECT_PATH = "UI/BattlePanelEffect/Release_Skill";

	public string RESERVE_ABILITY_EFFECT_PATH = "UI/BattlePanelEffect/Reserve_Skill";

	public bool ShowCDRefreshEffect = true;

	public bool ShowSwitchAbilityEffect = true;

	public bool ShowReleaseEffect;

	public bool ShowReserveEffect;

	private ButtonType _buttonType;

	private bool _isClick;

	private bool _isPress;

	private bool _isEnable = true;

	public PlayableDirector CDRefreshTimeline { get; set; }

	public PlayableDirector SwitchTimeline { get; set; }

	public PlayableDirector ReleaseTimeline { get; set; }

	public PlayableDirector ReserveTimeline { get; set; }

	private void Awake()
	{
		_buttonType = GetComponent<AttackButton>().ButtonType;
		CDRefreshTimeline = LoadTimeline(CD_RERESH_EFFECT_PATH);
		SwitchTimeline = LoadTimeline(SWITCH_ABILITY_EFFECT_PATH);
		ReleaseTimeline = LoadTimeline(RELEASE_ABILITY_EFFECT_PATH);
		ReserveTimeline = LoadTimeline(RESERVE_ABILITY_EFFECT_PATH);
		AbilityButtonsUI componentInParent = GetComponentInParent<AbilityButtonsUI>();
		if (null != CDRefreshTimeline)
		{
			componentInParent.OnCompleteCD = (Action<int>)Delegate.Combine(componentInParent.OnCompleteCD, new Action<int>(OnCDRefresh));
		}
		if (null != SwitchTimeline)
		{
			componentInParent.OnAbilityChange = (Action<int, int, int>)Delegate.Combine(componentInParent.OnAbilityChange, new Action<int, int, int>(OnSwitchAbility));
		}
		componentInParent.OnBeginCD = (Action<int>)Delegate.Combine(componentInParent.OnBeginCD, new Action<int>(OnBeginCD));
	}

	private void OnBeginCD(int id)
	{
		if (id == (int)_buttonType)
		{
			_isEnable = false;
		}
	}

	private void OnCDRefresh(int id)
	{
		if (id == (int)_buttonType && null != CDRefreshTimeline && ShowCDRefreshEffect)
		{
			PlayTimeline(CDRefreshTimeline);
			_isEnable = true;
		}
	}

	private void OnSwitchAbility(int id, int oldAbility, int newAbility)
	{
		if (id == (int)_buttonType && null != SwitchTimeline && ShowSwitchAbilityEffect)
		{
			PlayTimeline(SwitchTimeline);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (null != ReleaseTimeline && !_isClick && _isEnable && ShowReleaseEffect)
		{
			PlayTimeline(ReleaseTimeline);
			_isClick = true;
		}
		if (null != ReserveTimeline && ShowReserveEffect)
		{
			PlayTimeline(ReserveTimeline);
			_isPress = true;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (_isPress && null != ReserveTimeline)
		{
			StopTimeline(ReserveTimeline);
		}
	}

	private void OnTimelineStop(PlayableDirector playableDirector)
	{
		if (ReleaseTimeline == playableDirector)
		{
			_isClick = false;
		}
		if (playableDirector == ReserveTimeline)
		{
			_isPress = false;
		}
		playableDirector.gameObject.SetActive(value: false);
	}

	private static void PlayTimeline(PlayableDirector playableDirector)
	{
		playableDirector.gameObject.SetActive(value: true);
		playableDirector.time = 0.0;
		playableDirector.Play();
	}

	private static void StopTimeline(PlayableDirector playableDirector)
	{
		playableDirector.Stop();
		playableDirector.gameObject.SetActive(value: false);
	}

	public PlayableDirector LoadTimeline(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			return null;
		}
		GameObject gameObject = Asset.Instantiate(path);
		if (null == gameObject)
		{
			Debug.LogError("无法加载按钮特效" + path);
			return null;
		}
		gameObject.transform.SetParent(base.transform, worldPositionStays: false);
		PlayableDirector componentInChildren = gameObject.GetComponentInChildren<PlayableDirector>(includeInactive: true);
		if (componentInChildren == null)
		{
			Debug.LogError("path: " + path + " 's PlayableDirector dont exsit!!");
			return componentInChildren;
		}
		StopTimeline(componentInChildren);
		componentInChildren.stopped += OnTimelineStop;
		return componentInChildren;
	}
}
