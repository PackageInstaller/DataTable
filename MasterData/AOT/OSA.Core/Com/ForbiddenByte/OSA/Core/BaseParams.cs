using System;
using Com.ForbiddenByte.OSA.Core.Data.Animations;
using Com.ForbiddenByte.OSA.Core.Data.Gallery;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;
using frame8.Logic.Misc.Other.Extensions;

namespace Com.ForbiddenByte.OSA.Core;

[Serializable]
public class BaseParams
{
	public enum OrientationEnum
	{
		VERTICAL,
		HORIZONTAL
	}

	public enum ContentGravity
	{
		FROM_PIVOT,
		START,
		CENTER,
		END
	}

	[Serializable]
	public class Effects
	{
		public const float DEFAULT_MAX_SPEED = 10000f;

		public const float MAX_SPEED = 1000000f;

		public const float MAX_SPEED_IF_LOOPING = 10000f;

		[Tooltip("This RawImage will be scrolled together with the content. \nThe content is always stationary (this is the way the recycling process works), so the scrolling effect is faked by scrolling the texture's x/y.\nTip: use a seamless/looping background texture for best visual results")]
		[FormerlySerializedAs("contentVisual")]
		[SerializeField]
		private RawImage _ContentVisual;

		[FormerlySerializedAs("elasticMovement")]
		[SerializeField]
		private bool _ElasticMovement = true;

		[SerializeField]
		[FormerlySerializedAs("pullElasticity")]
		private float _PullElasticity = 0.3f;

		[FormerlySerializedAs("releaseTime")]
		[SerializeField]
		private float _ReleaseTime = 0.1f;

		[FormerlySerializedAs("inertia")]
		[SerializeField]
		private bool _Inertia = true;

		[FormerlySerializedAs("inertiaDecelerationRate")]
		[SerializeField]
		[Range(0f, 1f)]
		[Tooltip("What percent (0=0%, 1=100%) of the velociy will be lost per second after the drag ended. 1=all(immediate stop), 0=none(maitain constant scrolling speed indefinitely)")]
		private float _InertiaDecelerationRate = 0.865f;

		[Tooltip("Stop any movement from inertia or scrolling animations when a mouse click/touch begins")]
		[SerializeField]
		private bool _CutMovementOnPointerDown = true;

		[SerializeField]
		[FormerlySerializedAs("maxSpeed")]
		private float _MaxSpeed = 10000f;

		[Tooltip("If enabled, multiple drags in the same direction will lead to greater speeds")]
		[SerializeField]
		private bool _TransientSpeedBetweenDrags = true;

		[Tooltip("If true: When the last item is reached, the first one appears after it, basically allowing you to scroll infinitely.\n Initially intended for things like spinners, but it can be used for anything alike.\n It may interfere with other functionalities in some very obscure/complex contexts/setups, so be sure to test the hell out of it.\n Also please note that sometimes during dragging the content, the actual looping changes the Unity's internal PointerEventData for the current click/touch pointer id, so if you're also externally tracking the current click/touch, in this case only 'PointerEventData.pointerCurrentRaycast' and 'PointerEventData.position'(current position) are preserved, the other ones are reset to defaults to assure a smooth loop transition. Sorry for the long decription. Here's an ASCII potato: @")]
		[FormerlySerializedAs("loopItems")]
		[SerializeField]
		private bool _LoopItems;

		[Range(-5f, 5f)]
		[Tooltip("The contentVisual's additional drag factor. Examples:\n-2: the contentVisual will move exactly by the same amount as the items, but in the opposite direction\n-1: no movement\n 0: same speed (together with the items)\n 1: 2x faster in the same direction\n 2: 3x faster etc.")]
		[SerializeField]
		private float _ContentVisualParallaxEffect = -0.85f;

		[SerializeField]
		private GalleryEffectParams _Gallery = new GalleryEffectParams();

		[FormerlySerializedAs("galleryEffectAmount")]
		[SerializeField]
		[HideInInspector]
		[Range(0f, 1f)]
		private float _GalleryEffectAmount;

