using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class ConnectNodeManager : Singleton<ConnectNodeManager>
{
	private const int START_STATE_OPENED = 1;

	private const int START_STATE_LOCK = -1;

	private const int TRANSFER_STATE_HIDE = -3;

	private const int END_STATE_INACTIVE = 0;

	private const int END_STATE_ACTIVE = 1;

	private const int END_STATE_COMPLETED = 2;

	private readonly Dictionary<int, bool> _transferActivationMap = new Dictionary<int, bool>();

	private readonly List<int> _startNodeSwids = new List<int>();

	private readonly List<int> _normalNodeSwids = new List<int>();

	private readonly List<int> _transferNodeSwids = new List<int>();

	private readonly List<int> _endNodeSwids = new List<int>();

	private readonly HashSet<int> _rotatingTransfers = new HashSet<int>();

	private readonly HashSet<int> _activatedPipes = new HashSet<int>();

	private Action<int, bool> _updateActivated;

	public event Action<int, bool> UpdateActivated
	{
		add
		{
			_updateActivated = (Action<int, bool>)Delegate.Combine(_updateActivated, value);
		}
		remove
		{
			_updateActivated = (Action<int, bool>)Delegate.Remove(_updateActivated, value);
		}
	}

	public void RegisterStartNode(int swid)
	{
		if (!_startNodeSwids.Contains(swid))
		{
			_startNodeSwids.Add(swid);
		}
	}

	public void UnregisterStartNode(int swid)
	{
		_startNodeSwids.Remove(swid);
	}

	public void RegisterNormalNode(int swid)
	{
		if (!_normalNodeSwids.Contains(swid))
		{
			_normalNodeSwids.Add(swid);
		}
	}

	public void UnregisterNormalNode(int swid)
	{
		_normalNodeSwids.Remove(swid);
	}

	public void RegisterTransferNode(int swid)
	{
		if (!_transferNodeSwids.Contains(swid))
		{
			_transferNodeSwids.Add(swid);
		}
	}

	public void UnregisterTransferNode(int swid)
	{
		_transferNodeSwids.Remove(swid);
		_rotatingTransfers.Remove(swid);
	}

	public void RegisterEndNode(int swid)
	{
		if (!_endNodeSwids.Contains(swid))
		{
			_endNodeSwids.Add(swid);
		}
	}

	public void UnregisterEndNode(int swid)
	{
		_endNodeSwids.Remove(swid);
	}

	public void SetTransferRotating(int swid, bool rotating)
	{
		if (rotating)
		{
			_rotatingTransfers.Add(swid);
		}
		else
		{
			_rotatingTransfers.Remove(swid);
		}
	}

	public bool IsTransferNodeActivated(int transferSwid)
	{
		bool value;
		return _transferActivationMap.TryGetValue(transferSwid, out value) & value;
	}

	public bool IsNormalNodeActivated(int normalSwid)
	{
		return _activatedPipes.Contains(normalSwid);
	}

	public void RefreshActivationMap()
	{
		_transferActivationMap.Clear();
		_activatedPipes.Clear();
		foreach (int startNodeSwid in _startNodeSwids)
		{
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(startNodeSwid);
			if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID.stateId == 1 && worldStateAssetDataBySGOID is ConnectNodeData { nodeType: ConnectNodeType.Start } connectNodeData)
			{
				TraceFromStartNode(connectNodeData, _activatedPipes);
			}
		}
		foreach (int normalNodeSwid in _normalNodeSwids)
		{
			bool arg = _activatedPipes.Contains(normalNodeSwid);
			_updateActivated?.Invoke(normalNodeSwid, arg);
		}
		foreach (int transferNodeSwid in _transferNodeSwids)
		{
			bool arg2 = _transferActivationMap.TryGetValue(transferNodeSwid, out var value) & value;
			_updateActivated?.Invoke(transferNodeSwid, arg2);
		}
		List<StateChangeInfo> list = new List<StateChangeInfo>();
		foreach (int endNodeSwid in _endNodeSwids)
		{
			StateWorldAssetData worldStateAssetDataBySGOID2 = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(endNodeSwid);
			if (worldStateAssetDataBySGOID2 != null && worldStateAssetDataBySGOID2.stateId != 2 && worldStateAssetDataBySGOID2 is ConnectNodeData { nodeType: ConnectNodeType.End } connectNodeData2)
			{
				int num = (CheckEndNodeAllPipesActivated(connectNodeData2) ? 1 : 0);
				if (worldStateAssetDataBySGOID2.stateId != num)
				{
					list.Add(new StateChangeInfo
					{
						uid = endNodeSwid,
						stateId = num
					});
				}
			}
		}
		if (list.Count > 0)
		{
			MonoECS.instance.ruleManager.SharedChangeStates(list.ToArray());
		}
	}

	private bool CheckEndNodeAllPipesActivated(ConnectNodeData endData)
	{
		if (endData.LinkedNodes == null || endData.LinkedNodes.Length == 0)
		{
			return false;
		}
		StateWorldUid[] linkedNodes = endData.LinkedNodes;
		foreach (StateWorldUid stateWorldUid in linkedNodes)
		{
			if (stateWorldUid != null && stateWorldUid.value != 0 && !_activatedPipes.Contains(stateWorldUid.value))
			{
				return false;
			}
		}
		return true;
	}

	private void TraceFromStartNode(ConnectNodeData startData, HashSet<int> activatedPipes)
	{
		if (startData.LinkedNodes == null)
		{
			return;
		}
		StateWorldUid[] linkedNodes = startData.LinkedNodes;
		foreach (StateWorldUid stateWorldUid in linkedNodes)
		{
			if (stateWorldUid == null || stateWorldUid.value == 0)
			{
				continue;
			}
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldUid.value);
			if (worldStateAssetDataBySGOID == null || !(worldStateAssetDataBySGOID is ConnectNodeData { nodeType: ConnectNodeType.Normal } connectNodeData))
			{
				continue;
			}
			activatedPipes.Add(stateWorldUid.value);
			if (connectNodeData.LinkedNodes == null)
			{
				continue;
			}
			StateWorldUid[] linkedNodes2 = connectNodeData.LinkedNodes;
			foreach (StateWorldUid stateWorldUid2 in linkedNodes2)
			{
				if (stateWorldUid2 != null && stateWorldUid2.value != 0 && Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldUid2.value) is ConnectNodeData { nodeType: ConnectNodeType.Transfer } connectNodeData2)
				{
					TraceTransferNode(connectNodeData2, stateWorldUid2.value, stateWorldUid.value, activatedPipes);
				}
			}
		}
	}

	private void TraceTransferNode(ConnectNodeData transferData, int transferSwid, int sourceSwid, HashSet<int> activatedPipes)
	{
		if (_transferActivationMap.TryGetValue(transferSwid, out var value) & value)
		{
			return;
		}
		if (transferData.stateId == -3 || IsTransferDeactivatedRotationState(transferData) || _rotatingTransfers.Contains(transferSwid))
		{
			_transferActivationMap[transferSwid] = false;
			return;
		}
		List<int> transferConnectedSlots = GetTransferConnectedSlots(transferData);
		if (transferConnectedSlots == null || transferConnectedSlots.Count == 0)
		{
			_transferActivationMap[transferSwid] = false;
			return;
		}
		if (transferData.StateConditions == null)
		{
			_transferActivationMap[transferSwid] = false;
			return;
		}
		bool flag = false;
		StateCondition[] stateConditions = transferData.StateConditions;
		foreach (StateCondition stateCondition in stateConditions)
		{
			if (stateCondition != null && stateCondition.targetInteractSwid.value != 0 && stateCondition.targetInteractSwid.value == sourceSwid && transferConnectedSlots.Contains(stateCondition.index))
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			_transferActivationMap[transferSwid] = false;
			return;
		}
		_transferActivationMap[transferSwid] = true;
		stateConditions = transferData.StateConditions;
		foreach (StateCondition stateCondition2 in stateConditions)
		{
			if (stateCondition2 == null || stateCondition2.targetInteractSwid.value == 0 || stateCondition2.targetInteractSwid.value == sourceSwid || !transferConnectedSlots.Contains(stateCondition2.index))
			{
				continue;
			}
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateCondition2.targetInteractSwid.value);
			if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID is ConnectNodeData { nodeType: var nodeType } connectNodeData)
			{
				switch (nodeType)
				{
				case ConnectNodeType.Transfer:
					TraceTransferNode(connectNodeData, stateCondition2.targetInteractSwid.value, transferSwid, activatedPipes);
					break;
				case ConnectNodeType.Normal:
					activatedPipes.Add(stateCondition2.targetInteractSwid.value);
					TraceThroughPipe(connectNodeData, stateCondition2.targetInteractSwid.value, transferSwid, activatedPipes);
					break;
				}
			}
		}
	}

	private void TraceThroughPipe(ConnectNodeData pipeData, int pipeSwid, int fromTransferSwid, HashSet<int> activatedPipes)
	{
		if (pipeData.LinkedNodes == null)
		{
			return;
		}
		StateWorldUid[] linkedNodes = pipeData.LinkedNodes;
		foreach (StateWorldUid stateWorldUid in linkedNodes)
		{
			if (stateWorldUid != null && stateWorldUid.value != 0 && stateWorldUid.value != fromTransferSwid && Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldUid.value) is ConnectNodeData { nodeType: ConnectNodeType.Transfer } connectNodeData)
			{
				TraceTransferNode(connectNodeData, stateWorldUid.value, pipeSwid, activatedPipes);
			}
		}
	}

	private List<int> GetTransferConnectedSlots(ConnectNodeData transferData)
	{
		Vector3 vector = Vector3.zero;
		if (transferData.TransferStates != null)
		{
			int lookupId = GetTransferRotationStateId(transferData);
			TransferStateConfig transferStateConfig = Array.Find(transferData.TransferStates, (TransferStateConfig s) => s.stateId == lookupId);
			if (transferStateConfig != null)
			{
				vector = transferStateConfig.rotation;
			}
		}
		float rotationZ = NormalizeAngle(vector.z);
		return GetConnectedSlotIndices(transferData.nodeShape, rotationZ);
	}

	private static float NormalizeAngle(float angle)
	{
		angle %= 360f;
		if (angle > 180f)
		{
			angle -= 360f;
		}
		else if (angle <= -180f)
		{
			angle += 360f;
		}
		return angle;
	}

	private static List<int> GetConnectedSlotIndices(TransferNodeShape shape, float rotationZ)
	{
		bool flag = Mathf.Approximately(rotationZ, 0f);
		bool flag2 = Mathf.Approximately(rotationZ, 90f);
		bool flag3 = Mathf.Approximately(rotationZ, 180f);
		bool flag4 = Mathf.Approximately(rotationZ, -90f);
		switch (shape)
		{
		case TransferNodeShape.TShape:
			if (flag)
			{
				return new List<int> { 0, 1, 3 };
			}
			if (flag2)
			{
				return new List<int> { 0, 2, 3 };
			}
			if (flag3)
			{
				return new List<int> { 1, 2, 3 };
			}
			if (flag4)
			{
				return new List<int> { 0, 1, 2 };
			}
			break;
		case TransferNodeShape.Straight:
			if (flag | flag3)
			{
				return new List<int> { 1, 3 };
			}
			if (flag2 | flag4)
			{
				return new List<int> { 0, 2 };
			}
			break;
		case TransferNodeShape.LShape:
			if (flag)
			{
				return new List<int> { 0, 1 };
			}
			if (flag2)
			{
				return new List<int> { 3, 0 };
			}
			if (flag3)
			{
				return new List<int> { 2, 3 };
			}
			if (flag4)
			{
				return new List<int> { 1, 2 };
			}
			break;
		case TransferNodeShape.CrossShape:
			return new List<int> { 0, 1, 2, 3 };
		}
		return new List<int>();
	}

	private bool IsTransferDeactivatedRotationState(ConnectNodeData transferData)
	{
		if (transferData.TransferStates == null || transferData.TransferStates.Length == 0)
		{
			return false;
		}
		int n = transferData.TransferStates.Length;
		return Array.Exists(transferData.TransferStates, (TransferStateConfig s) => s.stateId + 2 * n == transferData.stateId);
	}

	private int GetTransferRotationStateId(ConnectNodeData transferData)
	{
		if (transferData.TransferStates == null || transferData.TransferStates.Length == 0)
		{
			return transferData.stateId;
		}
		int num = transferData.TransferStates.Length;
		int baseId2 = transferData.stateId - 2 * num;
		if (Array.Exists(transferData.TransferStates, (TransferStateConfig s) => s.stateId == baseId2))
		{
			return baseId2;
		}
		int baseId3 = transferData.stateId - num;
		if (Array.Exists(transferData.TransferStates, (TransferStateConfig s) => s.stateId == baseId3))
		{
			return baseId3;
		}
		return transferData.stateId;
	}

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, RefreshActivationMapAfterEnterWorld);
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, RefreshActivationMapAfterEnterWorld);
	}

	public void RefreshActivationMapAfterEnterWorld(BaseEventContent obj)
	{
		RefreshActivationMap();
	}
}
