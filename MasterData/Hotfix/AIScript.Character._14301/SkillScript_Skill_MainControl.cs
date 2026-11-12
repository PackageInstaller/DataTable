using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private PlayerSkillCd _playerSkillCd;

	private AimTarget _aimTarget;

	private List<TSVector2> _shootVectorList;

	private int _loopTimes;

	private int _shootIndex;

	private bool _havePerk_P4;

	private int _extraShootCount_P4;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		if (_shootVectorList == null)
		{
			InitShootVector();
		}
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		_loopTimes = 0;
		_shootIndex = 0;
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Cancel();
		}
		_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
		_havePerk_P4 = CommonUtils.HavePersonalPerk(_actor.dataID, 514304, out var perkLevel);
		_extraShootCount_P4 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514308, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14308011, _actor);
		}
	}

	private void InitShootVector()
	{
		_shootVectorList = new List<TSVector2>();
		int num = 60;
		TSVector2 tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, -Config_MainControl.startAngeleOffset_Skill).normalized * Config_MainControl.shootRadius_Skill;
		for (int i = 0; i < 6; i++)
		{
			int num2 = -num * i;
			if (num2 != 0)
			{
				_shootVectorList.Add(TSVector2.Rotate(tSVector, num2));
			}
			else
			{
				_shootVectorList.Add(tSVector);
			}
		}
	}

	public void OnStart()
	{
		string text = "Skill_Mian_SheZhan";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514305, out var _))
		{
			text = "Skill_Mian_SheZhan_P5";
		}
		string actionTag = text;
		Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_loopTimes++;
		if (_havePerk_P4)
		{
			_extraShootCount_P4++;
		}
		if (_actor.logicVariable.GetLogicTagToggle("HoldingKeyB") && _playerSkillCd.GetSkillSection(_skill.skillId) > 0)
		{
			CommonUtils.ReduceSkillSection(_actor, _skill);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514308, out var _))
			{
				_actor.buffComponent.AddBuff(14308011, _actor);
			}
		}
		else
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "143SkillMainShot"))
		{
			if (_shootVectorList.Count <= 0)
			{
				return;
			}
			int num = _shootVectorList.Count - 1;
			_shootIndex = TSMath.Clamp(_shootIndex, 0, num).AsInt();
			TSVector2 shootPosition = _actor.tsTransform.Position + _shootVectorList.get_Item(_shootIndex);
			TSVector2 normalized = _shootVectorList.get_Item(_shootIndex).normalized;
			Shoot(shootPosition, normalized);
			if (_havePerk_P4)
			{
				int num2 = TSMath.Clamp(_extraShootCount_P4, 0, 2).AsInt();
				int num3 = _shootIndex;
				switch (num2)
				{
				case 1:
				{
					int num4 = ((_shootVectorList.Count > 1) ? (_shootVectorList.Count / 2) : 0);
					num3 += num4;
					num3 = ((num3 > num) ? (num3 - (num + 1)) : num3);
					shootPosition = _actor.tsTransform.Position + _shootVectorList.get_Item(num3);
					normalized = _shootVectorList.get_Item(num3).normalized;
					Shoot(shootPosition, normalized);
					break;
				}
				case 2:
				{
					int num4 = ((_shootVectorList.Count > 2) ? (_shootVectorList.Count / 3) : ((_shootVectorList.Count > 1) ? 1 : 0));
					for (int i = 0; i < 2; i++)
					{
						num3 += num4;
						num3 = ((num3 > num) ? (num3 - (num + 1)) : num3);
						shootPosition = _actor.tsTransform.Position + _shootVectorList.get_Item(num3);
						normalized = _shootVectorList.get_Item(num3).normalized;
						Shoot(shootPosition, normalized);
					}
					break;
				}
				}
			}
			_shootIndex++;
			_shootIndex = ((_shootIndex <= num) ? _shootIndex : 0);
		}
		else if (string.Equals(eventName, "143P2LongJuanFeng") && CommonUtils.HavePersonalPerk(_actor.dataID, 514302, out perkLevel))
		{
			string fxAlias = (CommonUtils.HavePersonalPerk(_actor.dataID, 514301, out perkLevel) ? "AreaEffect_143_P1_LongJuanFeng_P2" : "AreaEffect_143_P2_LongJuanFeng");
			for (int j = 0; j < 2; j++)
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(Config_MainControl.generateTornadoRadius_P1_P2, Config_MainControl.generateTornadoRadius_P1_P2, _actor.tsTransform.Position), isReachable: false);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, randomPointInShape);
			}
		}
	}

	private void Shoot(TSVector2 shootPosition, TSVector2 shootDirection)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514303, out var _))
		{
			if (_actor.attackTarget != null)
			{
				shootDirection = (_actor.attackTarget.tsTransform.Position - shootPosition).normalized;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P3_JiGuang", shootPosition, shootDirection.GetAngle(), (AreaEffectEntity areaEffect) =>
			{
				areaEffect.tsTransform.PositionY += Config_MainControl.shootPositionY_Skill;
			});
		}
		else
		{
			ILRuntimeAPI.ShootByDirection("Bullet_143_SkillMain_Base", _actor, default, shootDirection, shootPosition, Config_MainControl.shootPositionY_Skill);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514301, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14301011, _actor);
		}
		_extraShootCount_P4 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514309, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14309011);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514310, out perkLevel))
		{
			BuffEntity buffEntity = _actor.buffComponent.AddBuff(14310011, _actor);
			if (_loopTimes > 1)
			{
				buffEntity?.AddLeftTime(Config_MainControl.addBuffDuration_P10 * (_loopTimes - 1));
			}
		}
		_loopTimes = 0;
		_shootIndex = 0;
	}
}
