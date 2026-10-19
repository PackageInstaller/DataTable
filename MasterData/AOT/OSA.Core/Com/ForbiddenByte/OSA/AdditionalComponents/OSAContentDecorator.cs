using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using frame8.Logic.Misc.Other.Extensions;

namespace Com.ForbiddenByte.OSA.AdditionalComponents;

public class OSAContentDecorator : MonoBehaviour
{
	public enum InsetEdgeEnum
	{
		START,
		END
	}

	public enum ControlOSAPaddingMode
	{
		DONT_CONTROL,
		ONCE_AT_INIT,
		ADAPTIVE
	}

	[SerializeField]
	private InsetEdgeEnum _InsetEdge;

	[Tooltip("How far from the InsetEdge should this be positioned. Can be normalized ([0, 1]), if InsetIsNormalized=true, or raw. Default is 0")]
	[SerializeField]
	private float _Inset;

	[Tooltip("If false, will interpret the Inset property as the raw distance from InsetEdge, rather than the normalized inset relative to the content's full size")]
	[SerializeField]
	private bool _InsetIsNormalized = true;

	[SerializeField]
	private bool _DisableWhenNotVisible = true;

	[SerializeField]
	[Tooltip("If false, won't be dragged together with the OSA's content when it's pulled when already at the scrolling limit")]
	private bool _AffectedByElasticity;

	[Tooltip("Sets when the OSA's padding from InsetEdge will be controlled to be the same as this object's size.\nOnce at initialization, or adapting continuously, or none (i.e. you'll probably set OSA's padding manually, in case the decorator shouldn't overlap with items).\nOnly works if Inset is 0")]
	[SerializeField]
	private ControlOSAPaddingMode _ControlOSAPaddingAtInsetEdge = ControlOSAPaddingMode.ONCE_AT_INIT;

	[Tooltip("If null, will use the first an implementation of IOSA found in parents")]
	[SerializeField]
	private RectTransform _OSATransform;

	private RectTransform _ParentRT;

	private RectTransform _RT;

	private IOSA _OSA;

	private bool _Initialized;

	private double _LastKnownInset;

	private double _MyLastKnownSize;

	private RectOffset _OSALastKnownPadding = new RectOffset();

	public void Init()
	{
		_RT = transform as RectTransform;
		_ParentRT = _RT.parent as RectTransform;
		if (_OSA == null)
		{
			_OSA = _ParentRT.GetComponentInParent(typeof(IOSA)) as IOSA;
			if (_OSA == null)
			{
				throw new OSAException("Component implementing IOSA not found in parents");
			}
		}
		else
		{
			_OSA = _OSATransform.GetComponent(typeof(IOSA)) as IOSA;
			if (_OSA == null)
			{
				throw new OSAException("Component implementing IOSA not found on the specified object '" + _OSATransform.name + "'");
			}
		}
		if (_OSA.BaseParameters.Viewport != _ParentRT)
		{
			throw new OSAException(typeof(OSAContentDecorator).Name + " can only work when attached to a direct child of OSA's Viewport.");
		}
		if (_ControlOSAPaddingAtInsetEdge != ControlOSAPaddingMode.DONT_CONTROL)
		{
			if (_OSA.IsInitialized)
			{
				Debug.Log("OSA's content padding can't be set after OSA was initialized. You're most probably calling OSA.Init manually(), in which case make sure to also manually call Init() on this decorator, before OSA.Init()");
			}
			else
			{
				SetOSAPadding();
			}
		}
		_OSA.ScrollPositionChanged += OSAScrollPositionChanged;
		_Initialized = true;
	}

	private void Awake()
	{
		gameObject.SetActive(value: false);
		if (!_Initialized)
		{
			Init();
		}
	}

	private void OnEnable()
	{
		if (_Initialized)
		{
			_OSA.ScrollPositionChanged -= OSAScrollPositionChanged;
			_OSA.ScrollPositionChanged += OSAScrollPositionChanged;
		}
	}

	private void OnDisable()
	{
		bool flag = !_DisableWhenNotVisible;
		if (_Initialized & flag)
		{
			_OSA.ScrollPositionChanged -= OSAScrollPositionChanged;
		}
	}