		[Range(0f, 1f)]
		[SerializeField]
		[FormerlySerializedAs("galleryEffectViewportPivot")]
		[HideInInspector]
		private float _GalleryEffectViewportPivot = 0.5f;

		private bool _HasContentVisual;

		[Obsolete("Use ContentVisual instead", true)]
		public RawImage contentVisual
		{
			get
			{
				return ContentVisual;
			}
			set
			{
				ContentVisual = value;
			}
		}

		public RawImage ContentVisual
		{
			get
			{
				return _ContentVisual;
			}
			set
			{
				_ContentVisual = value;
			}
		}

		[Obsolete("Use ElasticMovement instead", true)]
		public bool elasticMovement
		{
			get
			{
				return ElasticMovement;
			}
			set
			{
				ElasticMovement = value;
			}
		}

		public bool ElasticMovement
		{
			get
			{
				return _ElasticMovement;
			}
			set
			{
				_ElasticMovement = value;
			}
		}

		[Obsolete("Use PullElasticity instead", true)]
		public float pullElasticity
		{
			get
			{
				return PullElasticity;
			}
			set
			{
				PullElasticity = value;
			}
		}

		public float PullElasticity
		{
			get
			{
				return _PullElasticity;
			}
			set
			{
				_PullElasticity = value;
			}
		}

		[Obsolete("Use ReleaseTime instead", true)]
		public float releaseTime
		{
			get
			{
				return ReleaseTime;
			}
			set
			{
				ReleaseTime = value;
			}
		}

		public float ReleaseTime
		{
			get
			{
				return _ReleaseTime;
			}
			set
			{
				_ReleaseTime = value;
			}
		}

		[Obsolete("Use Inertia instead", true)]
		public bool inertia
		{
			get
			{
				return Inertia;
			}
			set
			{
				Inertia = value;
			}
		}

		public bool Inertia
		{
			get
			{
				return _Inertia;
			}
			set
			{
				_Inertia = value;
			}
		}

		[Obsolete("Use InertiaDecelerationRate instead", true)]
		public float inertiaDecelerationRate
		{
			get
			{
				return InertiaDecelerationRate;
			}
			set
			{
				InertiaDecelerationRate = value;
			}
		}

		public float InertiaDecelerationRate
		{
			get
			{
				return _InertiaDecelerationRate;
			}
			set
			{
				_InertiaDecelerationRate = value;
			}
		}

		public bool CutMovementOnPointerDown
		{
			get
			{
				return _CutMovementOnPointerDown;
			}
			set
			{
				_CutMovementOnPointerDown = value;
			}
		}

		[Obsolete("Use MaxSpeed instead", true)]
		public float maxSpeed
		{
			get
			{
				return MaxSpeed;
			}
			set
			{
				MaxSpeed = value;
			}
		}

		public float MaxSpeed
		{
			get
			{
				return _MaxSpeed;
			}
			set
			{
				_MaxSpeed = value;
			}
		}

		public bool TransientSpeedBetweenDrags
		{
			get
			{
				return _TransientSpeedBetweenDrags;
			}
			protected set
			{
				_TransientSpeedBetweenDrags = value;
			}
		}

		[Obsolete("Use LoopItems instead", true)]
		public bool loopItems
		{
			get
			{
				return LoopItems;
			}
			set
			{
				LoopItems = value;
			}
		}

		public bool LoopItems
		{
			get
			{
				return _LoopItems;
			}
			set
			{
				_LoopItems = value;
			}
		}

		public float ContentVisualParallaxEffect
		{
			get
			{
				return _ContentVisualParallaxEffect;
			}
			set
			{
				_ContentVisualParallaxEffect = value;
			}
		}

		public GalleryEffectParams Gallery
		{
			get
			{
				return _Gallery;
			}
			set
			{
				_Gallery = value;
			}
		}

		[Obsolete("Use GalleryEffectAmount instead", true)]
		public float galleryEffectAmount
		{
			get
			{
				return Gallery.OverallAmount;
			}
			set
			{
				Gallery.OverallAmount = value;
			}
		}

