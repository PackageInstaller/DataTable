using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.World.Bloodstain;

public class BloodstainRuntimeManager : Singleton<BloodstainRuntimeManager>
{
	private readonly Dictionary<string, BloodstainView> _viewsById = new Dictionary<string, BloodstainView>();

	private readonly List<BloodstainData> _visibleBloodstains = new List<BloodstainData>();

	private readonly List<string> _removeBuffer = new List<string>();

	private BloodstainView _bloodstainPrefab;

	private AssetLoadHandle _bloodstainPrefabHandle;

	private UnityEngine.Pool.ObjectPool<BloodstainView> _bloodstainViewPool;

	private Transform _root;

	private bool _createdRoot;

	public override void Init()
	{
		base.Init();
		if (Model<BloodstainModel>.HasInstance())
		{
			BloodstainModel bloodstainModel = Model<BloodstainModel>.Interface;
			bloodstainModel.OnBloodstainAddedOrUpdated += OnBloodstainAddedOrUpdated;
			bloodstainModel.OnBloodstainRemoved += OnBloodstainRemoved;
			bloodstainModel.OnChunkBloodstainsChanged += OnChunkBloodstainsChanged;
		}
		_bloodstainPrefabHandle = AssetStationManager.BattleStation.Instantiate(GameLoader.meta.bloodStainReferenceAssetID);
		_bloodstainPrefab = _bloodstainPrefabHandle.AsGameObject().GetComponent<BloodstainView>();
		_bloodstainPrefab.gameObject.SetActive(value: false);
	}

	public override void UnInit()
	{
		base.UnInit();
		if (Model<BloodstainModel>.HasInstance())
		{
			BloodstainModel bloodstainModel = Model<BloodstainModel>.Interface;
			bloodstainModel.OnBloodstainAddedOrUpdated -= OnBloodstainAddedOrUpdated;
			bloodstainModel.OnBloodstainRemoved -= OnBloodstainRemoved;
			bloodstainModel.OnChunkBloodstainsChanged -= OnChunkBloodstainsChanged;
		}
		ReleaseAllViews();
		ClearBloodstainPool();
		if (_createdRoot && _root != null)
		{
			Object.Destroy(_root.gameObject);
		}
		_root = null;
		_createdRoot = false;
		if (_bloodstainPrefabHandle.IsValid && _bloodstainPrefab != null)
		{
			Object.DestroyImmediate(_bloodstainPrefab.gameObject);
			AssetStationManager.BattleStation.Release(_bloodstainPrefabHandle);
			_bloodstainPrefab = null;
		}
	}

	public void SetBloodstainPrefab(BloodstainView prefab)
	{
		if (!(_bloodstainPrefab == prefab))
		{
			ReleaseAllViews();
			ClearBloodstainPool();
			_bloodstainPrefab = prefab;
		}
	}

	public void SetRoot(Transform root)
	{
		_root = root;
	}

	public void RefreshActiveChunk(int chunkId)
	{
		if (!Model<BloodstainModel>.HasInstance())
		{
			return;
		}
		Model<BloodstainModel>.Interface.GetBloodstainsInChunk(chunkId, _visibleBloodstains);
		_removeBuffer.Clear();
		foreach (KeyValuePair<string, BloodstainView> item in _viewsById)
		{
			_removeBuffer.Add(item.Key);
		}
		for (int i = 0; i < _visibleBloodstains.Count; i++)
		{
			BloodstainData bloodstainData = _visibleBloodstains[i];
			_removeBuffer.Remove(bloodstainData.BloodstainId);
			ShowOrUpdate(bloodstainData);
		}
		for (int j = 0; j < _removeBuffer.Count; j++)
		{
			TryReleaseView(_removeBuffer[j]);
		}
		_removeBuffer.Clear();
		_visibleBloodstains.Clear();
	}

