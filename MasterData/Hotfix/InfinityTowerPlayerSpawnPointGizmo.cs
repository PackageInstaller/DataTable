using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class InfinityTowerPlayerSpawnPointGizmo : BaseSpawnPointGizmo
{
	public enum showType
	{
		[InspectorName("默认")]
		defaultShow,
		[InspectorName("特效出生")]
		fxShow,
		[InspectorName("物件出生")]
		interactiveShow
	}

	[Space]
	public HotfixEnum.infinityTowerGameplayType groupIndex;

	protected List<AdventureLevelObjPoolMgr.PoolBase> spawnPoolObjs;

	public string spawnPointID = string.Empty;

	public showType _showType;

	[SerializeField]
	protected InteractiveSimple ani;

	[SerializeField]
	protected GameObject effectObj;

	public float _delay;

	public bool inputEnable;

	[SerializeField]
	protected FP autoRunForwardWhenSpawnDistance = 3;

	public float fadeInDuration = 1f;

	public void LevelStart()
	{
		if (!isSpawnActived)
		{
			return;
		}
		if (_showType == showType.defaultShow)
		{
			SceneSingleton<AdventurePlayerController>.Instance.showBronFx();
			PlayerSpawnComplete();
		}
		else if (null != ani && _showType == showType.interactiveShow)
		{
			SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceHide();
			if (_delay >= 0f)
			{
				ani.SetProcessState(InteractiveManager.processState.deactive0);
				if (_delay > 0f)
				{
					Invoke("PlayerSpawnComplete", _delay);
				}
				else
				{
					PlayerSpawnComplete();
				}
			}
			else
			{
				ani.SetProcessState(InteractiveManager.processState.deactive0, PlayerSpawnComplete);
			}
		}
		else
		{
			if (effectObj != null)
			{
				SceneSingleton<AdventurePlayerController>.Instance.showBronFx(effectObj);
			}
			if (_delay > 0f)
			{
				SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceHide(showfx: false);
				StartCoroutine(PlayerSpawnComplete(_delay));
			}
			else
			{
				PlayerSpawnComplete();
			}
		}
	}

	public void LevelEnd()
	{
		Despawn();
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		base.ExecuteSpawnLogic(summoner);
		TSVector2 position = new TSVector2(transform.position.x, transform.position.z);
		float num = 0f - transform.rotation.eulerAngles.y;
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		if (playerActors == null || playerActors.Count == 0)
		{
			int[] actorIDs = AdventureGameContext.TeamConfig.ActorIDs;
			if (actorIDs == null || actorIDs.Length == 0)
			{
				_logger.LogError("全局Blackboard变量\"PlayerActors\"为空");
			}
			else
			{
				spawnPoolObjs = new List<AdventureLevelObjPoolMgr.PoolBase>();
				for (int i = 0; i < actorIDs.Length; i++)
				{
					ActorSpawnInfo actorSpawnInfo = new ActorSpawnInfo(actorIDs[i]);
					actorSpawnInfo.positionY = transform.position.y;
					actorSpawnInfo.position = position;
					actorSpawnInfo.rotation = num;
					actorSpawnInfo.spawnGizmo = this;
					ActorSpawnInfo spawnInfo = actorSpawnInfo;
					AdventureLevelObjPoolMgr.PoolBase poolBase = ModuleController<AdventureModuleController>.Instance.SpawnPlayer(spawnInfo);
					if (poolBase != null)
					{
						spawnPoolObjs.Add(poolBase);
					}
				}
				SceneSingleton<AdventurePlayerController>.Instance.OnPlayerActorsLoaded();
			}
		}
		else
		{
			for (int j = 0; j < playerActors.Count; j++)
			{
				PlayerAdventureActor playerAdventureActor = playerActors.get_Item(j) as PlayerAdventureActor;
				if (!(playerAdventureActor == null) && playerAdventureActor.GetLogicComponent<ActorHealthInfo>().isAlive)
				{
					playerAdventureActor.SyncMovementLocation(position, 0f, num);
				}
			}
		}
		isSpawnActived = true;
	}

	private IEnumerator PlayerSpawnComplete(float delayTime)
	{
		yield return new WaitForSeconds(delayTime);
		PlayerSpawnComplete();
	}

	public void PlayerTransfer()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (null == activedPlayerActor)
		{
			_logger.LogError("角色为空!");
			return;
		}
		activedPlayerActor.Teleport(new TSVector2(transform.position.x, transform.position.z), transform.position.y);
		SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceShow();
		PlayerSpawnComplete();
	}

	protected void PlayerSpawnComplete()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		playerAdventureActor.Visible();
		if (autoRunForwardWhenSpawnDistance > 0)
		{
			Vector3 vector = transform.position + transform.forward * (float)autoRunForwardWhenSpawnDistance;
			SceneSingleton<AdventurePlayerController>.Instance.Teleporter_PlayRunForward(new TSVector2(vector.x, vector.z), inputEnable);
		}
		else
		{
			SceneSingleton<AdventurePlayerController>.Instance.TeleporterForceShow();
			if (MonoSingleton<GameController>.Instance.entryLevelUIFadeIn)
			{
				SceneSingleton<AdventureIndicatorController>.Instance.FadeInTargetBlobRangeGraphic();
				MonoSingleton<LuaManager>.Instance.FireEvent("ShowPlayerHudRootCanvas");
			}
		}
		if (fadeInDuration > 0f)
		{
			playerAdventureActor.TransparentSwichActorFadeIn(fadeInDuration, 0f, 1f, stopOnFinish: true);
		}
		SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = Singleton<UIGameSystemSetup>.Instance.EnableAttackGizmos;
		AdventurActorSpawnedComplete aEvent = AdventurActorSpawnedComplete.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
	}

	protected void Despawn()
	{
		if (spawnPoolObjs != null)
		{
			for (int i = 0; i < spawnPoolObjs.Count; i++)
			{
				SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_SceneObject(spawnPoolObjs.get_Item(i));
			}
			spawnPoolObjs.Clear();
			spawnPoolObjs = null;
		}
	}
}
