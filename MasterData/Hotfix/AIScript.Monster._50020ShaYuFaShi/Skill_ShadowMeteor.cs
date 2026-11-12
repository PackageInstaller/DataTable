#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_ShadowMeteor : SkillAdvancedBase
{
	private DeterministicShape fanShape;

	private GameObject effectAsset1;

	private GameObject effectAsset2;

	private CoroutineNode waitCoroutine;

	private LookAtTarget lookAtTarget;

	private readonly FP lookAtTargetDuration = 9999;

	private readonly FP lookAtTargetAngleSpd = 180;

	private readonly string effectPath1 = "Assets/AssetBundles/Actor/Monster/50020ShaYuFaShi/FX/fx_50020_bullet_atk_dark_02.prefab";

	private readonly string effectPath2 = "Assets/AssetBundles/Actor/Monster/50020ShaYuFaShi/FX/fx_50020_hit_atk_dark_02.prefab";

	private readonly string bulletPath = "Weapon_50501ShaSha_Water_Empty";

	private readonly TSVector2 relativeCoord = new TSVector2(0, 0);

	private readonly FP innerRadius = 0;

	private readonly FP outterRadius = 0;

	private readonly FP angle = 360;

	private readonly FP offsetAngle = 0;

	private readonly FP waitDuration1 = 0.5;

	private readonly FP waitDuration2 = 1.5;

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
	}

	public void OnStart()
	{
		if (waitCoroutine != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine);
			waitCoroutine = null;
		}
		SkillLogic();
	}

	private void SkillLogic()
	{
		ComboInputBuffer.ActionKey[] keys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };
		Action onComboFinish = OnComboFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, null, onCustomEvent);
		NovaLogger.Debug("连击攻击");
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
				lookAtTarget.BeginLookAtByPos(_actor, SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position, lookAtTargetDuration, lookAtTargetAngleSpd, null);
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
				break;
			}
		}
		Skill_ShadowMeteor this_arg;
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
			NovaLogger.Debug("Shoot");
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor?.GetComponent<AdventureActor>();
			TrueSyncTransform trueSyncTransform = adventureActor?.tsTransform;
			SetFan(position: ILRuntimeAPI.TransLocalPosToWorldPosByPos(trueSyncTransform.Position, trueSyncTransform.Forward, relativeCoord), radius: outterRadius, innerRadius: innerRadius, angle: angle, rotation: offsetAngle);
			TSVector2 point = adventureActor.RandomActorReachablePointInsideShape(fanShape);
			Effect();
			void Bullet()
			{
				NovaLogger.Debug("发射子弹");
				ILRuntimeAPI.Shoot(bulletPath, _actor, 0, _actor.tsTransform.Position, 0, point, null, AimType.Position, BulletDirectionType.BulletToTarget);
				SkillFinish();
			}
			void Effect()
			{
				NovaLogger.Debug("播放特效" + effectPath1);
				AdventureFXPlayer.PlayFX(effectAsset1, 1f, new Vector3((float)point.x, 0f, (float)point.y), Quaternion.identity);
				waitCoroutine = _actor.StartLogicCoroutine(Wait(Effect2, waitDuration1));
			}
			void Effect2()
			{
				NovaLogger.Debug("播放特效" + effectPath2);
				AdventureFXPlayer.PlayFX(effectAsset2, 1f, new Vector3((float)point.x, 0f, (float)point.y), Quaternion.identity);
				if (waitCoroutine != null)
				{
					_actor.StopLogicCoroutine(waitCoroutine);
				}
				waitCoroutine = _actor.StartLogicCoroutine(Wait(Bullet, waitDuration2));
			}
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
		if (waitCoroutine != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine);
			waitCoroutine = null;
		}
		if (lookAtTarget != null)
		{
			lookAtTarget.StopLookAt();
			lookAtTarget.Clear();
			lookAtTarget = null;
		}
	}
}