		[Obsolete("Use Gallery.OverallAmount instead")]
		public float GalleryEffectAmount
		{
			get
			{
				return Gallery.OverallAmount;
			}
			set
			{
				Gallery.OverallAmount = value;
			}
		}

		[Obsolete("Use GalleryEffectViewportPivot instead", true)]
		public float galleryEffectViewportPivot
		{
			get
			{
				return Gallery.Scale.ViewportPivot;
			}
			set
			{
				Gallery.Scale.ViewportPivot = value;
			}
		}

		[Obsolete("Use Gallery.Scale.ViewportPivot instead")]
		public float GalleryEffectViewportPivot
		{
			get
			{
				return Gallery.Scale.ViewportPivot;
			}
			set
			{
				Gallery.Scale.ViewportPivot = value;
			}
		}

		public bool HasContentVisual => _HasContentVisual;

		public void InitIfNeeded()
		{
			_HasContentVisual = ContentVisual != null;
			float max;
			string text;
			if (LoopItems)
			{
				max = 10000f;
				text = "MAX_SPEED_IF_LOOPING";
			}
			else
			{
				max = 1000000f;
				text = "MAX_SPEED";
			}
			float num = Mathf.Clamp(MaxSpeed, 0f, max);
			if (Math.Abs(num - MaxSpeed) > 1f)
			{
				Debug.Log("OSA: maxSpeed(" + MaxSpeed.ToString("#########.00") + ") value is negative or exceeded " + text + "(" + max.ToString("#########.00") + "). Clamped it to " + num.ToString("#########.00"));
				MaxSpeed = num;
			}
			if (ElasticMovement && LoopItems)
			{
				ElasticMovement = false;
				Debug.Log("OSA: 'elasticMovement' was set to false, because 'loopItems' is true. Elasticity only makes sense when there is an end");
			}
			if (HasContentVisual)
			{
				ContentVisual.rectTransform.MatchParentSize(preservePivot: true);
			}
			InitGalleryEffectMigrations();
		}

		private void InitGalleryEffectMigrations()
		{
			float num = 0f;
			if (_GalleryEffectAmount != num)
			{
				string text = "OSA: Please go to BaseParams.cs, comment the [HideInInspector] attribute on _GalleryEffectAmount, then set this property to " + num + " (the default) in inspector, as this property will be removed in next versions. Use Gallery.OverallAmount instead to set the gallery effect amount. It's available through inspector. Will use _GalleryEffectAmount as the active one.";
				if (Gallery.OverallAmount != num)
				{
					text = text + ". Additional migration warning: Both _GalleryEffectAmount and Gallery.OverallAmount are non-default (non " + num + ").";
				}
				Gallery.OverallAmount = _GalleryEffectAmount;
				Debug.Log(text);
			}
			num = 0.5f;
			if (_GalleryEffectViewportPivot != num)
			{
				string text2 = "OSA: Please go to BaseParams.cs, comment the [HideInInspector] attribute on _GalleryEffectViewportPivot, then set this property to " + num + " (the default) in inspector, as this property will be removed in next versions. Use Gallery.Scale.ViewportPivot instead to set the gallery effect pivot. It's available through inspector. Preserving the value of _GalleryEffectViewportPivot as the active one.";
				if (Gallery.Scale.ViewportPivot != num)
				{
					text2 = text2 + ". Additional migration warning: Both _GalleryEffectViewportPivot and Gallery.Scale.ViewportPivot are non-default (non " + num + ").";
				}
				Gallery.Scale.ViewportPivot = _GalleryEffectViewportPivot;
				Debug.Log(text2);
			}
		}
	}

	[Serializable]
	public class NavigationParams
	{
		[Tooltip("Uses EventSystem.current (by default) to scroll to the currently selected item, if it's a ViewsHolder. Disabled by default for backward-compatibility.")]
		[SerializeField]
		private bool _Enabled;

