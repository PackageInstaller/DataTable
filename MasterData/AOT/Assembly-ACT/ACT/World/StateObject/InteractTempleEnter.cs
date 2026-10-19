using System;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractTempleEnter")]
public class InteractTempleEnter : StateObjectBase
{
	public InteractEntry entry;

	private TempleEnterData _data;

	private AssetLoadHandle m_Handle;

	private Animator modelAni;

	private bool _timeLineIsPlaying;

	private bool _templeIsUnlock;

	private bool _animChangeFromInteract;

	private CancellationTokenSource _cts;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is TempleEnterData templeEnterData)
		{
			_data = templeEnterData;
			ResetEntryInteractType(entry, InteractType.Button);
			InteractEntry interactEntry = entry;
			interactEntry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(interactEntry.onInteractAsync, new Func<Entity, UniTask>(OnInteractAsync));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			entry.BindInteractState(stateId, 0);
			m_Handle = AssetStationManager.BattleStation.Instantiate(templeEnterData.modelAssetID, transform);
			modelAni = m_Handle.AsGameObject().GetComponent<Animator>();
			_templeIsUnlock = TempleEntiryIsUnlock();
			base.InitStateObject(stateId);
		}
	}

	private async UniTask OnInteractAsync(Entity arg)
	{
		if (!_templeIsUnlock)
		{
			NetEnterState(1).Forget();
			G.service.UnlockTemple(_data.id, (bool b) =>
			{
				Model<TempleModel>.Interface.OnTempleUnlocked(_data.id);
			});
			await PlayEnterTimeLine(isUnlock: false);
			_templeIsUnlock = true;
		}
		else
		{
			RecordSpawnInfo();
			await PlayEnterTimeLine(isUnlock: true);
		}
	}

	private void RecordSpawnInfo()
	{
		int stateWorldAssetUid = _data.stateWorldAssetUid;
		SceneSpawnInfo spawnInfo = new SceneSpawnInfo
		{
			Pos = _data.GetSpawnPos().ToPB(),
			InteractionObjUID = stateWorldAssetUid,
			ChunkID = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(stateWorldAssetUid)
		};
		Singleton<RespawnManager>.instance.RecordSpawnPos(spawnInfo, "神庙入口交互");
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		_cts?.Cancel();
		_cts?.Dispose();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	private void OnInteract(Entity eb)
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		int num = currentStateId;
		if (num == 0 || num == 1)
		{
			entry.EvaluateConditions();
			if (entry.ConditionPassed)
			{
				entry.HandleInteract(eb, interactSource);
			}
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}

	protected override void HandleEnterInteract()
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleEnter();
			break;
		case 1:
			entry.HandleEnter();
			break;
		}
	}

	protected override void HandleExitInteract()
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleExit();
			break;
		case 1:
			entry.HandleExit();
			break;
		}
	}

	public void SetMondel(int stateId)
	{
		if (modelAni != null)
		{
			modelAni.SetInteger("state", stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		switch (currentStateId)
		{
		case 0:
			entry.HandleInit();
			break;
		case 1:
			entry.HandleInit();
			break;
		}
		entry.BindInteractState(stateId, 0);
		SetMondel(stateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		switch (currentStateId)
		{
		case 0:
			entry.HandleUninit();
			break;
		case 1:
			entry.HandleUninit();
			break;
		}
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	private async UniTask PlayEnterTimeLine(bool isUnlock)
	{
		if (!_timeLineIsPlaying)
		{
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = new CancellationTokenSource();
			PlayableDirector timeline = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(isUnlock ? GameLoader.meta.templeUnLockStateTimeline : GameLoader.meta.templeLockStateTimeline);
			timeline.transform.position = transform.position;
			if (Singleton<NewUIManager>.instance.GetTopActivePanel() is BattleMainUIController battleMainUIController && battleMainUIController.GetUIView() is MonoBattleMainBaseView monoBattleMainBaseView)
			{
				await monoBattleMainBaseView.CloseAsync();
			}
			MonoECS.instance.PushPause();
			MonoECS.instance.PushPauseAllInput();
			_timeLineIsPlaying = true;
			timeline.Play();
			await UniTask.WaitUntil(() => timeline.state == PlayState.Paused).AttachExternalCancellation(_cts.Token).SuppressCancellationThrow();
			MonoECS.instance.PopPause();
			MonoECS.instance.PopPauseAllInput();
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(isUnlock ? GameLoader.meta.templeUnLockStateTimeline : GameLoader.meta.templeLockStateTimeline);
			_timeLineIsPlaying = false;
			if (!_cts.Token.IsCancellationRequested)
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEMPLEENTRANCE, new TempleEntranceViewData
				{
					templeId = _data.id
				}).Forget();
			}
		}
	}

	private bool TempleEntiryIsUnlock()
	{
		if (RuntimeConfigs.data.instanceDungeons.TryGetValue(_data.id, out var value))
		{
			return Model<TempleModel>.Interface.IsTempleUnlocked(value.id);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("找不到神庙配置，id:" + _data.id + ", 请检查instanceDungeon表！");
		}
		return false;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return ShowType.Hide;
		}
		entry.EvaluateConditions();
		if (!entry.ConditionPassed)
		{
			return entry.ConditionFailShowType;
		}
		return ShowType.Show;
	}

	public override bool ShowInteractTip()
	{
		if (Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return false;
		}
		entry.EvaluateTipConditions();
		return entry.TipConditionPassed;
	}

	public override bool CanInteract()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return base.CanInteract();
		}
		return false;
	}
}
