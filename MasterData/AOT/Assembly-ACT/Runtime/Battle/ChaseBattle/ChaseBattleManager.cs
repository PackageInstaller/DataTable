using System;
using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Event;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Archive;
using UnityEngine;

namespace Runtime.Battle.ChaseBattle;

public class ChaseBattleManager : Singleton<ChaseBattleManager>
{
	public List<RuntimeEntityArchive> Hunter = new List<RuntimeEntityArchive>();

	private int _chaseBattleID;

	private int _lastChunkID;

	private BPCommon _chaseBattleBluePrint;

	public bool IsInChaseBattle { get; private set; }

	public Entity Prey => MonoECS.instance.mainEntity;

	public int ChaseBattleID
	{
		get
		{
			return _chaseBattleID;
		}
		set
		{
			if (_chaseBattleID != 0)
			{
				FinishChaseBattle();
				Singleton<ArchiveManager>.instance.FinishManualArchiving();
			}
			_chaseBattleID = value;
			if (_chaseBattleID != 0)
			{
				StartChaseBattle();
			}
		}
	}

	public BPCommon ChaseBattleBluePrint
	{
		get
		{
			return _chaseBattleBluePrint;
		}
		set
		{
			if ((bool)_chaseBattleBluePrint)
			{
				BPCommon chaseBattleBluePrint = _chaseBattleBluePrint;
				chaseBattleBluePrint.OnDestroyBluePrint = (Action)Delegate.Remove(chaseBattleBluePrint.OnDestroyBluePrint, new Action(RemoveHunters));
			}
			_chaseBattleBluePrint = value;
			if ((bool)_chaseBattleBluePrint)
			{
				BPCommon chaseBattleBluePrint2 = _chaseBattleBluePrint;
				chaseBattleBluePrint2.OnDestroyBluePrint = (Action)Delegate.Combine(chaseBattleBluePrint2.OnDestroyBluePrint, new Action(RemoveHunters));
			}
		}
	}

	public Vector3 SpawnPosition { get; set; }

	public int LastCheckPointChunk => _lastChunkID;

	public override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ChaseBattleFailed, OnChaseFailedEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Map_TP, OnExitEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, OnExitEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ChaseBattleFailed, OnChaseFailedEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Map_TP, OnExitEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, OnExitEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, OnExitEvent);
		_chaseBattleID = 0;
		IsInChaseBattle = false;
		SpawnPosition = Vector3.zero;
		Hunter.Clear();
	}

	private async void OnChaseFailedEvent(BaseEventContent baseEventContent)
	{
		if (!IsInChaseBattle || !Prey.IsAlive())
		{
			return;
		}
		IsInChaseBattle = false;
		MonoECS.instance.PushPauseInteract();
		MonoECS.instance.PushPauseAllInput();
		Singleton<NewUIManager>.instance.BlackScreen.ClearText();
		await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
		{
			fadeInTime = TimeSpan.FromSeconds(0.5)
		});
		Prey.Teleport(SpawnPosition);
		ResetMainEntityState();
		FinishChaseBattle();
		await UniTask.Yield();
		Singleton<ArchiveManager>.instance.ArchiveScrollBack();
		Singleton<ArchiveManager>.instance.FinishManualArchiving((bool b) =>
		{
			if (b)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Chase_Fail, null);
			}
		});
		MonoECS.instance.PopPauseAllInput();
		MonoECS.instance.PopPauseInteract();
	}

	private void OnExitEvent(BaseEventContent baseEventContent)
	{
		if (IsInChaseBattle)
		{
			Singleton<ArchiveManager>.instance.DropAllArchive();
			FinishChaseBattle();
			Singleton<ArchiveManager>.instance.FinishManualArchiving();
		}
	}

	private void StartChaseBattle()
	{
		if (!IsInChaseBattle)
		{
			IsInChaseBattle = true;
			Singleton<ArchiveManager>.instance.StartManualArchiving(Prey.GetCompTransform().physicsPosition);
			PassCheckPoint();
		}
	}

	private void FinishChaseBattle()
	{
		RemoveHunters();
		IsInChaseBattle = false;
		_chaseBattleID = 0;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChaseBattleFinished, null);
	}

	private void RemoveHunters()
	{
		foreach (RuntimeEntityArchive item in Hunter)
		{
			MonoECS.instance.TryRemoveBehave(item.Entity);
			if ((bool)ChaseBattleBluePrint)
			{
				ChaseBattleBluePrint.RemoveSpawnedMonster(item.Entity);
			}
		}
		Hunter.Clear();
	}

	private void ExitChaseBattle()
	{
	}

	public void PassCheckPoint()
	{
		if (!IsInChaseBattle)
		{
			return;
		}
		_lastChunkID = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		foreach (RuntimeEntityArchive item in Hunter)
		{
			item.Position = item.Entity.GetRootTransform().position;
			item.ChunkID = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
			item.HpPercent = item.Entity.GetCompAbility().HpPercent;
		}
		Singleton<ArchiveManager>.instance.UpdateArchive();
	}

	private void ResetMainEntityState()
	{
		Entity prey = Prey;
		MonoECS.instance.ClearMainEntityInput();
		prey.SetFloat("GroundDistance", 0f);
		MonoECS.instance.ForceToIdle(prey);
		prey.GetCompPhysics().SetMovementMode(ACTMovementMode.Walking);
	}
}
