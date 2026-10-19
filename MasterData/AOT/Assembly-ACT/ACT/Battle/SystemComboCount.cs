using System;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class SystemComboCount : ECSSystem
{
	public Action<int, int> OnComboCountChange;

	public Action<float, float, bool> OnComboTimeChange;

	public Action<int> ChangeComboImageWhenUnHited;

	public Action<int> OnDmgChange;

	private float _clearTime = 20f;

	private float _comboElapsedTime;

	private bool _inCombo;

	private int _dmg;

	private const float WAIT_DURATION = 0.1f;

	private float waitUnHitDelayTimer = -1f;

	public int ComboCount { get; private set; }

	public float ClearTime => _clearTime;

	public bool InCombo => _inCombo;

	public override Filter MajorFilter { get; }

	protected override void OnCreate()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleOnHit, OnHit);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnDamage);
	}

	private void OnDamage(BaseEventContent obj)
	{
		if (obj is DamageEvt { AttackData: not null } damageEvt && damageEvt.AttackData.attacker.IsCharacter())
		{
			_dmg += Mathf.RoundToInt(damageEvt.AttackData.damage);
			OnDmgChange?.Invoke(_dmg);
		}
	}

	private void OnHit(BaseEventContent obj)
	{
		if (!(obj is HitEvt hitEvt) || hitEvt.attacker != MonoECS.instance.mainEntity)
		{
			return;
		}
		FilterEntityType comboFilterEntityType = GameUtility.comboFilterEntityType;
		Entity target = hitEvt.target;
		if (target.IsValid)
		{
			EntityType entityType = target.GetEntityType();
			if (!comboFilterEntityType.HasEntityType(entityType))
			{
				return;
			}
		}
		if (!(hitEvt.AttackData.damage <= 0f))
		{
			waitUnHitDelayTimer = 0.1f;
			int comboCount = ComboCount;
			ComboCount++;
			_inCombo = true;
			_comboElapsedTime = 0f;
			OnComboTimeChange?.Invoke(_clearTime, _clearTime, arg3: true);
			OnComboCountChange?.Invoke(comboCount, ComboCount);
		}
	}

	public override void Update()
	{
		base.Update();
		if (!_inCombo)
		{
			return;
		}
		_comboElapsedTime += GameManager.timeSystem.GetCurrentDeltaTime();
		if (_comboElapsedTime > _clearTime)
		{
			int comboCount = ComboCount;
			_inCombo = false;
			ComboCount = 0;
			_dmg = 0;
			OnComboCountChange?.Invoke(comboCount, ComboCount);
			OnComboTimeChange?.Invoke(0f, _clearTime, arg3: false);
		}
		else
		{
			float arg = Mathf.Max(0f, _clearTime - _comboElapsedTime);
			OnComboTimeChange?.Invoke(arg, _clearTime, arg3: false);
		}
		if (waitUnHitDelayTimer > 0f)
		{
			waitUnHitDelayTimer -= Time.deltaTime;
			if (waitUnHitDelayTimer <= 0f)
			{
				ChangeComboImageWhenUnHited?.Invoke(ComboCount);
			}
		}
	}

	public void ClearComboCount()
	{
		int comboCount = ComboCount;
		_inCombo = false;
		_comboElapsedTime = 0f;
		ComboCount = 0;
		_dmg = 0;
		OnComboCountChange?.Invoke(comboCount, ComboCount);
		OnComboTimeChange?.Invoke(0f, _clearTime, arg3: false);
	}
}