		[Tooltip("Maximum depth up to which to search for a ViewsHolder in the parents of the currently selected GameObject (By default, EventSystem.current.currentSelectedGameObject). \nA value of 0 means the selected GameObject itself should be the same as ViewsHolder.root. \nIf you have a Button that's selectable and it's a direct child of the ViewsHolder.root, the depth is 1.  \nDon't use a high value unnecessarily, as it affects performance. Default is 2.")]
		[SerializeField]
		private int _MaxSearchDepthForViewsHolder = 2;

		[SerializeField]
		[Tooltip("Duration of scrolling to outside items when they're selected. Use 0 for no animation (immediate jump).\nClamped to (0, 1) and then again based on the input module's 'max actions per second'. Default is 0.1")]
		private float _ScrollDuration = 0.1f;

		[SerializeField]
		[Tooltip("If on, will center the selected item in the Viewport. Default is false")]
		private bool _Centered;

		[SerializeField]
		[Tooltip("Increase this to add more space between the focused (selected) item and the edge towards which you navigate. This is useful for scenarios like when you have some items that aren't selectable, but still want to see the ones after them (and thus, select them).\nHas no effect if Centered=true")]
		private float _AdditionalSpacingTowardsEdge;

		public bool Enabled
		{
			get
			{
				return _Enabled;
			}
			set
			{
				_Enabled = value;
			}
		}

		public int MaxSearchDepthForViewsHolder
		{
			get
			{
				return _MaxSearchDepthForViewsHolder;
			}
			set
			{
				_MaxSearchDepthForViewsHolder = value;
			}
		}

		public float ScrollDuration
		{
			get
			{
				return _ScrollDuration;
			}
			set
			{
				_ScrollDuration = value;
			}
		}

		public bool Centered
		{
			get
			{
				return _Centered;
			}
			set
			{
				_Centered = value;
			}
		}

		public float AdditionalSpacingTowardsEdge
		{
			get
			{
				return _AdditionalSpacingTowardsEdge;
			}
			set
			{
				_AdditionalSpacingTowardsEdge = value;
			}
		}

		public void InitIfNeeded()
		{
		}
	}

	[Serializable]
	public class Optimization
	{
		[SerializeField]
		[FormerlySerializedAs("recycleBinCapacity")]
		[Tooltip("How many objects besides the visible ones to keep in memory at max. \nBy default, no more than the heuristically found \"ideal\" number of items will be held in memory.\nSet to a positive integer to limit it. In this case, you'll either use more RAM than needed or more CPU than needed. One advantage is that you can get a predictable usage of the resources (for example, by specifying a constant bin size, no item will be destroyed if the actual visible items count won't exceed that).\nNote that this doesn't include the 'buffered' items, which by design can't be directly destroyed")]
		private int _RecycleBinCapacity = -1;

		[SerializeField]
		[FormerlySerializedAs("scaleToZeroInsteadOfDisable")]
		private bool _ScaleToZeroInsteadOfDisable;

		[SerializeField]
		[FormerlySerializedAs("forceLayoutRebuildOnBeginSmoothScroll")]
		private bool _ForceLayoutRebuildOnBeginSmoothScroll = true;

		[SerializeField]
		[FormerlySerializedAs("forceLayoutRebuildOnDrag")]
		private bool _ForceLayoutRebuildOnDrag;

		[Tooltip("Whether to sort the actual GameObjects representing the items under the Content. Only use if needed, as it slightly affects performance. Off by default")]
		[SerializeField]
		private bool _KeepItemsSortedInHierarchy;

		[SerializeField]
		[Tooltip("When the list becomes empty, should the currently cached item views be kept (True) or destroyed in order to start with a fresh state (False)? False by default")]
		private bool _KeepItemsPoolOnEmptyList;

		[Tooltip("When the ScrollView is rebuilt (as when its size changes), should the currently cached item views be kept (True) or destroyed in order to start with a fresh state (False)? False by default")]
		[SerializeField]
		private bool _KeepItemsPoolOnLayoutRebuild;