	private void OnDestroy()
	{
		if (_Initialized)
		{
			_OSA.ScrollPositionChanged -= OSAScrollPositionChanged;
		}
	}

	private void Update()
	{
		if (_Initialized && _ControlOSAPaddingAtInsetEdge == ControlOSAPaddingMode.ADAPTIVE)
		{
			AdaptToPadding();
		}
	}

	public void SetInset(float newInset)
	{
		_Inset = newInset;
		if (_OSA != null && _Initialized)
		{
			OSAScrollPositionChanged(0.0);
		}
	}

	public void AdaptToPadding()
	{
		if (_ControlOSAPaddingAtInsetEdge == ControlOSAPaddingMode.ADAPTIVE && _OSA != null && _OSA.IsInitialized)
		{
			Rect rect = _RT.rect;
			LayoutInfo layoutInfoReadonly = _OSA.GetLayoutInfoReadonly();
			double num = rect.size[layoutInfoReadonly.hor0_vert1];
			if (_LastKnownInset != (double)_Inset || _MyLastKnownSize != num || !IsSamePadding(_OSALastKnownPadding, _OSA.BaseParameters.ContentPadding))
			{
				SetPadding(num);
				_OSA.ForceRebuildLayoutNow();
			}
		}
	}

	private void SetOSAPadding()
	{
		double padding = _RT.rect.size[(!_OSA.IsHorizontal) ? 1 : 0];
		SetPadding(padding);
	}

	private void SetPadding(double myNewSize)
	{
		BaseParams baseParameters = _OSA.BaseParameters;
		int num = (int)(myNewSize + (double)_Inset + 0.6000000238418579);
		RectOffset contentPadding = baseParameters.ContentPadding;
		if (_InsetEdge == InsetEdgeEnum.START)
		{
			if (baseParameters.IsHorizontal)
			{
				contentPadding.left = num;
			}
			else
			{
				contentPadding.top = num;
			}
		}
		else if (baseParameters.IsHorizontal)
		{
			contentPadding.right = num;
		}
		else
		{
			contentPadding.bottom = num;
		}
		_LastKnownInset = _Inset;
		_MyLastKnownSize = myNewSize;
		_OSALastKnownPadding = new RectOffset(contentPadding.left, contentPadding.right, contentPadding.top, contentPadding.bottom);
	}

	private bool IsSamePadding(RectOffset a, RectOffset b)
	{
		if (a.left == b.left && a.right == b.right && a.top == b.top)
		{
			return a.bottom == b.bottom;
		}
		return false;
	}

	private void OSAScrollPositionChanged(double scrollPos)
	{
		LayoutInfo layoutInfoReadonly = _OSA.GetLayoutInfoReadonly();
		double num;
		RectTransform.Edge fixedEdge;
		if (_InsetEdge == InsetEdgeEnum.START)
		{
			num = _OSA.ContentVirtualInsetFromViewportStart;
			fixedEdge = layoutInfoReadonly.startEdge;
		}
		else
		{
			num = _OSA.ContentVirtualInsetFromViewportEnd;
			fixedEdge = layoutInfoReadonly.endEdge;
		}
		double num2 = _Inset;
		double num3 = _RT.rect.size[layoutInfoReadonly.hor0_vert1];
		double vpSize = layoutInfoReadonly.vpSize;
		if (_InsetIsNormalized)
		{
			num2 *= _OSA.GetContentSize() - num3;
		}
		double num4 = num + num2;
		bool flag = true;
		if (num4 < 0.0)
		{
			if (num4 <= 0.0 - num3)
			{
				num4 = 0.0 - num3;
				flag = false;
			}
		}
		else if (num4 >= vpSize)
		{
			num4 = vpSize;
			flag = false;
		}
		bool flag2 = false;
		if (!flag)
		{
			flag2 = _DisableWhenNotVisible;
		}
		if (gameObject.activeSelf == flag2)
		{
			gameObject.SetActive(!flag2);
		}
		if (!flag2)
		{
			if (!_AffectedByElasticity && num > 0.1 && num4 > 0.0)
			{
				num4 = _Inset;
			}
			_RT.SetInsetAndSizeFromParentEdgeWithCurrentAnchors(fixedEdge, (float)num4, (float)num3);
		}
	}
}
