using System.Collections;
using Ase.ECS;
using Coffee.UIExtensions;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HPBarItem : EntityInfoBase
{
	[SerializeField]
	private float _hideDuration = 1f;

	[SerializeField]
	private float _hpDelayTime = 0.5f;

	[SerializeField]
	private float _hpDuration = 1f;

	[SerializeField]
	private float _tenacityDelayTime = 0.5f;

	[SerializeField]
	private float _tenacityDuration = 1f;

	[SerializeField]
	private Image m_HPBar;

	[SerializeField]
	private Image _HPBar;

	[SerializeField]
	private Image m_ShieldBar;

	[SerializeField]
	private Image m_TenacityBar;

	[SerializeField]
	private Image _TenacityBar;

	[SerializeField]
	private TextMeshProUGUI m_level;

	[SerializeField]
	private TextMeshProUGUI m_levelShow;

	[SerializeField]
	private Image downTenacityImage;

	[SerializeField]
	private RectTransform downTenacityEff;

	[SerializeField]
	private float _hideBarTime = 0.5f;

	[SerializeField]
	private AutoDispose downOverEffect;

	[SerializeField]
	private UIParticle downOverUIParticle;

	[SerializeField]
	private float downOverShowTime = 0.1f;

	[SerializeField]
	private AutoDispose hitHpEffect;

	[SerializeField]
	private UIParticle hitHpUIParticle;

	[SerializeField]
	private float hitHpShowTime = 0.1f;

	[SerializeField]
	private AutoDispose hitTenacityEffect;

	[SerializeField]
	private UIParticle hitTenacityUIParticle;

	[SerializeField]
	private float hitTenacityShowTime = 0.1f;

	[SerializeField]
	private Animation damageRatioAni;

	[SerializeField]
	private TextMeshProUGUI damageRatioText1;

	[SerializeField]
	private TextMeshProUGUI damageRatioText2;

	private HpBarData viewModel = new HpBarData();

	private float lastHP = -1f;

	private float lastShield = -1f;

	private Tween tweenHp;

	private Tween tweenTenacity;

	private Tween tweenHide;

	private float HandleWidth;

	private RectTransform _hpBarRect;

	private RectTransform _tenacityRect;

	private Animator animator;

	public override void Init(Camera barCamera, Canvas infoCanvas)
	{
		if (downOverEffect != null)
		{
			downOverEffect.AddDisposeAction(delegate(GameObject e)
			{
				e.SetActive(value: false);
			});
			downOverEffect.time = downOverShowTime;
		}
		base.Init(barCamera, infoCanvas);
		BindingSet<HPBarItem, HpBarData> bindingSet = this.CreateBindingSet(viewModel);
		if (m_HPBar != null)
		{
			bindingSet.Bind(m_HPBar).For((Image v) => v.fillAmount).ToExpression((HpBarData vm) => Mathf.Clamp(vm.CurHp / vm.MaxHp, 0f, 1f));
		}
		if (m_TenacityBar != null)
		{
			bindingSet.Bind(m_TenacityBar).For((Image v) => v.fillAmount).ToExpression((HpBarData vm) => Mathf.Clamp(vm.CurShield / vm.MaxShield, 0f, 1f));
		}
		if (_HPBar != null)
		{
			bindingSet.Bind(_HPBar).For((Image v) => v.fillAmount).ToExpression((HpBarData vm) => Mathf.Clamp((vm.LaterHp - vm.CurHp) / vm.MaxHp, 0f, 1f));
		}
		if (_TenacityBar != null)
		{
			bindingSet.Bind(_TenacityBar).For((Image v) => v.fillAmount).ToExpression((HpBarData vm) => Mathf.Clamp((vm.LaterShield - vm.CurShield) / vm.MaxShield, 0f, 1f));
		}
		if (downTenacityImage != null)
		{
			bindingSet.Bind(downTenacityImage).For((Image v) => v.fillAmount).ToExpression((HpBarData vm) => Mathf.Clamp(vm.CurShield / vm.MaxShield, 0f, 1f));
		}
		bindingSet.Build();
		((TMP_Text)m_level).text = string.Empty;
		((TMP_Text)m_levelShow).text = string.Empty;
		if ((bool)_HPBar)
		{
			_hpBarRect = _HPBar.GetComponent<RectTransform>();
		}
		if ((bool)_TenacityBar)
		{
			_tenacityRect = _TenacityBar.GetComponent<RectTransform>();
		}
		Image image = ((_HPBar == null) ? _TenacityBar : _HPBar);
		if (image != null)
		{
			HandleWidth = image.GetComponent<RectTransform>().rect.width;
		}
		hitHpEffect?.AddDisposeAction(delegate(GameObject e)
		{
			e.SetActive(value: false);
		});
		hitTenacityEffect?.AddDisposeAction(delegate(GameObject e)
		{
			e.SetActive(value: false);
		});
		animator = GetComponent<Animator>();
	}

	public void InitData(BaseEntity mBaseEntity)
	{
		Ase.ECS.PropertyData propertyData = mBaseEntity.EntityViewModel.Property["Hp"];
		Ase.ECS.PropertyData propertyData2 = mBaseEntity.EntityViewModel.Property["Tenacity"];
		lastHP = propertyData.CurValue;
		lastShield = propertyData2.CurValue;
		viewModel.UpdateData(propertyData.CurValue, propertyData.MaxValue, propertyData2.CurValue, propertyData2.MaxValue);
		viewModel.UpdateLaterHp(lastHP);
		viewModel.UpdateLaterShield(lastShield);
	}

	public void UpdateData(float hp, float hpMax, float shield, float shieldMax)
	{
		if (lastHP != hp || lastShield != shield)
		{
			if ((bool)_HPBar || (bool)_TenacityBar)
			{
				StopAllCoroutines();
				Executors.RunOnCoroutine(DelayDoTween(hp, shield));
			}
			viewModel.UpdateData(hp, hpMax, shield, shieldMax);
			if ((bool)_hpBarRect)
			{
				_hpBarRect.anchoredPosition = new Vector2(HandleWidth * hp / hpMax, _hpBarRect.anchoredPosition.y);
			}
			if ((bool)_tenacityRect)
			{
				_tenacityRect.anchoredPosition = new Vector2(HandleWidth * shield / shieldMax, _tenacityRect.anchoredPosition.y);
			}
			if ((bool)downTenacityEff && downTenacityEff.gameObject.activeInHierarchy)
			{
				downTenacityEff.anchoredPosition = new Vector2(HandleWidth * shield / shieldMax, downTenacityEff.anchoredPosition.y);
			}
			if (lastHP > hp || lastShield > shield)
			{
				SetEffectAutoDis(hitHpEffect, hitHpUIParticle, hitHpShowTime);
				SetEffectAutoDis(hitTenacityEffect, hitTenacityUIParticle, hitTenacityShowTime);
			}
			lastHP = hp;
			lastShield = shield;
		}
	}

	public void UpdateData(int actionValue)
	{
		viewModel.UpdateData(actionValue);
	}

	public void ShowBar()
	{
		if (tweenHide != null && tweenHide.IsPlaying())
		{
			tweenHide.Kill();
			tweenHide = null;
		}
		if (!base.gameObject.activeSelf)
		{
			CanvasGroup component = GetComponent<CanvasGroup>();
			if ((bool)(Object)(object)component)
			{
				component.alpha = 1f;
			}
			base.gameObject.SetActive(value: true);
			if ((bool)(Object)(object)animator)
			{
				animator.Play("Show", -1, 0f);
			}
		}
	}

	public void HideBar()
	{
		if ((tweenHide != null && tweenHide.IsPlaying()) || !base.gameObject.activeSelf)
		{
			return;
		}
		CanvasGroup canvas = GetComponent<CanvasGroup>();
		if (!(Object)(object)canvas)
		{
			base.gameObject.SetActive(value: false);
			return;
		}
		tweenHide = DOTween.To(() => canvas.alpha, delegate(float v)
		{
			canvas.alpha = v;
		}, 0f, _hideDuration).OnComplete(delegate
		{
			base.gameObject.SetActive(value: false);
			tweenHide = null;
		}).SetEase(Ease.OutSine);
	}

	public override void Remove()
	{
		string text = "Remove";
		if ((bool)(Object)(object)animator)
		{
			animator.Play(text, -1, 0f);
		}
		WaitAni();
	}

	private async void WaitAni()
	{
		await UniTask.WaitForSeconds(_hideBarTime);
		Recovery();
	}

	public override void Recovery()
	{
		base.gameObject.SetActive(value: false);
		CanvasGroup component = GetComponent<CanvasGroup>();
		if ((bool)(Object)(object)component)
		{
			component.alpha = 1f;
		}
		tweenHp.Kill();
		tweenTenacity.Kill();
		tweenHide.Kill();
		tweenHp = null;
		tweenTenacity = null;
		tweenHide = null;
		if (m_HPBar != null)
		{
			m_HPBar.fillAmount = 1f;
		}
		if (_HPBar != null)
		{
			_HPBar.fillAmount = 0f;
		}
		if (m_TenacityBar != null)
		{
			m_TenacityBar.enabled = true;
			m_TenacityBar.fillAmount = 1f;
		}
		if (_TenacityBar != null)
		{
			_TenacityBar.enabled = true;
			_TenacityBar.fillAmount = 0f;
		}
		if (downTenacityImage != null)
		{
			downTenacityImage.gameObject.SetActive(value: false);
			downTenacityImage.fillAmount = 0f;
		}
		if (downOverEffect != null)
		{
			downOverEffect.gameObject.SetActive(value: false);
		}
		((TMP_Text)m_level).text = string.Empty;
		((TMP_Text)m_levelShow).text = string.Empty;
		base.Recovery();
		StopAllCoroutines();
	}

	public void ShowLevel(int monsterLevel)
	{
		((TMP_Text)m_level).text = "Lv." + monsterLevel;
		((TMP_Text)m_levelShow).text = "Lv." + monsterLevel;
	}

	public void SetDownState(bool downState, string damageRatio)
	{
		if (m_TenacityBar != null)
		{
			m_TenacityBar.enabled = !downState;
		}
		if (_TenacityBar != null)
		{
			_TenacityBar.enabled = !downState;
		}
		if (downTenacityImage != null)
		{
			downTenacityImage.gameObject.SetActive(downState);
		}
		if ((Object)(object)damageRatioAni != null)
		{
			if (downState)
			{
				((Component)(object)damageRatioAni).gameObject.SetActive(value: true);
				damageRatioAni.Play("emg_enter");
				((TMP_Text)damageRatioText1).text = damageRatio;
				((TMP_Text)damageRatioText2).text = damageRatio;
			}
			else
			{
				damageRatioAni.Play("emg_out");
			}
		}
		if (!downState && !(downOverEffect == null))
		{
			if (downOverEffect.gameObject.activeSelf)
			{
				downOverEffect.ResetTime(downOverShowTime);
				downOverUIParticle.Play();
			}
			else
			{
				downOverEffect.gameObject.SetActive(value: true);
			}
		}
	}

	private void SetEffectAutoDis(AutoDispose autoDispose, UIParticle particle, float time)
	{
		if (!autoDispose)
		{
			return;
		}
		autoDispose.ResetTime(time);
		if (autoDispose.gameObject.activeSelf)
		{
			if ((bool)(Object)(object)particle)
			{
				particle.Play();
			}
		}
		else
		{
			autoDispose.gameObject.SetActive(value: true);
		}
	}

	private IEnumerator DelayDoTween(float curHp, float curTenacity)
	{
		if (tweenHp != null)
		{
			tweenHp.Kill();
			tweenHp = null;
		}
		if (tweenTenacity != null)
		{
			tweenTenacity.Kill();
			tweenTenacity = null;
		}
		if (_hpDelayTime > _tenacityDelayTime)
		{
			yield return new WaitForSeconds(_tenacityDelayTime);
			DoTweenTenacity(curTenacity);
			yield return new WaitForSeconds(_hpDelayTime - _tenacityDelayTime);
			DoTweenHp(curHp);
		}
		else if (_hpDelayTime < _tenacityDelayTime)
		{
			yield return new WaitForSeconds(_hpDelayTime);
			DoTweenHp(curHp);
			yield return new WaitForSeconds(_tenacityDelayTime - _hpDelayTime);
			DoTweenTenacity(curTenacity);
		}
		else if (_hpDelayTime == _tenacityDelayTime)
		{
			yield return new WaitForSeconds(_hpDelayTime);
			DoTweenHp(curHp);
			DoTweenTenacity(curTenacity);
		}
	}

	private void DoTweenHp(float cur)
	{
		if ((bool)_HPBar)
		{
			tweenHp = DOTween.To(() => viewModel.LaterHp, delegate(float v)
			{
				viewModel.UpdateLaterHp(v);
			}, cur, _hpDuration).OnComplete(delegate
			{
				tweenHp = null;
			}).SetEase(Ease.OutSine);
		}
	}

	private void DoTweenTenacity(float cur)
	{
		if ((bool)_TenacityBar)
		{
			tweenTenacity = DOTween.To(() => viewModel.LaterShield, delegate(float v)
			{
				viewModel.UpdateLaterShield(v);
			}, cur, _tenacityDuration).OnComplete(delegate
			{
				tweenTenacity = null;
			}).SetEase(Ease.OutSine);
		}
	}
}
