using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[AddComponentMenu("")]
public class SoftMaskable : UIBehaviour, IMaterialModifier
{
	private ISoftMask _mask;

	private Graphic _graphic;

	private Material _replacement;

	private bool _affectedByMask;

	private bool _destroyed;

	private Coroutine _delayedInvalidateCoroutine;

	private static List<ISoftMask> s_softMasks = new List<ISoftMask>();

	private static List<Canvas> s_canvases = new List<Canvas>();

	public bool shaderIsNotSupported { get; private set; }

	public bool isMaskingEnabled
	{
		get
		{
			if (mask != null && mask.isAlive && mask.isMaskingEnabled && _affectedByMask)
			{
				return isGraphicMaskable;
			}
			return false;
		}
	}

	public ISoftMask mask
	{
		get
		{
			return _mask;
		}
		private set
		{
			if (_mask != value)
			{
				if (_mask != null)
				{
					replacement = null;
				}
				_mask = ((value != null && value.isAlive) ? value : null);
				Invalidate();
			}
		}
	}

	public bool isDestroyed => _destroyed;

	private Graphic graphic => _graphic ?? (_graphic = gameObject?.GetComponent<Graphic>());

	private bool isGraphicMaskable
	{
		get
		{
			if (!graphic)
			{
				return false;
			}
			MaskableGraphic maskableGraphic = graphic as MaskableGraphic;
			if (!maskableGraphic)
			{
				return true;
			}
			return maskableGraphic.maskable;
		}
	}

	private Material replacement
	{
		get
		{
			return _replacement;
		}
		set
		{
			if (_replacement != value)
			{
				if (_replacement != null && mask != null)
				{
					mask.ReleaseReplacement(_replacement);
				}
				_replacement = value;
			}
		}
	}

	public Material GetModifiedMaterial(Material baseMaterial)
	{
		if (isMaskingEnabled)
		{
			Material material = mask.GetReplacement(baseMaterial);
			replacement = material;
			if ((bool)replacement)
			{
				shaderIsNotSupported = false;
				return replacement;
			}
			if (!baseMaterial.HasDefaultUIShader())
			{
				SetShaderNotSupported(baseMaterial);
			}
		}
		else
		{
			shaderIsNotSupported = false;
			replacement = null;
		}
		return baseMaterial;
	}

	public void Invalidate()
	{
		if (gameObject == null)
		{
			return;
		}
		Graphic graphic = this.graphic;
		if ((object)graphic != null)
		{
			if (ShouldDelayMaterialDirty(graphic))
			{
				QueueDelayedInvalidate();
				return;
			}
			CancelDelayedInvalidate();
			graphic.SetMaterialDirty();
		}
	}

	public void MaskMightChanged()
	{
		if (!_destroyed && isActiveAndEnabled && FindMaskOrDie())
		{
			Invalidate();
		}
	}

	protected override void Awake()
	{
		base.Awake();
		hideFlags = HideFlags.HideInInspector;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (FindMaskOrDie())
		{
			RequestChildTransformUpdate();
			Invalidate();
		}
	}

	protected override void OnDisable()
	{
		CancelDelayedInvalidate();
		base.OnDisable();
		mask = null;
	}

	protected override void OnDestroy()
	{
		CancelDelayedInvalidate();
		base.OnDestroy();
		_destroyed = true;
	}

	protected override void OnTransformParentChanged()
	{
		base.OnTransformParentChanged();
		if (!_destroyed && isActiveAndEnabled)
		{
			FindMaskOrDie();
		}
	}

	protected override void OnCanvasHierarchyChanged()
	{
		base.OnCanvasHierarchyChanged();
		if (!_destroyed && isActiveAndEnabled)
		{
			FindMaskOrDie();
		}
	}

	private void OnTransformChildrenChanged()
	{
		RequestChildTransformUpdate();
	}

	private void RequestChildTransformUpdate()
	{
		mask?.UpdateTransformChildren(transform);
	}

	private bool ShouldDelayMaterialDirty(Graphic targetGraphic)
	{
		if (!isActiveAndEnabled || !(targetGraphic is TMP_SubMeshUI { textComponent: var textComponent }))
		{
			return false;
		}
		if (!(textComponent == null))
		{
			return textComponent.fontSharedMaterial == null;
		}
		return true;
	}

	private void QueueDelayedInvalidate()
	{
		if (_delayedInvalidateCoroutine == null)
		{
			_delayedInvalidateCoroutine = StartCoroutine(DelayedInvalidate());
		}
	}

	private void CancelDelayedInvalidate()
	{
		if (_delayedInvalidateCoroutine != null)
		{
			StopCoroutine(_delayedInvalidateCoroutine);
			_delayedInvalidateCoroutine = null;
		}
	}

	private IEnumerator DelayedInvalidate()
	{
		yield return null;
		_delayedInvalidateCoroutine = null;
		if (!_destroyed && (bool)this && !(gameObject == null))
		{
			Graphic graphic = this.graphic;
			if ((object)graphic != null && !ShouldDelayMaterialDirty(graphic))
			{
				graphic.SetMaterialDirty();
			}
		}
	}

	private bool FindMaskOrDie()
	{
		if (_destroyed)
		{
			return false;
		}
		mask = NearestMask(transform, out _affectedByMask);
		if (mask == null)
		{
			_destroyed = true;
			DestroySelf();
			return false;
		}
		return true;
	}

	private static ISoftMask NearestMask(Transform transform, out bool processedByThisMask)
	{
		processedByThisMask = true;
		ISoftMask softMask = null;
		bool flag = true;
		Transform transform2 = transform;
		while ((bool)transform2)
		{
			if (transform2 != transform)
			{
				ISoftMask iSoftMask = GetISoftMask(transform2, shouldBeEnabled: false);
				if (iSoftMask != null)
				{
					if (softMask == null)
					{
						softMask = iSoftMask;
						flag = processedByThisMask;
					}
					if (iSoftMask.isMaskingEnabled)
					{
						return iSoftMask;
					}
				}
			}
			if (IsOverridingSortingCanvas(transform2))
			{
				processedByThisMask = false;
			}
			transform2 = transform2.parent;
		}
		processedByThisMask = flag;
		return softMask;
	}

	private void DestroySelf()
	{
		if (Application.isPlaying)
		{
			Object.Destroy(this);
		}
		else
		{
			Object.DestroyImmediate(this);
		}
	}

	private static ISoftMask GetISoftMask(Transform current, bool shouldBeEnabled = true)
	{
		ISoftMask component = GetComponent(current, s_softMasks);
		if (component != null && component.isAlive && (!shouldBeEnabled || component.isMaskingEnabled))
		{
			return component;
		}
		return null;
	}

	private static bool IsOverridingSortingCanvas(Transform transform)
	{
		Canvas component = GetComponent(transform, s_canvases);
		if ((bool)component && component.overrideSorting)
		{
			return true;
		}
		return false;
	}

	private static T GetComponent<T>(Component component, List<T> cachedList) where T : class
	{
		component.GetComponents(cachedList);
		using (new ClearListAtExit<T>(cachedList))
		{
			return (cachedList.Count > 0) ? cachedList[0] : null;
		}
	}

	private void SetShaderNotSupported(Material material)
	{
		if (!shaderIsNotSupported)
		{
			Debug.LogWarningFormat(gameObject, "SoftMask will not work on {0} because material {1} doesn't support masking. Add masking support to your material or set Graphic's material to None to use a default one.", graphic, material);
			shaderIsNotSupported = true;
		}
	}
}
