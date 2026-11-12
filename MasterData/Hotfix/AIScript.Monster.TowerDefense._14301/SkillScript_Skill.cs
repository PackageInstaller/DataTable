using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14301;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key_Base = "Skill_Base";

	private int shootPointCount_Skill = 6;

	private FP startAngeleOffset_Skill = 90;

	private FP shootRadius_Skill = 2.7;

	private FP shootPositionY_Skill = 1.35;

	private string eventName_Skill_ShootBullet = "143SkillMainShot";

	private string bulletKey_Skill_Shoot = "Bullet_143_SkillMain_Base";

	private const int perkId_1 = 1430101;

	private string eventName_GenerateTornado_1 = "143P2LongJuanFeng";

	private string tornadoAreaEffectKey_1 = "AreaEffect_143_Skill_LongJuanFeng";

	private FP generateTornadoRadius_1 = 3;

	private const int perkId_2 = 1430102;

	private string laserAreaEffectKey_2 = "AreaEffect_143_Skill_JiGuang";

	private const int perkId_3 = 1430103;

	private const int perkId_4 = 1430104;

	private int extraLoopCount_4 = 4;

	private CoroutineNode corMain;

	private int curLoopCount;

	private List<TSVector2> _shootVectorList = new List<TSVector2>();

	private int _shootIndex;

	private int _extraShootCount_3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		curLoopCount = 0;
		_shootIndex = 0;
		_extraShootCount_3 = 0;
		InitShootVector();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void InitShootVector()
	{
		if (shootPointCount_Skill <= 0)
		{
			return;
		}
		int num = 360 / shootPointCount_Skill;
		TSVector2 tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, -startAngeleOffset_Skill).normalized * shootRadius_Skill;
		for (int i = 0; i < shootPointCount_Skill; i++)
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

	private IEnumerator DoMainLogic()
	{
		int count = ((!GetPerk(1430104)) ? 1 : extraLoopCount_4);
		SkillScript_Skill skillScript_Skill = this;
		string actionTag = key_Base;
		Action<string> action = onCustomEvent;
		Action action2 = onComboLoop;
		Action onInterrupt = SkillInterrupt;
		Action onComboFinish = SkillFinish;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: false, action2);
		while (curLoopCount < count)
		{
			yield return null;
		}
		_actor.CancelAttack();
	}

	private void onComboLoop()
	{
		curLoopCount++;
	}

	private void onCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Skill_ShootBullet))
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
			if (GetPerk(1430103))
			{
				int num2 = 2;
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
		else if (string.Equals(eventName, eventName_GenerateTornado_1) && GetPerk(1430101))
		{
			TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(generateTornadoRadius_1, generateTornadoRadius_1, _actor.tsTransform.Position), isReachable: false);
			ILRuntimeAPI.PlayAreaEffect(_actor, tornadoAreaEffectKey_1, randomPointInShape);
		}
	}

	private void Shoot(TSVector2 shootPosition, TSVector2 shootDirection)
	{
		if (GetPerk(1430102))
		{
			TSVector2 tSVector = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - shootPosition).normalized : shootDirection);
			ILRuntimeAPI.PlayAreaEffect(_actor, laserAreaEffectKey_2, shootPosition, tSVector.GetAngle(), (AreaEffectEntity areaEffect) =>
			{
				areaEffect.tsTransform.PositionY += shootPositionY_Skill;
			});
		}
		else
		{
			TSVector2 shootDir = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - shootPosition).normalized : shootDirection);
			ILRuntimeAPI.ShootByDirection(bulletKey_Skill_Shoot, _actor, default, shootDir, shootPosition, shootPositionY_Skill);
		}
	}
}
