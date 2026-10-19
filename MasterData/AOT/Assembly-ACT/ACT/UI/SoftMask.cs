using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[ExecuteAlways]
[DisallowMultipleComponent]
[AddComponentMenu("UI/Soft Mask", 14)]
[RequireComponent(typeof(RectTransform))]
[HelpURL("https://github.com/olegknyazev/SoftMask/blob/bf89dda09b9ac46f7baa6f2ec53448eeb319c605/Packages/com.olegknyazev.softmask/Documentation%7E/Documentation.pdf")]
public class SoftMask : UIBehaviour, ISoftMask, ICanvasRaycastFilter
{
	[Serializable]
	public enum MaskSource
	{
		Rect,
		Texture2D
	}

	private struct SourceParameters
	{
		public Vector4 maskRect;

		public Vector4 rectData;

		public bool HDir;

		public bool VDir;

		public float scopeH;

		public float scopeV;

		public Texture2D texture2D;
	}

	private class ImageMaterialReplacer : IMaterialReplacer
	{
		private Material uiSoftMask;

		public int order => 0;

		public ImageMaterialReplacer(Material uiSoftMask)
		{
			this.uiSoftMask = uiSoftMask;
		}

		public Material Replace(Material original)
		{
			if (original != null && original.HasDefaultUIShader())
			{
				Material material = new Material(uiSoftMask);
				if ((bool)material && (bool)original)
				{
					material.CopyPropertiesFromMaterial(original);
				}
				return material;
			}
			if (original != null && original.IsMapBackGround())
			{
				return original;
			}
			if (original != null && original.IsMistyMap())
			{
				return original;
			}
			if (original != null && original.UseSoftMask())
			{
				return new Material(original);
			}
			return null;
		}
	}

	private static class Mathr
	{
		public static Vector4 ToVector(Rect r)
		{
			return new Vector4(r.xMin, r.yMin, r.xMax, r.yMax);
		}

		public static Vector4 Div(Vector4 v, Vector2 s)
		{
			return new Vector4(v.x / s.x, v.y / s.y, v.z / s.x, v.w / s.y);
		}

		public static Vector2 Div(Vector2 v, Vector2 s)
		{
			return new Vector2(v.x / s.x, v.y / s.y);
		}

		public static Vector4 Mul(Vector4 v, Vector2 s)
		{
			return new Vector4(v.x * s.x, v.y * s.y, v.z * s.x, v.w * s.y);
		}

		public static Vector2 Size(Vector4 r)
		{
			return new Vector2(r.z - r.x, r.w - r.y);
		}

		public static Vector4 ApplyBorder(Vector4 v, Vector4 b)
		{
			return new Vector4(v.x + b.x, v.y + b.y, v.z - b.z, v.w - b.w);
		}

		private static Vector2 Min(Vector4 r)
		{
			return new Vector2(r.x, r.y);
		}

		private static Vector2 Max(Vector4 r)
		{
			return new Vector2(r.z, r.w);
		}

		public static Vector2 Remap(Vector2 c, Vector4 from, Vector4 to)
		{
			Vector2 s = Max(from) - Min(from);
			Vector2 b = Max(to) - Min(to);
			return Vector2.Scale(Div(c - Min(from), s), b) + Min(to);
		}

		public static bool Inside(Vector2 v, Vector4 r)
		{
			if (v.x >= r.x && v.y >= r.y && v.x <= r.z)
			{
				return v.y <= r.w;
			}
			return false;
		}
	}

	public struct MaterialParameters
	{
		public static class Ids
		{
			public static readonly int rectId = Shader.PropertyToID("_SoftMask_Rect");

			public static readonly int scopeId = Shader.PropertyToID("_Scope");

			public static readonly int useSoftMaskId = Shader.PropertyToID("_UseSoftMask");

			public static readonly int softMaskTexture = Shader.PropertyToID("_SoftMaskTexture");
		}

		public Vector4 maskRect;

		public Vector4 rectData;

		public bool HDir;

		public bool VDir;

		public float scopeH;

		public float scopeV;

		public Texture2D texture2D;

		public Vector4 useSoftMaskId
		{
			get
			{
				if ((bool)texture2D)
				{
					return new Vector4(1f, 1f, 0f, 0f);
				}
				return new Vector4(1f, 0f, HDir ? 1 : 0, VDir ? 1 : 0);
			}
		}

		public bool SampleMask(Vector2 localPos)
		{
			if (texture2D == null)
			{
				return true;
			}
			Vector2 vector = XY2UV(localPos);
			return texture2D.GetPixelBilinear(vector.x, vector.y).a > 0.001f;
		}

