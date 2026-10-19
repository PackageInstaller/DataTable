using System;
using ACT.Battle;
using ACT.Config;
using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ExtraDestinyComp : DestinyBtnBase
{
	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private BetterAnimation _anim;

	private int _destinyId;

	private bool _selfActive;

	private Action<bool> _controlDestinyMaxBGM;

	public void Init(CharacterConstellationData destinyData, bool active, int activeDestinyCount, Action<int, bool> selectDestiny, Action<bool> controlDestinyMaxBGM)
	{
		_destinyId = destinyData.id;
		_selectDestiny = selectDestiny;
		_controlDestinyMaxBGM = controlDestinyMaxBGM;
		InitDisplay(active);
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(Select);
		SetSelectState(active: false);
	}

	private void InitDisplay(bool active)
	{
		_anim?.GetSequence(active ? "ActiveShow" : "GreyShow").OnComplete((AnimationBuilder _) =>
		{
			_selfActive = active;
			GameObject[] array = activeGos;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(active);
			}
			array = inactiveGos;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(!active);
			}
		}).Play();
	}

	public void SetState(bool active, bool isASide, Action onStateChange)
	{
		if (_selfActive == active)
		{
			return;
		}
		_anim?.GetSequence(active ? "Unlock" : "GreyStatus").OnAnimationPlay((AnimationBuilder _) =>
		{
			if (active)
			{
				if (isASide)
				{
					PlayASideDestinyActiveSound();
				}
				else
				{
					PlayBSideDestinyActiveSound();
				}
			}
			else if (!isASide)
			{
				_controlDestinyMaxBGM?.Invoke(obj: false);
			}
		}).OnComplete((AnimationBuilder _) =>
		{
			_selfActive = active;
			onStateChange?.Invoke();
			GameObject[] array = activeGos;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(active);
			}
			array = inactiveGos;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(!active);
			}
		})
			.Play();
	}

	public override void Select()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/Click");
		_selectDestiny(_destinyId, arg2: false);
		SetSelectState(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void PlayASideDestinyActiveSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/ActiveSideA");
	}

	public void PlayBSideDestinyActiveSound()
	{
		Action<bool> controlDestinyMaxBGM = _controlDestinyMaxBGM;
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/GlowingStage/ActiveSideB", new AudioPlayOptions
		{
			onCompleteCallback = () =>
			{
				controlDestinyMaxBGM?.Invoke(obj: true);
			}
		});
	}
}
