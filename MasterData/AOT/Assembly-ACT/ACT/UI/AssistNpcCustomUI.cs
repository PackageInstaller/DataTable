using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class AssistNpcCustomUI : MonoBehaviour, IEntityUI
{
	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TargetValueMaskBar bloodbar;

	[SerializeField]
	private Animation hitedAnimation;

	[SerializeField]
	private TextMeshProUGUI _name;

	[SerializeField]
	private bool enableAttackPercentRefresh = true;

	[SerializeField]
	private float attackPercentRefreshDelay = 0.03f;

	private List<string> m_HitedNames;

	private Entity entity;

	private bool m_Show;

	public bool Show
	{
		get
		{
			return m_Show;
		}
		set
		{
			if (m_Show != value)
			{
				m_Show = value;
				gameObject.SetActive(value);
			}
		}
	}

	private void Awake()
	{
		InitData();
	}

	private void OnDestroy()
	{
		ListPool<string>.Release(m_HitedNames);
	}

	private void InitData()
	{
		m_HitedNames = ListPool<string>.Get();
		foreach (AnimationState item in hitedAnimation)
		{
			m_HitedNames.Add(item.name);
		}
	}

	public void Init(Entity initEntity, bool show, Vector3 vector3)
	{
		entity = initEntity;
		Show = show;
		if (vector3 != Vector3.zero)
		{
			transform.eulerAngles = vector3;
		}
		CompAbility compAbility = entity.GetCompAbility();
		EntityData data = CoreUtils.GetData(entity.GetTableId(), RuntimeConfigs.data.entityDatas);
		if (data != null)
		{
			_name.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal);
		}
		level.SetText("{0:0}", compAbility.level);
		TargetValueMaskBar targetValueMaskBar = bloodbar;
		float value = (bloodbar.TargetValue = (float)compAbility.hp / (float)compAbility.maxHP);
		targetValueMaskBar.Value = value;
		compAbility.onHPChange += new Action<int, int>(RefreshMonsterBloodBar);
	}

	private void RefreshMonsterBloodBar(int value, int newValue)
	{
		bloodbar.TargetValue = (float)newValue / (float)entity.GetCompAbility().maxHP;
		BloodEffect(value - newValue);
	}

	private void BloodEffect(float damage)
	{
		float num = Mathf.Abs(damage) / (float)entity.GetCompAbility().maxHP;
		if (damage > 0f)
		{
			hitedAnimation.Stop();
			if (num < GameLoader.meta.monsterBarShakePercent)
			{
				hitedAnimation.Play(m_HitedNames[0]);
			}
			else
			{
				hitedAnimation.Play(m_HitedNames[1]);
			}
			if (enableAttackPercentRefresh && num > attackPercentRefreshDelay)
			{
				bloodbar.IgnoreDelayOnce();
			}
		}
	}

	public void UpdatePos()
	{
		if (!entity.IsValid || !entity.IsActive() || !entity.IsAlive())
		{
			Show = false;
			return;
		}
		Show = true;
		Vector3 monsterUIPosOffset = entity.GetConfig().MonsterUIPosOffset;
		monsterUIPosOffset.y += entity.GetCompTransform().size.y;
		Transform rootTransform = entity.GetRootTransform();
		monsterUIPosOffset = rootTransform.TransformDirection(monsterUIPosOffset);
		Vector3 position = GameUtility.mainCamera.WorldToScreenPoint(rootTransform.position + monsterUIPosOffset);
		position.z = transform.position.z;
		transform.position = GameUtility.uiCamera.ScreenToWorldPoint(position);
	}

	public void OnRelease(Action callback = null)
	{
		if (entity.IsValid)
		{
			entity.GetCompAbility().onHPChange -= new Action<int, int>(RefreshMonsterBloodBar);
		}
		Show = false;
		entity = default;
	}
}
