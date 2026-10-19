using System;
using System.Collections.Generic;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class BloodstainModel : Model<BloodstainModel>
{
	private readonly Dictionary<string, BloodstainData> _bloodstainsById = new Dictionary<string, BloodstainData>();

	private readonly Dictionary<int, List<string>> _bloodstainIdsByChunk = new Dictionary<int, List<string>>();

	private readonly List<string> _scratchRemoveIds = new List<string>();

	private readonly List<BloodstainData> _scratchBloodstains = new List<BloodstainData>();

	private string _ownBloodstainId;

	private int _currentChunkId;

	public string OwnBloodstainId => _ownBloodstainId;

	public bool OtherBloodstainDisabled { get; set; }

	public event Action<BloodstainData> OnBloodstainAddedOrUpdated;

	public event Action<string, int> OnBloodstainRemoved;

	public event Action<int> OnChunkBloodstainsChanged;

	protected override void Init()
	{
		_bloodstainsById.Clear();
		_bloodstainIdsByChunk.Clear();
		_scratchRemoveIds.Clear();
		_scratchBloodstains.Clear();
		_ownBloodstainId = null;
		_currentChunkId = 0;
		OtherBloodstainDisabled = false;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		if (worldManager.ActiveChunkId > 0)
		{
			OnChunkChanged(worldManager.ActiveChunkId, _currentChunkId);
		}
	}

	protected override void UnInit()
	{
		_bloodstainsById.Clear();
		_bloodstainIdsByChunk.Clear();
		_scratchRemoveIds.Clear();
		_scratchBloodstains.Clear();
		_ownBloodstainId = null;
		_currentChunkId = 0;
		OtherBloodstainDisabled = false;
		OnBloodstainAddedOrUpdated = null;
		OnBloodstainRemoved = null;
		OnChunkBloodstainsChanged = null;
	}

	private void OnChunkChanged(int chunkId, int _oldChunkId)
	{
		if (chunkId > 0 && chunkId != _currentChunkId)
		{
			int currentChunkId = _currentChunkId;
			_currentChunkId = chunkId;
			if (currentChunkId > 0)
			{
				ClearChunkBloodstains(currentChunkId);
			}
			OnChunkBloodstainsChanged?.Invoke(chunkId);
		}
	}

	public void RequestCreateLocalBloodstain(Vector3 deathPosition, Quaternion deathRotation)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		BloodstainCreateRequest request = new BloodstainCreateRequest(worldManager.ActiveChunkId, deathPosition, deathRotation);
		G.service?.CreateBloodstain(request, (bool success, BloodstainData serverData) =>
		{
			if (success && serverData != null)
			{
				ReplaceOwnBloodstain(serverData);
			}
		});
	}

	public void ApplyBloodStainNotify(BloodStainNotify notify)
	{
		if (notify == null)
		{
			return;
		}
		OtherBloodstainDisabled = notify.OtherBloodstainDisabled;
		bool flag = TryCreateBloodstainData(notify.SelfBloodstain, out var data);
		BloodstainData data2;
		if (flag)
		{
			ReplaceOwnBloodstain(data);
		}
		else if (!string.IsNullOrEmpty(_ownBloodstainId) && TryGetBloodstain(_ownBloodstainId, out data2) && data2.ChunkId == notify.ChunkId)
		{
			RemoveBloodstain(_ownBloodstainId);
		}
		_scratchBloodstains.Clear();
		for (int i = 0; i < notify.Bloodstains.Count; i++)
		{
			if (TryCreateBloodstainData(notify.Bloodstains[i], out var data3))
			{
				_scratchBloodstains.Add(data3);
			}
		}
		SetChunkBloodstains(notify.ChunkId, _scratchBloodstains, flag);
		_scratchBloodstains.Clear();
	}

	public static bool TryCreateBloodstainData(Bloodstain bloodstain, out BloodstainData data)
	{
		data = null;
		if (bloodstain == null)
		{
			return false;
		}
		if (string.IsNullOrEmpty(bloodstain.Id) || bloodstain.State == BloodstainState.Interacted)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("Bloodstain id is invalid: " + bloodstain.Id);
			}
			return false;
		}
		data = new BloodstainData
		{
			BloodstainId = bloodstain.Id,
			OwnerPlayerUid = bloodstain.OwnerAccountId,
			ChunkId = bloodstain.ChunkID,
			Position = ((bloodstain.Position != null) ? bloodstain.Position.ToUnity() : Vector3.zero),
			Rotation = Quaternion.identity,
			CreateTs = bloodstain.CreateTs,
			State = BloodstainState.Initial
		};
		return true;
	}

	private void ReplaceOwnBloodstain(BloodstainData data)
	{
		if (data != null && !string.IsNullOrEmpty(data.BloodstainId))
		{
			if (!string.IsNullOrEmpty(_ownBloodstainId) && data.BloodstainId != _ownBloodstainId)
			{
				RemoveBloodstain(_ownBloodstainId);
			}
			_ownBloodstainId = data.BloodstainId;
			UpsertBloodstain(data);
		}
	}

	public void SetChunkBloodstains(int chunkId, IList<BloodstainData> bloodstains, bool keepOwnBloodstain = false)
	{
		ClearChunkBloodstains(chunkId, keepOwnBloodstain);
		if (bloodstains != null)
		{
			for (int i = 0; i < bloodstains.Count; i++)
			{
				UpsertBloodstain(bloodstains[i]);
			}
		}
		OnChunkBloodstainsChanged?.Invoke(chunkId);
	}

	private void ClearChunkBloodstains(int chunkId, bool keepOwnBloodstain = false)
	{
		_scratchRemoveIds.Clear();
		if (_bloodstainIdsByChunk.TryGetValue(chunkId, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				_scratchRemoveIds.Add(value[i]);
			}
		}
		for (int j = 0; j < _scratchRemoveIds.Count; j++)
		{
			string text = _scratchRemoveIds[j];
			if (!keepOwnBloodstain || !(text == _ownBloodstainId))
			{
				RemoveBloodstain(text);
			}
		}
		_scratchRemoveIds.Clear();
	}

	public void UpsertBloodstain(BloodstainData data)
	{
		if (data != null && !string.IsNullOrEmpty(data.BloodstainId) && data.State != BloodstainState.Interacted)
		{
			if (_bloodstainsById.TryGetValue(data.BloodstainId, out var value) && value.ChunkId != data.ChunkId)
			{
				RemoveIdFromChunk(value.ChunkId, data.BloodstainId);
			}
			_bloodstainsById[data.BloodstainId] = data.Clone();
			AddIdToChunk(data.ChunkId, data.BloodstainId);
			OnBloodstainAddedOrUpdated?.Invoke(data);
		}
	}

	public bool RemoveBloodstain(string bloodstainId)
	{
		if (string.IsNullOrEmpty(bloodstainId))
		{
			return false;
		}
		if (!_bloodstainsById.TryGetValue(bloodstainId, out var value))
		{
			return false;
		}
		_bloodstainsById.Remove(bloodstainId);
		RemoveIdFromChunk(value.ChunkId, bloodstainId);
		if (_ownBloodstainId == bloodstainId)
		{
			_ownBloodstainId = null;
		}
		OnBloodstainRemoved?.Invoke(bloodstainId, value.ChunkId);
		OnChunkBloodstainsChanged?.Invoke(value.ChunkId);
		return true;
	}

	public bool TryGetBloodstain(string bloodstainId, out BloodstainData data)
	{
		if (string.IsNullOrEmpty(bloodstainId))
		{
			data = null;
			return false;
		}
		return _bloodstainsById.TryGetValue(bloodstainId, out data);
	}

	public void GetBloodstainsInChunk(int chunkId, List<BloodstainData> output)
	{
		output.Clear();
		if (!_bloodstainIdsByChunk.TryGetValue(chunkId, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			if (_bloodstainsById.TryGetValue(value[i], out var value2))
			{
				output.Add(value2);
			}
		}
	}

	private void AddIdToChunk(int chunkId, string bloodstainId)
	{
		if (!_bloodstainIdsByChunk.TryGetValue(chunkId, out var value))
		{
			value = new List<string>(4);
			_bloodstainIdsByChunk.Add(chunkId, value);
		}
		if (!value.Contains(bloodstainId))
		{
			value.Add(bloodstainId);
		}
	}

	private void RemoveIdFromChunk(int chunkId, string bloodstainId)
	{
		if (_bloodstainIdsByChunk.TryGetValue(chunkId, out var value))
		{
			value.Remove(bloodstainId);
			if (value.Count == 0)
			{
				_bloodstainIdsByChunk.Remove(chunkId);
			}
		}
	}
}