		[Tooltip("When the ScrollView is rebuilt (as when its size changes), should the currently cached item sizes views be kept (True)? False by default")]
		[SerializeField]
		private bool _KeepItemsSizesOnLayoutRebuild;

		[Tooltip("When the ScrollView changes its size (as when the orientation changes), should we try (best-effort) to preserve the exact position of all visible items and OSA's velocity?\nOf course you usually want this, and at least the position of all items is already preserved by default, but in some cases, such as when you're changing items' sizes on the fly or applying CSF patterns, the scroll position jumps a few times to accommodate those dynamic changes\nThis property handles that. And it's off by default for backwards-compatibility, but also because of a small performance hit")]
		[SerializeField]
		private bool _ResponsiveOnScrollViewSizeChange;

		[Obsolete("Use RecycleBinCapacity instead", true)]
		public int recycleBinCapacity
		{
			get
			{
				return RecycleBinCapacity;
			}
			set
			{
				RecycleBinCapacity = value;
			}
		}

		public int RecycleBinCapacity
		{
			get
			{
				return _RecycleBinCapacity;
			}
			set
			{
				_RecycleBinCapacity = value;
			}
		}

		[Obsolete("Use ScaleToZeroInsteadOfDisable instead", true)]
		public bool scaleToZeroInsteadOfDisable
		{
			get
			{
				return ScaleToZeroInsteadOfDisable;
			}
			set
			{
				ScaleToZeroInsteadOfDisable = value;
			}
		}

		public bool ScaleToZeroInsteadOfDisable
		{
			get
			{
				return _ScaleToZeroInsteadOfDisable;
			}
			set
			{
				_ScaleToZeroInsteadOfDisable = value;
			}
		}

		[Obsolete("Use ForceLayoutRebuildOnBeginSmoothScroll instead", true)]
		public bool forceLayoutRebuildOnBeginSmoothScroll
		{
			get
			{
				return ForceLayoutRebuildOnBeginSmoothScroll;
			}
			set
			{
				ForceLayoutRebuildOnBeginSmoothScroll = value;
			}
		}

		public bool ForceLayoutRebuildOnBeginSmoothScroll
		{
			get
			{
				return _ForceLayoutRebuildOnBeginSmoothScroll;
			}
			set
			{
				_ForceLayoutRebuildOnBeginSmoothScroll = value;
			}
		}

		[Obsolete("Use ForceLayoutRebuildOnDrag instead", true)]
		public bool forceLayoutRebuildOnDrag
		{
			get
			{
				return ForceLayoutRebuildOnDrag;
			}
			set
			{
				ForceLayoutRebuildOnDrag = value;
			}
		}

		public bool ForceLayoutRebuildOnDrag
		{
			get
			{
				return _ForceLayoutRebuildOnDrag;
			}
			set
			{
				_ForceLayoutRebuildOnDrag = value;
			}
		}

		public bool KeepItemsSortedInHierarchy
		{
			get
			{
				return _KeepItemsSortedInHierarchy;
			}
			set
			{
				_KeepItemsSortedInHierarchy = value;
			}
		}

		public bool KeepItemsPoolOnEmptyList
		{
			get
			{
				return _KeepItemsPoolOnEmptyList;
			}
			set
			{
				_KeepItemsPoolOnEmptyList = value;
			}
		}

		public bool KeepItemsPoolOnLayoutRebuild
		{
			get
			{
				return _KeepItemsPoolOnLayoutRebuild;
			}
			set
			{
				_KeepItemsPoolOnLayoutRebuild = value;
			}
		}

		public bool KeepItemsSizesOnLayoutRebuild
		{
			get
			{
				return _KeepItemsSizesOnLayoutRebuild;
			}
			set
			{
				_KeepItemsSizesOnLayoutRebuild = value;
			}
		}

		public bool ResponsiveOnScrollViewSizeChange
		{
			get
			{
				return _ResponsiveOnScrollViewSizeChange;
			}
			set
			{
				_ResponsiveOnScrollViewSizeChange = value;
			}
		}
	}