		public void Apply(Material mat)
		{
			mat.SetVector(Ids.rectId, rectData);
			mat.SetVector(Ids.scopeId, new Vector4(scopeH, scopeV, 0f, 0f));
			mat.SetVector(Ids.useSoftMaskId, useSoftMaskId);
			mat.SetTexture(Ids.softMaskTexture, texture2D);
		}

		private Vector2 XY2UV(Vector2 localPos)
		{
			return Mathr.Remap(localPos, maskRect, new Vector4(0f, 0f, 1f, 1f));
		}

		private float Inset(float v, float x1, float x2, float u1, float u2, float repeat = 1f)
		{
			float num = x2 - x1;
			return Mathf.Lerp(u1, u2, (num != 0f) ? Frac((v - x1) / num * repeat) : 0f);
		}

		private float Inset(float v, float x1, float x2, float x3, float x4, float u1, float u2, float u3, float u4, float repeat = 1f)
		{
			if (v < x2)
			{
				return Inset(v, x1, x2, u1, u2);
			}
			if (v < x3)
			{
				return Inset(v, x2, x3, u2, u3, repeat);
			}
			return Inset(v, x3, x4, u3, u4);
		}

		private float Frac(float v)
		{
			return v - Mathf.Floor(v);
		}
	}

	private struct WarningReporter(UnityEngine.Object owner)
	{
		private readonly UnityEngine.Object _owner = owner;

		private Texture _lastReadTexture = null;

		private Sprite _lastUsedSprite = null;

		private Sprite _lastUsedImageSprite = null;

		private Image.Type _lastUsedImageType = Image.Type.Simple;
	}

	[SerializeField]
	private RectTransform _separateMask;

	private float _raycastThreshold;

	[SerializeField]
	private MaskSource _source;

	public bool HDir = true;

	public float scopeH = 15f;

	public bool VDir = true;

	public float scopeV = 15f;

	public Texture2D texture2D;

	[SerializeField]
	private Material uiSoftMask;

	[SerializeField]
	private ComputeShader softMaskCs;

	private MaterialReplacements _materials;

	private MaterialParameters _parameters;

	private WarningReporter _warningReporter;

	private Rect _lastMaskRect;

	private bool _maskingWasEnabled;

	private bool _destroyed;

	private bool _dirty;

	private readonly Queue<Transform> _transformsToSpawnMaskablesIn = new Queue<Transform>();

	private readonly HashSet<Transform> _queuedTransformsToSpawnMaskablesIn = new HashSet<Transform>();

	private readonly List<ParticleSystem> _updateParticleSystems = new List<ParticleSystem>();

	private readonly List<Canvas> _parentCanvases = new List<Canvas>();

	private readonly Vector3[] _worldCorners = new Vector3[4];

	private RectTransform _maskTransform;

	private Graphic _graphic;

	private Canvas _canvas;

	private static readonly List<SoftMaskable> s_maskables = new List<SoftMaskable>();

	private MaterialReplacements Materials
	{
		get
		{
			if (_materials == null)
			{
				MaterialReplacerChain replacer = new MaterialReplacerChain(new List<IMaterialReplacer>
				{
					new TextMeshProMaterialReplacer()
				}, new ImageMaterialReplacer(uiSoftMask));
				_materials = new MaterialReplacements(replacer, (Material m) =>
				{
					_parameters.Apply(m);
				});
			}
			return _materials;
		}
	}

	public MaterialParameters Parameters => _parameters;

	public MaskSource source
	{
		get
		{
			return _source;
		}
		set
		{
			if (_source != value)
			{
				Set(ref _source, value);
			}
		}
	}

	public RectTransform separateMask
	{
		get
		{
			return _separateMask;
		}
		set
		{
			if (_separateMask != value)
			{
				Set(ref _separateMask, value);
				_graphic = null;
				_maskTransform = null;
			}
		}
	}

	public float raycastThreshold
	{
		get
		{
			return _raycastThreshold;
		}
		set
		{
			_raycastThreshold = value;
		}
	}

	public bool isUsingRaycastFiltering => _raycastThreshold > 0f;

	public bool isMaskingEnabled
	{
		get
		{
			if (isActiveAndEnabled)
			{
				return canvas;
			}
			return false;
		}
	}

	private RectTransform maskTransform
	{
		get
		{
			if (!_maskTransform)
			{
				return _maskTransform = (_separateMask ? _separateMask : GetComponent<RectTransform>());
			}
			return _maskTransform;
		}
	}

	private Canvas canvas
	{
		get
		{
			if (!_canvas)
			{
				return _canvas = NearestEnabledCanvas();
			}
			return _canvas;
		}
	}