	private void OnBloodstainAddedOrUpdated(BloodstainData data)
	{
		if (data.ChunkId == Singleton<GameManager>.instance.worldManager.ActiveChunkId)
		{
			ShowOrUpdate(data);
		}
	}

	private void OnBloodstainRemoved(string bloodstainId, int chunkId)
	{
		TryReleaseView(bloodstainId);
	}

	public void FinishDespawnView(string bloodstainId)
	{
		ReleaseView(bloodstainId);
	}

	private void OnChunkBloodstainsChanged(int chunkId)
	{
		if (chunkId != 0)
		{
			RefreshActiveChunk(chunkId);
		}
	}

	private void ShowOrUpdate(BloodstainData data)
	{
		if (!_viewsById.TryGetValue(data.BloodstainId, out var value))
		{
			if (_bloodstainPrefab == null)
			{
				return;
			}
			value = GetBloodstainView();
			_viewsById.Add(data.BloodstainId, value);
		}
		value.Bind(data);
	}

	private void TryReleaseView(string bloodstainId)
	{
		if (!_viewsById.TryGetValue(bloodstainId, out var value) || !(value != null) || !value.IsDespawning)
		{
			ReleaseView(bloodstainId);
		}
	}

	private void ReleaseView(string bloodstainId)
	{
		if (!_viewsById.TryGetValue(bloodstainId, out var value))
		{
			return;
		}
		_viewsById.Remove(bloodstainId);
		if (value != null)
		{
			value.Release();
			if (_bloodstainViewPool != null)
			{
				_bloodstainViewPool.Release(value);
			}
			else
			{
				Object.Destroy(value.gameObject);
			}
		}
	}

	private BloodstainView GetBloodstainView()
	{
		EnsureBloodstainPool();
		return _bloodstainViewPool.Get();
	}

	private void EnsureBloodstainPool()
	{
		if (_bloodstainViewPool == null)
		{
			_bloodstainViewPool = new UnityEngine.Pool.ObjectPool<BloodstainView>(CreateBloodstainView, OnGetBloodstainView, OnReleaseBloodstainView, OnDestroyBloodstainView);
		}
	}

	private BloodstainView CreateBloodstainView()
	{
		return Object.Instantiate(_bloodstainPrefab, EnsureRoot());
	}

	private void OnGetBloodstainView(BloodstainView view)
	{
		view.transform.SetParent(EnsureRoot(), worldPositionStays: false);
		view.gameObject.SetActive(value: true);
	}

	private void OnReleaseBloodstainView(BloodstainView view)
	{
		view.gameObject.SetActive(value: false);
		if (_root != null)
		{
			view.transform.SetParent(_root, worldPositionStays: false);
		}
	}

	private void OnDestroyBloodstainView(BloodstainView view)
	{
		if (view != null)
		{
			Object.Destroy(view.gameObject);
		}
	}

	private void ClearBloodstainPool()
	{
		if (_bloodstainViewPool != null)
		{
			_bloodstainViewPool.Clear();
			_bloodstainViewPool = null;
		}
	}

	private Transform EnsureRoot()
	{
		if (_root != null)
		{
			return _root;
		}
		Transform transform = MonoECS.instance?.GetRoot(SceneRootType.AttackInteract)?.transform;
		GameObject gameObject = new GameObject("BloodstainRoot");
		if (transform != null)
		{
			gameObject.transform.SetParent(transform, worldPositionStays: false);
		}
		_root = gameObject.transform;
		_createdRoot = true;
		return _root;
	}

	private void ReleaseAllViews()
	{
		foreach (KeyValuePair<string, BloodstainView> item in _viewsById)
		{
			if (item.Value != null)
			{
				item.Value.Release();
				if (_bloodstainViewPool != null)
				{
					_bloodstainViewPool.Release(item.Value);
				}
				else
				{
					Object.Destroy(item.Value.gameObject);
				}
			}
		}
		_viewsById.Clear();
		_visibleBloodstains.Clear();
		_removeBuffer.Clear();
	}
}