	[SerializeField]
	private RectTransform _Content;

	[Tooltip("If null, the scrollRect is considered to be the viewport")]
	[SerializeField]
	[FormerlySerializedAs("viewport")]
	private RectTransform _Viewport;

	[SerializeField]
	private OrientationEnum _Orientation;

	[SerializeField]
	private Scrollbar _Scrollbar;

	[Tooltip("The sensivity to the Mouse's scrolling wheel or similar input methods. Not related to dragging or scrolling via scrollbar")]
	[SerializeField]
	private float _ScrollSensivity = 100f;

	[Tooltip("The sensivity to the Mouse's horizontal scrolling wheel (where supported) or similar input methods that send scroll signals on the horizontal axis. Not related to dragging or scrolling via scrollbar. \nIt's set to a positive value by default to comply with Unity's ScrollRect (which for some reason inverts the left and right directions). \nIf you'll nest OSA in a regular horizontal ScrollRect, set the ScrollRect's sensivity to a positive value and OSA's ScrollSensivityOnXAxis to a negative value to get an intuitive scroll")]
	[SerializeField]
	private float _ScrollSensivityOnXAxis = 100f;

	[Tooltip("Padding for the 4 edges of the content panel.\nTip: if using a fixed, constant ItemTransversalSize, also set the paddings in the transversal direction to -1 (left/right for vertical ScrollView and vice-versa). This aligns the item in the center, transversally")]
	[FormerlySerializedAs("contentPadding")]
	[SerializeField]
	private RectOffset _ContentPadding = new RectOffset();

	[SerializeField]
	[FormerlySerializedAs("contentGravity")]
	private ContentGravity _Gravity = ContentGravity.START;

	[Tooltip("The space between items")]
	[FormerlySerializedAs("contentSpacing")]
	[SerializeField]
	private float _ContentSpacing;

	[Tooltip("The size of all items for which the size is not specified in CollectItemSizes()")]
	[SerializeField]
	private float _DefaultItemSize = 60f;

	[Tooltip("You'll probably need this if the scroll view is a child of another scroll view. If enabled, the first parent that implements all of IInitializePotentialDragHandler, IBeginDragHandler, IDragHandler and IEndDragHandler, as well as the first IScrollHandler found in parents (but it should be on the same game object as other handlers, IF they're found),  will receive these events when they occur on this scroll view. This works both with Unity's ScrollRect and OSA")]
	[SerializeField]
	private bool _ForwardDragToParents;

	[Tooltip("It forwards the drag/scroll in the same direction to the parent when the current scrolled position is at boundary, thus allowing scrolling through nested Scroll Views that have the same scroll direction. \nForwardDragToParents also needs to be enabled for this to work.")]
	[SerializeField]
	private bool _ForwardDragSameDirectionAtBoundary;

	[Tooltip("Allows you to click and drag the content directly (enabled by default). The property ForwardDragToParents is not affected by this")]
	[SerializeField]
	private bool _DragEnabled = true;

	[SerializeField]
	[Tooltip("Allows you to scroll by mouse wheel or other similar input devices (enabled by default). The property ForwardDragToParents is not affected by this")]
	private bool _ScrollEnabled = true;

	[Tooltip("If enabled, will use Time.unscaledTime instead of Time.time, which means the animations, inertia etc. won't be affected by the Time.timeScale")]
	[SerializeField]
	private bool _UseUnscaledTime = true;

	[Tooltip("The item size in the direction perpendicular to scrolling direction. Width for vertical ScrollViews, and vice-versa.\n-1 = items won't have their widths (heights for horizontal ScrollViews) changed at all - you'll be responsible for them\n0 = fill to available space, taking ContentPadding into account\n>0 = fixed size; in this case, it's better to also set transversal padding to -1 so the item will be centered\n")]
	[SerializeField]
	private float _ItemTransversalSize;

	[FormerlySerializedAs("effects")]
	[SerializeField]
	private Effects _Effects = new Effects();