	bool ISoftMask.isAlive
	{
		get
		{
			if ((bool)this)
			{
				return !_destroyed;
			}
			return false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		_warningReporter = new WarningReporter(this);
	}

	public bool IsRaycastLocationValid(Vector2 sp, Camera cam)
	{
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(maskTransform, sp, cam, out var localPoint))
		{
			return false;
		}
		if (!Mathr.Inside(localPoint, LocalMaskRect(Vector4.zero)))
		{
			return false;
		}
		return _parameters.SampleMask(localPoint);
	}

	public bool CanSee(Vector3 worldPos)
	{
		return _parameters.SampleMask(maskTransform.InverseTransformPoint(worldPos));
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		SubscribeOnWillRenderCanvases();
		MarkTransformForMaskablesSpawn(transform);
		FindGraphic();
		if (isMaskingEnabled)
		{
			UpdateMaskParameters();
		}
		NotifyChildrenThatMaskMightChanged();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		UnsubscribeFromWillRenderCanvases();
		if ((bool)_graphic)
		{
			_graphic.UnregisterDirtyVerticesCallback(OnGraphicDirty);
			_graphic.UnregisterDirtyMaterialCallback(OnGraphicDirty);
			_graphic = null;
		}
		_maskingWasEnabled = false;
		if (gameObject.activeInHierarchy)
		{
			NotifyChildrenThatMaskMightChanged();
		}
		else
		{
			_transformsToSpawnMaskablesIn.Clear();
			_queuedTransformsToSpawnMaskablesIn.Clear();
			_updateParticleSystems.Clear();
		}
		DestroyMaterials();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		_destroyed = true;
		if (gameObject.activeInHierarchy)
		{
			NotifyChildrenThatMaskMightChanged();
		}
	}

