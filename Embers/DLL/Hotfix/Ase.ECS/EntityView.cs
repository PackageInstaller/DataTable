using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.Rendering;

namespace Ase.ECS;

public class EntityView : BaseEntityView
{
	private bool _isOpenChost;

	private bool _createEveryFrame;

	private Vector3 _scale;

	private float _duration;

	private float _interval;

	private List<SkinnedMeshRenderer> _meshRenderForGhost;

	private List<SkinnedMeshRenderer> _partMeshRenderForGhost;

	private Material _shadowMaterial;

	private int _maxCount;

	private List<GhostItem> _items;

	private string _colorTintName;

	private string _propertyType;

	private AnimationCurve _colorTintCurve;

	private bool _isInitedGhostEffectData;

	private bool _isOnlyPartGhost;

	private float _lastTime;

	private Vector3 _lastPos = Vector3.zero;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		Init();
	}

	public void Init()
	{
	}

	private void RefreshPartMeshRef(IReadOnlyList<string> partName)
	{
		_partMeshRenderForGhost.Clear();
		if (!_isOnlyPartGhost)
		{
			return;
		}
		for (int i = 0; i < partName.Count; i++)
		{
			if (mBaseEntity.GetComponent<EntityBoneComponent>().TryGetBoneRoot(partName[i], out var bone) && bone.TryGetComponent<SkinnedMeshRenderer>(out var component))
			{
				_partMeshRenderForGhost.Add(component);
			}
		}
	}

	private void InitGhostEffect(IReadOnlyList<string> partName)
	{
		if (_isInitedGhostEffectData)
		{
			RefreshPartMeshRef(partName);
			return;
		}
		_meshRenderForGhost = CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Get();
		_meshRenderForGhost.Clear();
		base.gameObject.GetComponentsInChildren(_meshRenderForGhost);
		_partMeshRenderForGhost = CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Get();
		_partMeshRenderForGhost.Clear();
		RefreshPartMeshRef(partName);
		_items = new List<GhostItem>();
		_isInitedGhostEffectData = true;
	}

	private void ReFormatIfMobilePlatform()
	{
		if (!_isOnlyPartGhost && _interval < 0.1f && (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.IPhonePlayer))
		{
			_interval = 0.1f * (1f - Mathf.Exp(-32f * _interval));
		}
	}

	public void InitGhost(bool frame, Vector3 chostSizeList, float duration, float interval, Material material, int maxCount, string propertyName, string propertyType, AnimationCurve colorTintCurve, bool isOnlyPartGhost, List<string> pointListName)
	{
		_isOpenChost = true;
		_createEveryFrame = frame;
		_scale = chostSizeList;
		_duration = duration;
		_interval = interval;
		_shadowMaterial = material;
		_maxCount = maxCount;
		_colorTintName = propertyName;
		_propertyType = propertyType;
		_colorTintCurve = colorTintCurve;
		_isOnlyPartGhost = isOnlyPartGhost;
		InitGhostEffect(pointListName);
		ReFormatIfMobilePlatform();
		int num = (_isOnlyPartGhost ? _partMeshRenderForGhost.Count : _meshRenderForGhost.Count);
		if (_maxCount < num)
		{
			_maxCount = num * _maxCount;
		}
	}

	public void HideGhost()
	{
		_isOpenChost = false;
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		GhostShadowUpdate();
	}

	private void GhostShadowUpdate()
	{
		if (!_isOpenChost || (!_createEveryFrame && _lastPos == base.transform.position))
		{
			return;
		}
		_lastPos = base.transform.position;
		if (Time.time - _lastTime < _interval)
		{
			return;
		}
		_lastTime = Time.time;
		if (_meshRenderForGhost == null || _shadowMaterial == null || _items == null)
		{
			return;
		}
		List<SkinnedMeshRenderer> list = (_isOnlyPartGhost ? _partMeshRenderForGhost : _meshRenderForGhost);
		int count = list.Count;
		if (_items.Count > _maxCount)
		{
			int num = Mathf.Min(_items.Count, count);
			for (int i = 0; i < num; i++)
			{
				Object.Destroy(_items[i]?.gameObject);
			}
			_items?.RemoveRange(0, num);
			return;
		}
		for (int j = 0; j < count; j++)
		{
			if (!(list[j] == null) && list[j].gameObject.activeSelf)
			{
				GameObject obj = new GameObject
				{
					hideFlags = HideFlags.HideAndDontSave
				};
				GhostItem ghostItem = obj.AddComponent<GhostItem>();
				_items.Add(ghostItem);
				ghostItem.items = _items;
				ghostItem.propertyType = _propertyType;
				ghostItem.propertyName = _colorTintName;
				ghostItem.ColorTintCurve = _colorTintCurve;
				ghostItem.duration = _duration;
				ghostItem.deleteTime = Time.time + _duration;
				ghostItem.BakedSkinMesh = new Mesh
				{
					hideFlags = HideFlags.HideAndDontSave
				};
				list[j].BakeMesh(ghostItem.BakedSkinMesh);
				obj.AddComponent<MeshFilter>().mesh = ghostItem.BakedSkinMesh;
				MeshRenderer meshRenderer = obj.AddComponent<MeshRenderer>();
				meshRenderer.shadowCastingMode = ShadowCastingMode.Off;
				meshRenderer.material = _shadowMaterial;
				obj.transform.localScale = _scale;
				obj.transform.position = list[j].transform.position;
				obj.transform.rotation = list[j].transform.rotation;
				ghostItem.meshRenderer = meshRenderer;
			}
		}
	}

	public override void OnDispose()
	{
		if (_items != null && _items.Count > 0)
		{
			for (int i = 0; i < _items.Count; i++)
			{
				Object.Destroy(_items[i].gameObject);
			}
			_items.Clear();
		}
		_items = null;
		_isInitedGhostEffectData = false;
		if (_meshRenderForGhost != null)
		{
			_meshRenderForGhost.Clear();
			CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Release(_meshRenderForGhost);
			_meshRenderForGhost = null;
		}
		if (_partMeshRenderForGhost != null)
		{
			_partMeshRenderForGhost.Clear();
			CollectionPool<List<SkinnedMeshRenderer>, SkinnedMeshRenderer>.Release(_partMeshRenderForGhost);
			_partMeshRenderForGhost = null;
		}
		base.OnDispose();
	}
}
