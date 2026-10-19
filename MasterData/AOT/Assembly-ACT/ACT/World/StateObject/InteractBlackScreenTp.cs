using System;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBlackScreenTp : StateObjectBase
{
	public InteractEntry entry;

	[SerializeField]
	private SwitchBlackScreenTpData _data;

	private CancellationTokenSource m_Cts;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is SwitchBlackScreenTpData data)
		{
			_data = data;
			SwitchBlackScreenTpData.BlackScreenTpSwitchTarget switchPoint = _data.SwitchPoint;
			BoxCollider component = GetComponent<BoxCollider>();
			component.center = switchPoint.TriggerCenter;
			component.size = switchPoint.TriggerSize;
			InteractEntry entryConfig = _data.entryConfig;
			entry = new InteractEntry();
			entry.Clone(entryConfig);
			InteractEntry interactEntry = entry;
			interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteract));
			entry.BindInteractObjectBase(this);
			entry.BindData(compStateObject.StateWorldAssetData);
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0)
		{
			entry.HandleInit();
		}
		base.HandleInitState(stateId);
	}

	private void OnInteract(Entity behave)
	{
		if (Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.MovingPath))
		{
			entry.HandleExit();
			m_Cts = new CancellationTokenSource();
			Moving(behave, m_Cts.Token).Forget();
		}
	}

	private async UniTask Moving(Entity behave, CancellationToken token)
	{
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.MovingPath);
		MonoECS.instance.PushPauseInteract();
		MonoECS.instance.PushPauseAllInput();
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_BATTLEMAIN);
		Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: true);
		SwitchBlackScreenTpData.BlackScreenTpSwitchTarget switchPoint = _data.SwitchPoint;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = switchPoint.TpPos,
			faceLeft = (switchPoint.ExitDir == FaceDir.Left)
		};
		TeleportUtility.TeleportWithPureBlackScreen(switchPoint.ChunkId, teleportParams, switchPoint.FadeDuration, () =>
		{
			Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: false);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			MonoECS.instance.PopPauseAllInput();
			MonoECS.instance.PopPauseInteract();
			MonoECS.instance.RemovePlayerTag(MonoECS.PlayerTag.MovingPath);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_SwitchMotionPath, null);
		}).Forget();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			entry.HandleExit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0)
		{
			entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId == 0)
		{
			entry.HandleUninit();
		}
	}

	protected override bool NeedInteractTip()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null || interactEntry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return entry;
	}

	private void OnDestroy()
	{
		m_Cts?.Cancel();
		m_Cts = null;
	}
}
