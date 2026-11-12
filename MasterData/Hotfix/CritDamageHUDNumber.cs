using UnityEngine;

[DisallowMultipleComponent]
[RequireComponent(typeof(HUDNumber))]
public class CritDamageHUDNumber : MonoBehaviour
{
	private HUDNumber _hud;

	private bool _callHoldOnce;

	private void Awake()
	{
		_hud = GetComponent<HUDNumber>();
	}

	private void OnEnable()
	{
		_hud.TextFinish += OnTextFinish;
		_hud.TextFadeIn += OnTextFadeIn;
	}

	private void OnDisable()
	{
		_hud.TextFinish -= OnTextFinish;
		_hud.TextFadeIn -= OnTextFadeIn;
	}

	private void OnRefreshValue()
	{
		_callHoldOnce = false;
	}

	private void OnTextFinish(float dt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("HudDestroy", _hud.Id);
	}

	private void OnTextFadeIn(float dt)
	{
		float fadeInNormalizedTime = _hud.GetFadeInNormalizedTime(dt);
		_hud.TextFadeInUpdate(dt, fadeInNormalizedTime);
	}
}
