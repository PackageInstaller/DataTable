using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BossCustomUI : MonoBehaviour
{
	[SerializeReference]
	private BossBloodBar bloodBar;

	public CanvasGroup canvasGroup;

	public LocalizeStringEvent monsterName;

	public LocalizeStringEvent designation;

	public TextMeshProUGUI level;

	public TargetValueMaskBar bloodbar;

	public TargetValueMaskBar postureBarL;

	public TargetValueMaskBar postureBarR;

	public TargetValueMaskBar weakBar;

	public TargetValueMaskBar burstBarL;

	public TargetValueMaskBar burstBarR;

	public TextMeshProUGUI damageMultiplier;

	public Renderer[] burstEffectRenderers;

	public Animation bloodHitAnimation;

	public Animation postureHitAnimationL;

	public Animation postureHitAnimationR;

	public Animation burstHitAnimationL;

	public Animation burstHitAnimationR;

	public PercentParticle bloodParticle;

	public PercentParticle postureParticleL;

	public PercentParticle postureParticleR;

	public PercentParticle postureParticleLitL;

	public PercentParticle postureParticleLitR;

	public PercentParticle burstParticleL;

	public PercentParticle burstParticleR;

	public PercentParticle burstParticleLitL;

	public PercentParticle burstParticleLitR;

	[Header("Animator Param")]
	public Animator animator;

	public string postureParam;

	public string weakParam;

	public string burstParam;

	public string postureChangeTrigger;

	public bool enableAttackPercentRefresh = true;

	public float attackPercentRefreshDelay = 0.03f;

	private const float m_WaitTime = 3f;

	private Entity m_Attackee;

	private List<string> m_BloodAniNames;

	private List<string> m_PostureAniNameL;

	private List<string> m_PostureAniNameR;

	private List<string> m_BurstAniNameL;

	private List<string> m_BurstAniNameR;

	private bool m_Init;

	private bool m_IsWeak;

	private int m_BloodDamageType;

	private int m_PostureDamageType;

	private MaterialPropertyBlock m_Mpb;

	public Entity currentBossEntityBehave { get; private set; }

	private void InitData()
	{
		m_BloodAniNames = ListPool<string>.Get();
		m_PostureAniNameL = ListPool<string>.Get();
		foreach (AnimationState item in postureHitAnimationL)
		{
			m_PostureAniNameL.Add(item.name);
		}
		m_PostureAniNameR = ListPool<string>.Get();
		foreach (AnimationState item2 in postureHitAnimationR)
		{
			m_PostureAniNameR.Add(item2.name);
		}
		m_BurstAniNameL = ListPool<string>.Get();
		foreach (AnimationState item3 in burstHitAnimationL)
		{
			m_BurstAniNameL.Add(item3.name);
		}
		m_BurstAniNameR = ListPool<string>.Get();
		foreach (AnimationState item4 in burstHitAnimationR)
		{
			m_BurstAniNameR.Add(item4.name);
		}
		m_Mpb = new MaterialPropertyBlock();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnCharacterChange);
		m_Init = true;
	}

	public void InitHpBloodBar(Entity attackee, AttackData attackData = null)
	{
		if (m_Attackee.IsValid)
		{
			if (attackee == m_Attackee)
			{
				return;
			}
			OnExit(m_Attackee);
		}
		if (!m_Init)
		{
			InitData();
		}
		m_Attackee = attackee;
		if (attackee.GetEntityType() == EntityType.Boss)
		{
			currentBossEntityBehave = attackee;
		}
		gameObject.SetActive(value: true);
		EntityData entityData = RuntimeConfigs.data.entityDatas[attackee.GetCompMonster().id];
		CompAbility compAbility = attackee.GetCompAbility();
		if ((object)designation != null)
		{
			designation.gameObject.SetActive(value: true);
			designation.StringReference.TableEntryReference = entityData.descriptionLocal;
		}
		monsterName.StringReference.TableEntryReference = entityData.nameLocal;
		level.SetText("{0:0}", compAbility.level);
		TargetValueMaskBar targetValueMaskBar = bloodbar;
		float value = (bloodbar.TargetValue = (float)compAbility.hp / (float)compAbility.maxHP);
		targetValueMaskBar.Value = value;
		compAbility.onCharacterDamageHit = (Action<Entity, int>)Delegate.Combine(compAbility.onCharacterDamageHit, new Action<Entity, int>(OnCharacterDamageTypeChange));
		compAbility.onActivePostureChange = (Action<Entity, bool>)Delegate.Combine(compAbility.onActivePostureChange, new Action<Entity, bool>(RefreshPostureBarActive));
		RefreshPostureBarActive(attackee, compAbility.IsHavePosture);
		compAbility.onHPChange += new Action<int, int>(RefreshMonsterBloodBar);
	}

	private void Update()
	{
	}

	private void RefreshMonsterBloodBar(int value, int newValue)
	{
		CompAbility compAbility = m_Attackee.GetCompAbility();
		bloodbar.TargetValue = (float)newValue / (float)compAbility.maxHP;
		if (m_BloodDamageType == 1 && (compAbility.IsWeak || !compAbility.IsHavePosture))
		{
			BloodEffect(value - newValue);
		}
	}

	private void RefreshPostureBar(Entity eb, int value, int newValue)
	{
		CompAbility compAbility = m_Attackee.GetCompAbility();
		float num = (float)newValue / (float)compAbility.maxPosture;
		TargetValueMaskBar targetValueMaskBar = burstBarL;
		float targetValue = (postureBarL.TargetValue = num);
		targetValueMaskBar.TargetValue = targetValue;
		TargetValueMaskBar targetValueMaskBar2 = burstBarR;
		targetValue = (postureBarR.TargetValue = num);
		targetValueMaskBar2.TargetValue = targetValue;
		m_Mpb.SetFloat(BattleConsts.SHADER_EFFECT_DISSOLVE_CUT, 1f - num);
		Renderer[] array = burstEffectRenderers;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetPropertyBlock(m_Mpb);
		}
		CompAbility compAbility2 = compAbility;
		if (m_PostureDamageType == 2 && !compAbility2.IsWeak && compAbility2.IsHavePosture)
		{
			PostureEffect(value - newValue);
		}
		if (newValue <= 0)
		{
			if (compAbility.WeakTime < 0f)
			{
				return;
			}
			weakBar.Value = 1f;
			if (damageMultiplier != null)
			{
				damageMultiplier.SetText("{0:0.##}", (1f + m_Attackee.GetConfig().postureDmgIncrease) * 100f);
			}
		}
		else if (m_IsWeak)
		{
			m_IsWeak = false;
		}
		animator.SetBool(weakParam, compAbility2.IsWeak);
	}

	private void RefreshPostureBarActive(Entity eb, bool active)
	{
		CompAbility compAbility = m_Attackee.GetCompAbility();
		if (active)
		{
			compAbility.onPostureChange = (Action<Entity, int, int>)Delegate.Combine(compAbility.onPostureChange, new Action<Entity, int, int>(RefreshPostureBar));
			compAbility.onPostureBurstChange = (Action<Entity, bool>)Delegate.Combine(compAbility.onPostureBurstChange, new Action<Entity, bool>(RefreshPostureBarBurst));
			compAbility.onRevivePostureProgressChange = (Action<Entity, float, float>)Delegate.Combine(compAbility.onRevivePostureProgressChange, new Action<Entity, float, float>(RefreshWeakBar));
			RefreshPostureBar(eb, compAbility.posture, compAbility.posture);
			RefreshPostureBarBurst(eb, compAbility.IsPostureBurst);
			bloodParticle.Stop();
			postureParticleL.Stop();
			postureParticleR.Stop();
			postureParticleLitL.Stop();
			postureParticleLitR.Stop();
		}
		else
		{
			compAbility.onPostureChange = (Action<Entity, int, int>)Delegate.Remove(compAbility.onPostureChange, new Action<Entity, int, int>(RefreshPostureBar));
			compAbility.onPostureBurstChange = (Action<Entity, bool>)Delegate.Remove(compAbility.onPostureBurstChange, new Action<Entity, bool>(RefreshPostureBarBurst));
			compAbility.onRevivePostureProgressChange = (Action<Entity, float, float>)Delegate.Remove(compAbility.onRevivePostureProgressChange, new Action<Entity, float, float>(RefreshWeakBar));
		}
		animator.SetBool(postureParam, active);
		animator.SetTrigger(postureChangeTrigger);
	}

	private void RefreshWeakBar(Entity eb, float pre, float value)
	{
		weakBar.TargetValue = 1f - value;
		if (value == 0f)
		{
			if (damageMultiplier != null)
			{
				damageMultiplier.SetText("{0:0.##}", (1f + m_Attackee.GetConfig().postureDmgIncrease) * 100f);
			}
			animator.SetBool(weakParam, value: true);
		}
		if (Mathf.Approximately(value, 1f) && m_Attackee.GetCompAbility().IsHavePosture)
		{
			animator.SetBool(weakParam, value: false);
		}
	}

	private void RefreshPostureBarBurst(Entity eb, bool value)
	{
		animator.SetBool(burstParam, value);
	}

	private void PlayParticle(RectTransform rectP, ParticleSystem particleSystem, Image image, Vector3 imageLocalPos)
	{
		RectTransform rectTransform = image.rectTransform;
		bool flag = image.fillOrigin == 0;
		float x = imageLocalPos.x + rectTransform.rect.x + (flag ? (rectTransform.sizeDelta.x * image.fillAmount) : (rectTransform.sizeDelta.x * (1f - image.fillAmount)));
		rectP.localPosition = new Vector3(x, imageLocalPos.y, imageLocalPos.z);
		particleSystem.Stop();
		particleSystem.Play();
	}

	private void BloodEffect(float damage)
	{
		float num = Mathf.Abs(damage) / (float)m_Attackee.GetCompAbility().maxHP;
		if (damage > 0f)
		{
			bloodHitAnimation.Stop();
			bloodParticle.Play(leftBase: true, bloodbar.TargetValue);
			if (num < GameLoader.meta.barShakePercent)
			{
				bloodHitAnimation.Play(m_BloodAniNames[0]);
			}
			else
			{
				bloodHitAnimation.Play(m_BloodAniNames[1]);
			}
			if (enableAttackPercentRefresh && num > attackPercentRefreshDelay)
			{
				bloodbar.IgnoreDelayOnce();
			}
		}
	}

	private void PostureEffect(float damage)
	{
		CompAbility compAbility = m_Attackee.GetCompAbility();
		float num = Mathf.Abs(damage) / (float)compAbility.maxPosture;
		if (!(damage > 0f))
		{
			return;
		}
		if (compAbility.IsPostureBurst)
		{
			burstHitAnimationL.Stop();
			burstHitAnimationR.Stop();
			if (num < GameLoader.meta.barShakePercent)
			{
				burstParticleLitL.Play(leftBase: false, burstBarL.TargetValue);
				burstParticleLitR.Play(leftBase: false, burstBarR.TargetValue);
				burstHitAnimationL.Play(m_BurstAniNameL[0]);
				burstHitAnimationR.Play(m_BurstAniNameR[0]);
			}
			else
			{
				burstParticleL.Play(leftBase: false, burstBarL.TargetValue);
				burstParticleR.Play(leftBase: false, burstBarR.TargetValue);
				burstHitAnimationL.Play(m_BurstAniNameL[1]);
				burstHitAnimationR.Play(m_BurstAniNameR[1]);
			}
		}
		else
		{
			postureHitAnimationL.Stop();
			postureHitAnimationR.Stop();
			if (num < GameLoader.meta.barShakePercent)
			{
				postureParticleLitL.Play(leftBase: false, postureBarL.TargetValue);
				postureParticleLitR.Play(leftBase: false, postureBarR.TargetValue);
				postureHitAnimationL.Play(m_PostureAniNameL[0]);
				postureHitAnimationR.Play(m_PostureAniNameR[0]);
			}
			else
			{
				postureParticleL.Play(leftBase: false, postureBarL.TargetValue);
				postureParticleR.Play(leftBase: false, postureBarR.TargetValue);
				postureHitAnimationL.Play(m_PostureAniNameL[1]);
				postureHitAnimationR.Play(m_PostureAniNameR[1]);
			}
		}
	}

	public void OnExit(Entity entity)
	{
		if (entity.TryGetCompAbility(out CompAbility component))
		{
			component.onHPChange -= new Action<int, int>(RefreshMonsterBloodBar);
			CompAbility compAbility = component;
			compAbility.onCharacterDamageHit = (Action<Entity, int>)Delegate.Remove(compAbility.onCharacterDamageHit, new Action<Entity, int>(OnCharacterDamageTypeChange));
			CompAbility compAbility2 = component;
			compAbility2.onActivePostureChange = (Action<Entity, bool>)Delegate.Remove(compAbility2.onActivePostureChange, new Action<Entity, bool>(RefreshPostureBarActive));
			if (component.IsHavePosture)
			{
				m_IsWeak = false;
				CompAbility compAbility3 = component;
				compAbility3.onPostureChange = (Action<Entity, int, int>)Delegate.Remove(compAbility3.onPostureChange, new Action<Entity, int, int>(RefreshPostureBar));
				if (component.IsPostureBurst)
				{
					CompAbility compAbility4 = component;
					compAbility4.onPostureBurstChange = (Action<Entity, bool>)Delegate.Remove(compAbility4.onPostureBurstChange, new Action<Entity, bool>(RefreshPostureBarBurst));
				}
				CompAbility compAbility5 = component;
				compAbility5.onRevivePostureProgressChange = (Action<Entity, float, float>)Delegate.Remove(compAbility5.onRevivePostureProgressChange, new Action<Entity, float, float>(RefreshWeakBar));
			}
		}
		m_Attackee = default;
		m_BloodDamageType = 0;
		m_PostureDamageType = 0;
		gameObject.SetActive(value: false);
		currentBossEntityBehave = default;
	}

	private void OnDestroy()
	{
		if (m_Init)
		{
			ListPool<string>.Release(m_BloodAniNames);
			ListPool<string>.Release(m_PostureAniNameL);
			ListPool<string>.Release(m_PostureAniNameR);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnCharacterChange);
		}
	}

	private void OnCharacterChange(BaseEventContent content)
	{
		bloodbar.IgnoreDelayOnce();
	}

	private void OnHit(BaseEventContent content)
	{
		UIEntityGetHitEvt uIEntityGetHitEvt = (UIEntityGetHitEvt)content;
		if (!(m_Attackee.Id != uIEntityGetHitEvt.uid) && uIEntityGetHitEvt.cmdHit.caster.TryGetCompCharacter(out CompCharacter component))
		{
			m_PostureDamageType = (m_BloodDamageType = RuntimeConfigs.data.entityCharacterDatas[component.characterSource.Id()].characterDamageType);
		}
	}

	private void OnCharacterDamageTypeChange(Entity eb, int type)
	{
		m_PostureDamageType = (m_BloodDamageType = type);
	}

	public void Hide()
	{
		if (m_Attackee != null)
		{
			OnExit(m_Attackee);
		}
	}
}