	protected virtual void LateUpdate()
	{
		bool flag = true;
		if (Application.isPlaying)
		{
			flag = isMaskingEnabled != _maskingWasEnabled;
			if (!flag && _transformsToSpawnMaskablesIn.Count == 0)
			{
				return;
			}
		}
		if (flag)
		{
			MarkTransformForMaskablesSpawn(transform);
		}
		SpawnMaskables();
		if (flag)
		{
			Graphic graphic = _graphic;
			FindGraphic();
			if (_lastMaskRect != maskTransform.rect || (object)_graphic != graphic)
			{
				_dirty = true;
			}
			_maskingWasEnabled = isMaskingEnabled;
		}
	}

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		_dirty = true;
	}

	protected override void OnDidApplyAnimationProperties()
	{
		base.OnDidApplyAnimationProperties();
		_dirty = true;
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		_canvas = null;
		_dirty = true;
	}

	protected override void OnCanvasHierarchyChanged()
	{
		base.OnCanvasHierarchyChanged();
		_canvas = null;
		_dirty = true;
		NotifyChildrenThatMaskMightChanged();
	}

	private void OnTransformChildrenChanged()
	{
		MarkTransformForMaskablesSpawn(transform);
	}

	private void MarkTransformForMaskablesSpawn(Transform transform)
	{
		if ((bool)transform && _queuedTransformsToSpawnMaskablesIn.Add(transform))
		{
			_transformsToSpawnMaskablesIn.Enqueue(transform);
		}
	}

	private void SpawnMaskables()
	{
		while (_transformsToSpawnMaskablesIn.Count > 0)
		{
			Transform transform = _transformsToSpawnMaskablesIn.Dequeue();
			_queuedTransformsToSpawnMaskablesIn.Remove(transform);
			if ((bool)transform)
			{
				SpawnMaskablesInChildren(transform);
			}
		}
	}

	public void UpdateMaskablesInChildrenImmediate(Transform parent)
	{
		if (isMaskingEnabled)
		{
			UpdateMaskParameters();
			ProcessTransformRecursive(parent);
		}
	}

	private void ProcessTransformRecursive(Transform target)
	{
		if (RemoveInputFieldCaretSoftMaskable(target))
		{
			return;
		}
		if (target.GetComponent<Graphic>() != null || target.TryGetComponent<ParticleSystem>(out var _))
		{
			using (new ClearListAtExit<SoftMaskable>(s_maskables))
			{
				target.GetComponents(s_maskables);
				if (!HasAliveMaskable(s_maskables))
				{
					target.gameObject.AddComponent<SoftMaskable>();
				}
				if (target.TryGetComponent<ParticleSystem>(out var component2))
				{
					Renderer component3 = component2.GetComponent<Renderer>();
					if (component3 != null)
					{
						Material material = component3.material;
						material.SetVector(MaterialParameters.Ids.rectId, _parameters.rectData);
						material.SetVector(MaterialParameters.Ids.scopeId, new Vector4(_parameters.scopeH, _parameters.scopeV, 0f, 0f));
						material.SetVector(MaterialParameters.Ids.useSoftMaskId, _parameters.useSoftMaskId);
						material.SetTexture(MaterialParameters.Ids.softMaskTexture, _parameters.texture2D);
					}
				}
			}
		}
		for (int i = 0; i < target.childCount; i++)
		{
			ProcessTransformRecursive(target.GetChild(i));
		}
	}

	private static bool IsInputFieldCaret(Transform target)
	{
		if (target.GetComponent<TMP_SelectionCaret>() != null)
		{
			return target.GetComponentInParent<TMP_InputField>() != null;
		}
		return false;
	}

	private static bool RemoveInputFieldCaretSoftMaskable(Transform target)
	{
		if (!IsInputFieldCaret(target))
		{
			return false;
		}
		SoftMaskable component = target.GetComponent<SoftMaskable>();
		if (component != null)
		{
			component.enabled = false;
			UnityEngine.Object.Destroy(component);
		}
		return true;
	}

	private void SubscribeOnWillRenderCanvases()
	{
		Touch(CanvasUpdateRegistry.instance);
		Canvas.willRenderCanvases += OnWillRenderCanvases;
	}

	private void UnsubscribeFromWillRenderCanvases()
	{
		Canvas.willRenderCanvases -= OnWillRenderCanvases;
	}

	private void OnWillRenderCanvases()
	{
		SpawnMaskables();
		if (isMaskingEnabled)
		{
			UpdateMaskParameters();
			UpdateParticleSystemParams();
		}
	}

	private static T Touch<T>(T obj)
	{
		return obj;
	}

	Material ISoftMask.GetReplacement(Material original)
	{
		return Materials.Get(original);
	}

	void ISoftMask.ReleaseReplacement(Material replacement)
	{
		Materials.Release(replacement);
	}

	void ISoftMask.UpdateTransformChildren(Transform transform)
	{
		MarkTransformForMaskablesSpawn(transform);
	}

	private void OnGraphicDirty()
	{
		_dirty = true;
	}

	private void FindGraphic()
	{
		if (!_graphic)
		{
			_graphic = maskTransform.GetComponent<Graphic>();
			if ((bool)_graphic)
			{
				_graphic.RegisterDirtyVerticesCallback(OnGraphicDirty);
				_graphic.RegisterDirtyMaterialCallback(OnGraphicDirty);
			}
		}
	}

	private Canvas NearestEnabledCanvas()
	{
		_parentCanvases.Clear();
		GetComponentsInParent(includeInactive: false, _parentCanvases);
		Canvas result = null;
		for (int i = 0; i < _parentCanvases.Count; i++)
		{
			Canvas canvas = _parentCanvases[i];
			if (canvas.isActiveAndEnabled)
			{
				result = canvas;
				break;
			}
		}
		_parentCanvases.Clear();
		return result;
	}

	private void UpdateMaskParameters()
	{
		if (_dirty || maskTransform.hasChanged)
		{
			CalculateMaskParameters();
			maskTransform.hasChanged = false;
			_lastMaskRect = maskTransform.rect;
			_dirty = false;
		}
		Materials.ApplyAll();
	}

	private void SpawnMaskablesInChildren(Transform root)
	{
		using (new ClearListAtExit<SoftMaskable>(s_maskables))
		{
			for (int i = 0; i < root.childCount; i++)
			{
				Transform child = root.GetChild(i);
				if (!RemoveInputFieldCaretSoftMaskable(child))
				{
					child.GetComponents(s_maskables);
					if (!HasAliveMaskable(s_maskables))
					{
						child.gameObject.AddComponent<SoftMaskable>();
					}
					if (child.TryGetComponent<ParticleSystem>(out var component))
					{
						_updateParticleSystems.Add(component);
					}
				}
			}
		}
	}

	private void NotifyChildrenThatMaskMightChanged()
	{
		transform.GetComponentsInChildren(includeInactive: true, s_maskables);
		using (new ClearListAtExit<SoftMaskable>(s_maskables))
		{
			for (int i = 0; i < s_maskables.Count; i++)
			{
				SoftMaskable softMaskable = s_maskables[i];
				if ((bool)softMaskable && softMaskable.gameObject != gameObject)
				{
					softMaskable.MaskMightChanged();
				}
			}
		}
	}

	private static bool HasAliveMaskable(List<SoftMaskable> maskables)
	{
		for (int i = 0; i < maskables.Count; i++)
		{
			if (!maskables[i].isDestroyed)
			{
				return true;
			}
		}
		return false;
	}

	private void DestroyMaterials()
	{
		Materials.DestroyAllAndClear();
	}

	private void UpdateParticleSystemParams()
	{
		List<ParticleSystem> updateParticleSystems = _updateParticleSystems;
		if (updateParticleSystems == null || updateParticleSystems.Count <= 0)
		{
			return;
		}
		foreach (ParticleSystem updateParticleSystem in _updateParticleSystems)
		{
			Material material = updateParticleSystem.GetComponent<Renderer>().material;
			material.SetVector(MaterialParameters.Ids.rectId, _parameters.rectData);
			material.SetVector(MaterialParameters.Ids.scopeId, new Vector4(_parameters.scopeH, _parameters.scopeV, 0f, 0f));
			material.SetVector(MaterialParameters.Ids.useSoftMaskId, _parameters.useSoftMaskId);
			material.SetTexture(MaterialParameters.Ids.softMaskTexture, _parameters.texture2D);
		}
		_updateParticleSystems.Clear();
	}

	private SourceParameters DeduceSourceParameters()
	{
		SourceParameters result = new SourceParameters
		{
			maskRect = Mathr.ToVector(maskTransform.rect)
		};
		switch (_source)
		{
		case MaskSource.Rect:
			result.rectData = GetRectData();
			result.HDir = HDir;
			result.VDir = VDir;
			result.scopeH = scopeH;
			result.scopeV = scopeV;
			break;
		case MaskSource.Texture2D:
			result.rectData = GetRectData();
			result.texture2D = texture2D;
			break;
		}
		return result;
	}

	private Vector4 GetRectData()
	{
		maskTransform.GetWorldCorners(_worldCorners);
		Vector2 vector = (_worldCorners[0] + _worldCorners[1] + _worldCorners[2] + _worldCorners[3]) / 4f;
		Vector4 vector2 = new Vector4(vector.x, vector.y, Mathf.Abs(_worldCorners[0].x - vector.x), Mathf.Abs(_worldCorners[0].y - vector.y));
		SoftMask parentSoftMask = GetParentSoftMask();
		if (parentSoftMask != null)
		{
			return IntersectRects(vector2, parentSoftMask.GetRectData());
		}
		return vector2;
	}

	private SoftMask GetParentSoftMask()
	{
		Transform parent = transform.parent;
		while (parent != null)
		{
			SoftMask component = parent.GetComponent<SoftMask>();
			if (component != null && component.isMaskingEnabled)
			{
				return component;
			}
			parent = parent.parent;
		}
		return null;
	}

	private Vector4 IntersectRects(Vector4 rect1, Vector4 rect2)
	{
		float a = rect1.x - rect1.z;
		float a2 = rect1.x + rect1.z;
		float a3 = rect1.y + rect1.w;
		float a4 = rect1.y - rect1.w;
		float b = rect2.x - rect2.z;
		float b2 = rect2.x + rect2.z;
		float b3 = rect2.y + rect2.w;
		float b4 = rect2.y - rect2.w;
		float num = Mathf.Max(a, b);
		float num2 = Mathf.Min(a2, b2);
		float num3 = Mathf.Min(a3, b3);
		float num4 = Mathf.Max(a4, b4);
		if (num >= num2 || num4 >= num3)
		{
			return Vector4.zero;
		}
		float x = (num + num2) * 0.5f;
		float y = (num4 + num3) * 0.5f;
		float z = (num2 - num) * 0.5f;
		float w = (num3 - num4) * 0.5f;
		return new Vector4(x, y, z, w);
	}

	private void CalculateMaskParameters()
	{
		SourceParameters sourceParameters = DeduceSourceParameters();
		_parameters.maskRect = sourceParameters.maskRect;
		if (source == MaskSource.Rect)
		{
			_parameters.rectData = sourceParameters.rectData;
			_parameters.HDir = sourceParameters.HDir;
			_parameters.VDir = sourceParameters.VDir;
			_parameters.scopeH = sourceParameters.scopeH;
			_parameters.scopeV = sourceParameters.scopeV;
			_parameters.texture2D = null;
		}
		else if (source == MaskSource.Texture2D)
		{
			_parameters.rectData = sourceParameters.rectData;
			_parameters.HDir = true;
			_parameters.VDir = true;
			_parameters.texture2D = sourceParameters.texture2D;
		}
	}

	private Vector4 LocalMaskRect(Vector4 border)
	{
		return Mathr.ApplyBorder(Mathr.ToVector(maskTransform.rect), border);
	}

	private void Set<T>(ref T field, T value)
	{
		field = value;
		_dirty = true;
	}
}