	[SerializeField]
	private NavigationParams _Navigation = new NavigationParams();

	[SerializeField]
	private AnimationParams _Animation = new AnimationParams();

	[FormerlySerializedAs("optimization")]
	[SerializeField]
	private Optimization _Optimization = new Optimization();

	private RectTransform _ScrollViewRT;

	private Snapper8 _Snapper;

	public RectTransform Content
	{
		get
		{
			return _Content;
		}
		set
		{
			_Content = value;
		}
	}

	public RectTransform Viewport
	{
		get
		{
			return _Viewport;
		}
		set
		{
			_Viewport = value;
		}
	}

	public OrientationEnum Orientation
	{
		get
		{
			return _Orientation;
		}
		set
		{
			_Orientation = value;
		}
	}

	public Scrollbar Scrollbar
	{
		get
		{
			return _Scrollbar;
		}
		set
		{
			_Scrollbar = value;
		}
	}

	public float ScrollSensivity
	{
		get
		{
			return _ScrollSensivity;
		}
		set
		{
			_ScrollSensivity = value;
		}
	}

	public float ScrollSensivityOnXAxis
	{
		get
		{
			return _ScrollSensivityOnXAxis;
		}
		set
		{
			_ScrollSensivityOnXAxis = value;
		}
	}

	public RectOffset ContentPadding
	{
		get
		{
			return _ContentPadding;
		}
		set
		{
			_ContentPadding = value;
		}
	}

	public ContentGravity Gravity
	{
		get
		{
			return _Gravity;
		}
		set
		{
			_Gravity = value;
		}
	}

	public float ContentSpacing
	{
		get
		{
			return _ContentSpacing;
		}
		set
		{
			_ContentSpacing = value;
		}
	}

	public float DefaultItemSize
	{
		get
		{
			return _DefaultItemSize;
		}
		protected set
		{
			_DefaultItemSize = value;
		}
	}

	public bool ForwardDragToParents
	{
		get
		{
			return _ForwardDragToParents;
		}
		protected set
		{
			_ForwardDragToParents = value;
		}
	}

	public bool ForwardDragSameDirectionAtBoundary
	{
		get
		{
			return _ForwardDragSameDirectionAtBoundary;
		}
		protected set
		{
			_ForwardDragSameDirectionAtBoundary = value;
		}
	}

	public bool DragEnabled
	{
		get
		{
			return _DragEnabled;
		}
		set
		{
			_DragEnabled = value;
		}
	}

	public bool ScrollEnabled
	{
		get
		{
			return _ScrollEnabled;
		}
		set
		{
			_ScrollEnabled = value;
		}
	}

	public bool UseUnscaledTime
	{
		get
		{
			return _UseUnscaledTime;
		}
		set
		{
			_UseUnscaledTime = value;
		}
	}

	public float ItemTransversalSize
	{
		get
		{
			return _ItemTransversalSize;
		}
		set
		{
			_ItemTransversalSize = value;
		}
	}

	public Effects effects => _Effects;

	public NavigationParams Navigation => _Navigation;

	public AnimationParams Animation => _Animation;

	public Optimization optimization => _Optimization;

	public bool IsHorizontal => _Orientation == OrientationEnum.HORIZONTAL;

	public RectTransform ScrollViewRT => _ScrollViewRT;

	public Snapper8 Snapper => _Snapper;

	public void PrepareForInit(bool firstTime)
	{
		if (!Content)
		{
			throw new OSAException("Content cannot be null");
		}
		Content.MatchParentSize(preservePivot: true);
		if (firstTime)
		{
			Canvas.ForceUpdateCanvases();
		}
	}

