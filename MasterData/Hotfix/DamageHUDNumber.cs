using UnityEngine;

[DisallowMultipleComponent]
[RequireComponent(typeof(HUDNumber))]
public class DamageHUDNumber : MonoBehaviour
{
	public bool randomFadeOutTranslate;

	private float _animationRandomDistance;

	private float _animationRandomHeight;

	private HUDNumber _hud;

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
		if (randomFadeOutTranslate)
		{
			if (_hud.randomArrow == 0)
			{
				_animationRandomDistance = Random.Range(-2.5f, 2.5f);
			}
			else if (_hud.randomArrow == 1)
			{
				_animationRandomDistance = Random.Range(0f, 2.5f);
			}
			else
			{
				_animationRandomDistance = Random.Range(-2.5f, 0f);
			}
			_animationRandomHeight = Random.Range(0.5f, 1.5f);
		}
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
