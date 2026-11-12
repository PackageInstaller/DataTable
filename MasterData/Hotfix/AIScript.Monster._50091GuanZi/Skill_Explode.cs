#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._50091GuanZi;

public class Skill_Explode : SkillAdvancedBase
{
	private readonly int buffId = 990010040;

	private FP distanceLimit = 6;

	private readonly FP waitDuration1 = 0.3;

	private readonly FP waitDuration2 = 1;

	private CoroutineNode waitCoroutine;

	private bool startLogic;

	private readonly string effectAssetPath = "Assets/AssetBundles/Actor/Monster/50091GuanZi/FX/fx_50091GuanZi_Skill.prefab";

	private GameObject effectAsset;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Clear();
		if (null == effectAsset)
		{
			UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, effectAssetPath, typeof(GameObject));
			if (null == obj)
			{
				NovaLogger.Error("连线特效资源为空:" + effectAssetPath);
			}
			else
			{
				effectAsset = obj as GameObject;
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
		startLogic = false;
	}

	private void SKillFinish()
	{
		Clear();
		startLogic = false;
	}

	private void Clear()
	{
		if (waitCoroutine != null)
		{
			_actor.StopLogicCoroutine(waitCoroutine);
			waitCoroutine = null;
		}
		effectAsset = null;
	}

	public void OnStart()
	{
		NovaLogger.Debug("start");
		startLogic = true;
	}

	private void SKillLogic()
	{
		NovaLogger.Debug("执行技能逻辑");
		startLogic = false;
		waitCoroutine = StartCoroutine(Wait(() =>
		{
			ComboInputBuffer.ActionKey[] keys = new ComboInputBuffer.ActionKey[1];
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, onCustomEvent);
		}, waitDuration1));
		void OnCustomEvent(string evtName)
		{
			if (!(evtName == "Hide"))
			{
				if (evtName == "Explode")
				{
					NovaLogger.Debug("触发事件Explode");
					NovaLogger.Debug("播放特效" + effectAsset?.name);
					AdventureFXPlayer.PlayFX(effectAsset, 1f, _actor.transform.position, _actor.transform.rotation);
				}
			}
			else
			{
				NovaLogger.Debug("触发事件Hide");
				NovaLogger.Debug(_actor.name + "隐藏");
				_actor.buffComponent?.AddBuff(buffId, _actor);
				_actor.Hide();
				if (waitCoroutine != null)
				{
					StopCoroutine(waitCoroutine);
					waitCoroutine = null;
				}
				waitCoroutine = StartCoroutine(Wait(() =>
				{
					NovaLogger.Debug(_actor.name + "自爆");
					_actor.DestroySelf();
					SKillFinish();
				}, waitDuration2));
			}
		}
	}

	public void OnUpdate()
	{
		if (startLogic)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (!(null == activedPlayerActor) && !(TSVector2.Distance(activedPlayerActor.tsTransform.Position, _actor.tsTransform.Position) > 6))
			{
				SKillLogic();
			}
		}
	}

	private IEnumerator Wait(Action callback, FP duration)
	{
		NovaLogger.Debug($"等待{duration}");
		yield return duration;
		callback?.Invoke();
	}
}