	public virtual void InitIfNeeded(IOSA iAdapter)
	{
		_ScrollViewRT = iAdapter.AsMonoBehaviour.transform as RectTransform;
		LayoutRebuilder.ForceRebuildLayoutImmediate(ScrollViewRT);
		AssertValidWidthHeight(ScrollViewRT);
		ScrollRect component = ScrollViewRT.GetComponent<ScrollRect>();
		if ((bool)component && component.enabled)
		{
			throw new OSAException("The ScrollRect is not needed anymore starting with v4.0. Remove or disable it!");
		}
		if (!Content)
		{
			throw new OSAException("Content not set!");
		}
		if (!Viewport)
		{
			Viewport = ScrollViewRT;
			if (Content.parent != ScrollViewRT)
			{
				throw new OSAException("Content's parent should be the ScrollView itself if there's no viewport specified!");
			}
		}
		if (!_Snapper)
		{
			_Snapper = ScrollViewRT.GetComponent<Snapper8>();
		}
		if (ForwardDragSameDirectionAtBoundary && !ForwardDragToParents)
		{
			Debug.Log("OSA: ForwardDragSameDirectionAtBoundary is true, but ForwardDragToParents is false. This will have no effect");
		}
		if (ContentPadding.left == -1 != (ContentPadding.right == -1))
		{
			Debug.Log("OSA: ContentPadding.right and .left should either be both zero or positive or both -1. Setting both to 0...");
			RectOffset contentPadding = ContentPadding;
			int left = (ContentPadding.right = 0);
			contentPadding.left = left;
		}
		if (ContentPadding.top == -1 != (ContentPadding.bottom == -1))
		{
			Debug.Log("OSA: ContentPadding.top and .bottom should either be both zero or positive or both -1. Setting both to 0...");
			RectOffset contentPadding2 = ContentPadding;
			int left = (ContentPadding.bottom = 0);
			contentPadding2.top = left;
		}
		effects.InitIfNeeded();
		if (effects.LoopItems)
		{
			bool flag = false;
			int num3 = (int)ContentSpacing;
			if (IsHorizontal)
			{
				if (ContentPadding.left != num3)
				{
					flag = true;
					ContentPadding.left = num3;
				}
				if (ContentPadding.right != num3)
				{
					flag = true;
					ContentPadding.right = num3;
				}
			}
			else
			{
				if (ContentPadding.top != num3)
				{
					flag = true;
					ContentPadding.top = num3;
				}
				if (ContentPadding.bottom != num3)
				{
					flag = true;
					ContentPadding.bottom = num3;
				}
			}
			if (flag)
			{
				Debug.Log("OSA: setting conteng padding to be the same as content spacing (" + ContentSpacing.ToString("#############.##") + "), because looping is enabled");
			}
		}
		Navigation.InitIfNeeded();
		UpdateContentPivotFromGravityType();
	}

	public void UpdateContentPivotFromGravityType()
	{
		if (Gravity != ContentGravity.FROM_PIVOT)
		{
			int num = ((!IsHorizontal) ? 1 : 0);
			Vector2 pivot = Content.pivot;
			pivot[1 - num] = 0.5f;
			int gravity = (int)Gravity;
			float value = ((gravity >= 3) ? 0f : (1f / (float)gravity));
			pivot[num] = value;
			if (num == 0)
			{
				pivot[num] = 1f - pivot[num];
			}
			Content.pivot = pivot;
		}
	}

	public void ApplyScrollSensitivityTo(ref Vector2 vec)
	{
		vec.x *= 1f * ScrollSensivityOnXAxis;
		vec.y *= 1f * ScrollSensivity;
	}

	public void AssertValidWidthHeight(RectTransform rt)
	{
		Vector2 size = rt.rect.size;
		string text = null;
		float num;
		if ((num = size.x) < 1f)
		{
			text = "width";
		}
		else if ((num = size.y) < 1f)
		{
			text = "height";
		}
		if (text != null)
		{
			throw new OSAException("OSA: '" + rt.name + "' reports a zero or negative " + text + "(" + num + "). \nThis can happen if you don't have a Canvas component in the OSA's parents or if you accidentally set an invalid size in editor. \nIf '" + rt.name + "' is instantiated at runtime, make sure you use the version of Object.Instantiate(..) that also takes the parent so it can be directly instantiated in it. The parent should be a Canvas or a descendant of a Canvas");
		}
	}
}
