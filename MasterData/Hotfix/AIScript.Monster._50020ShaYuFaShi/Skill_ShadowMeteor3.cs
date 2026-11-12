#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_ShadowMeteor3 : SkillAdvancedBase
{
	private DeterministicShape fanShape;

	private GameObject effectAsset1;

	private GameObject effectAsset2;

	private CoroutineNode wait2ShootCoroutine1;

	private CoroutineNode wait2ShootCoroutine2;

	private CoroutineNode waitCoroutine1;

	private CoroutineNode waitCoroutine2;

	private CoroutineNode waitCoroutine3;

	private LookAtTarget lookAtTarget;

	private readonly FP lookAtTargetDuration = 9999;

	private readonly FP lookAtTargetAngleSpd = 180;

	private readonly string effectPath1 = "Assets/AssetBundles/Actor/Monster/50020ShaYuFaShi/FX/fx_50020_bullet_atk_dark_02.prefab";

	private readonly string effectPath2 = "Assets/AssetBundles/Actor/Monster/50020ShaYuFaShi/FX/fx_50020_hit_atk_dark_02.prefab";

	private readonly string bulletPath = "Weapon_50501ShaSha_Water_Empty";

	private readonly TSVector2 relativeCoord = new TSVector2(0, 0);

	private readonly FP innerRadius = 1;

	private readonly FP outterRadius = 4;

	private readonly FP angle = 360;

	private readonly FP offsetAngle = 360;

	private readonly FP wait2ShootDuration1 = 0.3;

	private readonly FP wait2ShootDuration2 = 0.6;

	private readonly FP waitDuration1 = 0;

	private readonly FP waitDuration2 = 1.55;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		fanShape = default;
		fanShape.shapeType = DeterministicShape.ShapeType.Fan;
		if (null == effectAsset1)
		{
			UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, effectPath1, typeof(GameObject));
			if (null == obj)
			{
				NovaLogger.Error("连线特效资源为空:" + effectPath1);
			}
			else
			{
				effectAsset1 = obj as GameObject;
			}
		}
		if (null == effectAsset2)
		{
			UnityEngine.Object obj2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, effectPath2, typeof(GameObject));
			if (null == obj2)
			{
				NovaLogger.Error("连线特效资源为空:" + effectPath2);
			}
			else
			{
				effectAsset2 = obj2 as GameObject;
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		effectAsset1 = null;
		effectAsset2 = null;
		Clear();
	}

	public void OnStart()
	{
		Clear();
		SkillLogic();
	}

	private void SkillLogic()
	{
		ComboInputBuffer.ActionKey[] keys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };
		Action onComboFinish = OnComboFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, null, onCustomEvent);
		NovaLogger.Debug("连击攻击");
		Skill_ShadowMeteor3 this_arg;
		TSVector2 GetPoint()
		{
			NovaLogger.Debug("Shoot3");
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor?.GetComponent<AdventureActor>();
			TrueSyncTransform trueSyncTransform = adventureActor?.tsTransform;
			SetFan(position: ILRuntimeAPI.TransLocalPosToWorldPosByPos(trueSyncTransform.Position, trueSyncTransform.Forward, relativeCoord), radius: outterRadius, innerRadius: innerRadius, angle: angle, rotation: offsetAngle);
			return adventureActor.RandomActorReachablePointInsideShape(fanShape);
		}
		static void OnComboFinish()
		{
			NovaLogger.Debug("连击攻击结束");
		}
		void OnCustomEvent(string evtName)
		{
			switch (evtName)
			{
			case "A":
				NovaLogger.Debug("触发事件A");
				NovaLogger.Debug("朝向玩家");
				if (lookAtTarget == null)
				{
					lookAtTarget = new LookAtTarget();
				}
				lookAtTarget.BeginLookAt(_actor, SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor, lookAtTargetDuration, lookAtTargetAngleSpd, null);
				break;
			case "B":
				NovaLogger.Debug("触发事件B");
				NovaLogger.Debug("停止朝向玩家");
				lookAtTarget.StopLookAt();
				lookAtTarget.Clear();
				break;
			case "Shoot":
				NovaLogger.Debug("触发事件Shoot");
				Shoot();
				wait2ShootCoroutine1 = _actor.StartLogicCoroutine(Wait(Shoot3, wait2ShootDuration1));
				wait2ShootCoroutine2 = _actor.StartLogicCoroutine(Wait(Shoot4, wait2ShootDuration2));
				break;
			}
		}
		void SetFan(FP radius, FP innerRadius, FP angle, FP rotation, TSVector2 position)
		{
			this_arg.fanShape.radius = radius;
			this_arg.fanShape.innerRadius = innerRadius;
			this_arg.fanShape.angle = angle;
			this_arg.fanShape.rotation = rotation;
			this_arg.fanShape.position = position;
		}
		void Shoot()
		{
			NovaLogger.Debug("Shoot1");
			TSVector2 point = GetPoint();
			Shoot2(point, waitCoroutine1, null);
		}
		void Shoot2(TSVector2 point, CoroutineNode coroutine, Action callback)
		{
			Effect();
			void Bullet()
			{
				NovaLogger.Debug("发射子弹");
				ILRuntimeAPI.Shoot(bulletPath, _actor, 0, _actor.tsTransform.Position, 0, point, null, AimType.Position, BulletDirectionType.BulletToTarget);
				if (callback != null)
				{
					callback();
					callback = null;
				}
			}
			void Effect()
			{
				NovaLogger.Debug("播放特效" + effectPath1);
				AdventureFXPlayer.PlayFX(effectAsset1, 1f, new Vector3((float)point.x, 0f, (float)point.y), Quaternion.identity);
				coroutine = _actor.StartLogicCoroutine(Wait(Effect2, waitDuration1));
			}
			void Effect2()
			{
				NovaLogger.Debug("播放特效" + effectPath2);
				AdventureFXPlayer.PlayFX(effectAsset2, 1f, new Vector3((float)point.x, 0f, (float)point.y), Quaternion.identity);
				if (coroutine != null)
				{
					_actor.StopLogicCoroutine(coroutine);
				}
				coroutine = _actor.StartLogicCoroutine(Wait(Bullet, waitDuration2));
			}
		}
		void Shoot3()
		{
			NovaLogger.Debug("Shoot2");
			TSVector2 point = GetPoint();
			Shoot2(point, waitCoroutine2, null);
		}
		void Shoot4()
		{
			NovaLogger.Debug("Shoot3");
			TSVector2 point = GetPoint();
			Shoot2(point, waitCoroutine3, SkillFinish);
		}
	}

	private IEnumerator Wait(Action callback, FP duration)
	{
		NovaLogger.Debug($"等待{duration}");
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(duration));
		callback?.Invoke();
	}

	private void SkillFinish()
	{
		NovaLogger.Debug("技能结束");
		_skill?.Clear();
		if (lookAtTarget != null)
		{
			lookAtTarget.StopLookAt();
			lookAtTarget.Clear();
			lookAtTarget = null;
		}
		Clear();
	}

	private void Clear()
	{
		if (wait2ShootCoroutine1 != null)
		{
			_actor.StopLogicCoroutine(wait2ShootCoroutine1);
			wait2ShootCoroutine1 = null;
		}
		if (wait2ShootCoroutine2 != null)
		{
			_actor.StopLogicCoroutine(wait2ShootCoroutine2);
			wait2ShootCoroutine2 = null;
		}
		if (waitCoroutine1 != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine1);
			waitCoroutine1 = null;
		}
		if (waitCoroutine2 != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine2);
			waitCoroutine2 = null;
		}
		if (waitCoroutine3 != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine3);
			waitCoroutine3 = null;
		}
	}
}
