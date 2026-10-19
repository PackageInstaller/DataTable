using System;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.CustomAdapters.GridView;

[Serializable]
public class GridParams : BaseParams
{
	[Serializable]
	public class GridConfig
	{
		[Tooltip("The max. number of cells in a row group (for vertical ScrollView) or column group (for horizontal ScrollView).\nSet to -1 to fill with cells when there's space - note that it only works when cell's flexibleWidth is not used (flexibleHeight for horizontal scroll views).\n\nSet further to negative values to force more items than the space allows. For example, -2 sets 2x more items than the space allows. This may be useful for advanced scenarios where you use a custom LayoutGroup for the cell group")]
		[FormerlySerializedAs("numCellsPerGroup")]
		[SerializeField]
		private int _MaxCellsPerGroup = -1;

		[FormerlySerializedAs("_UseDefaulfItemSizeForCellGroupSize")]
		[Tooltip("If true, the DefaultItemSize property will be used for the height of a row, if using a vertical scroll view (the width of a column, otherwise). Leave to false to automatically infer based on the cellPrefab's LayoutElement's values")]
		[SerializeField]
		private bool _UseDefaultItemSizeForCellGroupSize;

		[FormerlySerializedAs("cellPrefab")]
		[SerializeField]
		private RectTransform _CellPrefab;

		[Tooltip("The alignment of cells inside their parent LayoutGroup (Vertical or Horizontal, depending on ScrollView's orientation)")]
		[SerializeField]
		[FormerlySerializedAs("alignmentOfCellsInGroup")]
		private TextAnchor _AlignmentOfCellsInGroup;

		[Tooltip("The spacing between the cells of a group. Leave it to -1 to use the same value as contentSpacing (i.e. the spacing between the groups), so vertical and horizontal spacing will be the same")]
		[FormerlySerializedAs("spacingInGroup")]
		[SerializeField]
		private float _SpacingInGroup = -1f;

		[FormerlySerializedAs("groupPadding")]
		[SerializeField]
		private RectOffset _GroupPadding = new RectOffset();

		[FormerlySerializedAs("cellWidthForceExpandInGroup")]
		[SerializeField]
		private bool _CellWidthForceExpandInGroup;

		[FormerlySerializedAs("cellHeightForceExpandInGroup")]
		[SerializeField]
		private bool _CellHeightForceExpandInGroup;

		[SerializeField]
		[Tooltip("By default, cells' LayoutElement has the same values as the prefab's LayoutElement, but with this property set to true,cells' LayoutElement will have its values automatically adjusted so that the cells will have the same aspect ratio as the prefab's RectTransform. \nThe affected values are preferredWidth and flexibleHeight (or preferredHeight and flexibleWidth=true for horizontal ScrollViews), and others are set to default.\nIt only makes sense when using a fixed MaxCellsPerGroup, because otherwise the cells' LayoutElement will have the same values as the prefab's LayoutElement, thus having a constant size, and so, an already-known aspect ratio")]
		private bool _PreserveCellAspectRatio;

		public int MaxCellsPerGroup
		{
			get
			{
				return _MaxCellsPerGroup;
			}
			set
			{
				_MaxCellsPerGroup = value;
			}
		}

		public bool UseDefaultItemSizeForCellGroupSize
		{
			get
			{
				return _UseDefaultItemSizeForCellGroupSize;
			}
			protected set
			{
				_UseDefaultItemSizeForCellGroupSize = value;
			}
		}

		[Obsolete("Use CellPrefab instead", true)]
		public RectTransform cellPrefab
		{
			get
			{
				return CellPrefab;
			}
			set
			{
				CellPrefab = value;
			}
		}

		public RectTransform CellPrefab
		{
			get
			{
				return _CellPrefab;
			}
			set
			{
				_CellPrefab = value;
			}
		}

		[Obsolete("Use AlignmentOfCellsInGroup instead", true)]
		public TextAnchor alignmentOfCellsInGroup
		{
			get
			{
				return AlignmentOfCellsInGroup;
			}
			set
			{
				AlignmentOfCellsInGroup = value;
			}
		}

		public TextAnchor AlignmentOfCellsInGroup
		{
			get
			{
				return _AlignmentOfCellsInGroup;
			}
			set
			{
				_AlignmentOfCellsInGroup = value;
			}
		}

		[Obsolete("Use SpacingInGroup instead", true)]
		public float spacingInGroup
		{
			get
			{
				return SpacingInGroup;
			}
			set
			{
				SpacingInGroup = value;
			}
		}

		public float SpacingInGroup
		{
			get
			{
				return _SpacingInGroup;
			}
			set
			{
				_SpacingInGroup = value;
			}
		}

		[Obsolete("Use GroupPadding instead", true)]
		public RectOffset groupPadding
		{
			get
			{
				return GroupPadding;
			}
			set
			{
				GroupPadding = value;
			}
		}

		public RectOffset GroupPadding
		{
			get
			{
				return _GroupPadding;
			}
			set
			{
				_GroupPadding = value;
			}
		}

		[Obsolete("Use CellWidthForceExpandInGroup instead", true)]
		public bool cellWidthForceExpandInGroup
		{
			get
			{
				return CellWidthForceExpandInGroup;
			}
			set
			{
				CellWidthForceExpandInGroup = value;
			}
		}

		public bool CellWidthForceExpandInGroup
		{
			get
			{
				return _CellWidthForceExpandInGroup;
			}
			set
			{
				_CellWidthForceExpandInGroup = value;
			}
		}

		[Obsolete("Use CellHeightForceExpandInGroup instead", true)]
		public bool cellHeightForceExpandInGroup
		{
			get
			{
				return CellHeightForceExpandInGroup;
			}
			set
			{
				CellHeightForceExpandInGroup = value;
			}
		}

		public bool CellHeightForceExpandInGroup
		{
			get
			{
				return _CellHeightForceExpandInGroup;
			}
			set
			{
				_CellHeightForceExpandInGroup = value;
			}
		}

		public bool PreserveCellAspectRatio
		{
			get
			{
				return _PreserveCellAspectRatio;
			}
			set
			{
				_PreserveCellAspectRatio = value;
			}
		}
	}

	[SerializeField]
	[FormerlySerializedAs("grid")]
	private GridConfig _Grid = new GridConfig();

	private LayoutGroup _TheOnlyGroupPrefab;

	private HorizontalOrVerticalLayoutGroup _TheOnlyGroupPrefabAsHorizontalOrVertical;

	private int _CurrentUsedNumCellsPerGroup;

	private LayoutElement _CellPrefabLayoutElement;

	private float _CellTransversalSizeIfConstant;

	[Obsolete("Use Grid instead", true)]
	public GridConfig grid
	{
		get
		{
			return Grid;
		}
		set
		{
			Grid = value;
		}
	}

	public GridConfig Grid
	{
		get
		{
			return _Grid;
		}
		set
		{
			_Grid = value;
		}
	}

	public int CurrentUsedNumCellsPerGroup => _CurrentUsedNumCellsPerGroup;

	public LayoutElement CellPrefabLayoutElement => _CellPrefabLayoutElement;

	public override void InitIfNeeded(IOSA iAdapter)
	{
		base.InitIfNeeded(iAdapter);
		if (!Grid.CellPrefab)
		{
			throw new OSAException(typeof(GridParams).Name + ": the prefab was not set. Please set it through inspector or in code");
		}
		_CellPrefabLayoutElement = Grid.CellPrefab.GetComponent<LayoutElement>();
		if (!_CellPrefabLayoutElement)
		{
			throw new OSAException(typeof(GridParams).Name + ": no LayoutElement found on the cellPrefab: you should add one to configure how the cell's parent LayoutGroup should position/size it");
		}
		AssertValidWidthHeight(Grid.CellPrefab);
		if (Grid.SpacingInGroup == -1f)
		{
			Grid.SpacingInGroup = ContentSpacing;
		}
		if (Grid.MaxCellsPerGroup == 0)
		{
			Grid.MaxCellsPerGroup = -1;
		}
		_CellTransversalSizeIfConstant = -1f;
		if (Grid.PreserveCellAspectRatio)
		{
			if (Grid.UseDefaultItemSizeForCellGroupSize)
			{
				throw new OSAException(typeof(GridParams).Name + ".PreserveCellAspectRatio only works if UseDefaultItemSizeForCellGroupSize is false");
			}
			if (Grid.MaxCellsPerGroup <= 0)
			{
				throw new OSAException(typeof(GridParams).Name + ".PreserveCellAspectRatio only works if MaxCellsPerGroup is set to a strictly positive value (otherwise the aspect ratio is already constant)");
			}
			if (AnyWidthPropertiesEnabledFor(_CellPrefabLayoutElement) || AnyHeightPropertiesEnabledFor(_CellPrefabLayoutElement))
			{
				Debug.Log("OSA: " + typeof(GridParams).Name + ".cellPrefab.LayoutElement: found non-default values. They'll be ignored/overridden because Grid.PreserveCellAspectRatio is true. To remove this warning, disable all values in the prefab's LayoutElement");
			}
			if (Grid.CellHeightForceExpandInGroup || Grid.CellWidthForceExpandInGroup)
			{
				Debug.Log("OSA: " + typeof(GridParams).Name + ": CellHeightForceExpandInGroup and CellWidthForceExpandInGroup aren't needed when PreserveCellAspectRatio is true. To remove this warning, set them to false");
			}
			_CurrentUsedNumCellsPerGroup = CalculateCurrentNumCellsPerGroup();
			Vector2 size = Grid.CellPrefab.rect.size;
			float num = size.x / size.y;
			int num2 = _CurrentUsedNumCellsPerGroup - 1;
			float num3 = Grid.SpacingInGroup * (float)num2;
			float num4;
			float num5;
			float num6;
			if (IsHorizontal)
			{
				num4 = Viewport.rect.height - (float)ContentPadding.vertical - num3 - (float)Grid.GroupPadding.vertical;
				num5 = 1f / num;
				num6 = Grid.GroupPadding.horizontal;
			}
			else
			{
				num4 = Viewport.rect.width - (float)ContentPadding.horizontal - num3 - (float)Grid.GroupPadding.horizontal;
				num5 = num;
				num6 = Grid.GroupPadding.vertical;
			}
			_CellTransversalSizeIfConstant = num4 / (float)_CurrentUsedNumCellsPerGroup;
			float num7 = _CellTransversalSizeIfConstant / num5;
			DefaultItemSize = num7 + num6;
		}
		else
		{
			if (!Grid.UseDefaultItemSizeForCellGroupSize)
			{
				if (IsHorizontal)
				{
					DefaultItemSize = _CellPrefabLayoutElement.preferredWidth;
					if (DefaultItemSize < 0f)
					{
						DefaultItemSize = _CellPrefabLayoutElement.minWidth;
						if (DefaultItemSize < 0f)
						{
							if (_CellPrefabLayoutElement.flexibleWidth == -1f)
							{
								throw new OSAException(typeof(GridParams).Name + ".cellPrefab.LayoutElement: Could not determine the cell group's width(UseDefaulfItemSizeForCellGroupSize=false). Please specify at least preferredWidth, minWidth or flexibleWidth(case in which the current width of the cell will be used as the group's width)");
							}
							DefaultItemSize = Grid.CellPrefab.rect.width;
						}
					}
					DefaultItemSize += Grid.GroupPadding.horizontal;
				}
				else
				{
					DefaultItemSize = _CellPrefabLayoutElement.preferredHeight;
					if (DefaultItemSize < 0f)
					{
						DefaultItemSize = _CellPrefabLayoutElement.minHeight;
						if (DefaultItemSize < 0f)
						{
							if (_CellPrefabLayoutElement.flexibleHeight == -1f)
							{
								throw new OSAException(typeof(GridParams).Name + ".cellPrefab.LayoutElement: Could not determine the cell group's height(UseDefaulfItemSizeForCellGroupSize=false). Please specify at least preferredHeight, minHeight or flexibleHeight(case in which the current height of the cell will be used as the group's height)");
							}
							DefaultItemSize = Grid.CellPrefab.rect.height;
						}
					}
					DefaultItemSize += Grid.GroupPadding.vertical;
				}
			}
			_CurrentUsedNumCellsPerGroup = CalculateCurrentNumCellsPerGroup();
		}
		CreateOrReinitCellGroupPrefab();
		if (Navigation.MaxSearchDepthForViewsHolder < 2)
		{
			Navigation.MaxSearchDepthForViewsHolder = 2;
		}
	}

	public virtual int CalculateCurrentNumCellsPerGroup()
	{
		if (Grid.MaxCellsPerGroup > 0)
		{
			if (!Grid.PreserveCellAspectRatio)
			{
				if (IsHorizontal)
				{
					if (!AnyHeightPropertiesEnabledFor(_CellPrefabLayoutElement) && !Grid.CellHeightForceExpandInGroup)
					{
						Debug.Log("OSA: " + typeof(GridParams).Name + ".cellPrefab.LayoutElement: Using a fixed number of rows (Grid.MaxCellsPerGroup is " + Grid.MaxCellsPerGroup + "), but none of the prefab's minHeight/preferredHeight/flexibleHeight is set, nor cellHeightForceExpandInGroup is true. The cells will have 0 height initially. This is rarely the intended behavior");
					}
				}
				else if (!AnyWidthPropertiesEnabledFor(_CellPrefabLayoutElement) && !Grid.CellWidthForceExpandInGroup)
				{
					Debug.Log("OSA: " + typeof(GridParams).Name + ".cellPrefab.LayoutElement: Using a fixed number of columns (Grid.MaxCellsPerGroup is " + Grid.MaxCellsPerGroup + "), but none of the prefab's minWidth/preferredWidth/flexibleWidth is set, nor cellWidthForceExpandInGroup is true. The cells will have 0 width initially. This is rarely the intended behavior");
				}
			}
			return Grid.MaxCellsPerGroup;
		}
		int num = -5;
		if (Grid.MaxCellsPerGroup < num)
		{
			Debug.Log("OSA: " + typeof(GridParams).Name + ".Grid.MaxCellsPerGroup: can't be less than " + num + ". Clamping it! Because you're multiplying the already 'recommended' number of cells, velues beyond that could lead to significant framedrops. If you really know you need this, increase the value in OSAConst.MAX_CELLS_PER_GROUP_FACTOR_WHEN_INFERRING");
			Grid.MaxCellsPerGroup = num;
		}
		Vector2 size = ScrollViewRT.rect.size;
		float num2;
		float num3;
		if (IsHorizontal)
		{
			num2 = _CellPrefabLayoutElement.preferredHeight;
			if (num2 <= 0f)
			{
				num2 = _CellPrefabLayoutElement.minHeight;
				if (num2 <= 0f)
				{
					throw new OSAException(typeof(GridParams).Name + ".cellPrefab.LayoutElement: Please specify at least preferredHeight or minHeight when using a variable number of cells per group (Grid.MaxCellsPerGroup is " + Grid.MaxCellsPerGroup + ")");
				}
			}
			num3 = size.y - (float)Grid.GroupPadding.vertical - (float)ContentPadding.vertical;
		}
		else
		{
			num2 = _CellPrefabLayoutElement.preferredWidth;
			if (num2 <= 0f)
			{
				num2 = _CellPrefabLayoutElement.minWidth;
				if (num2 <= 0f)
				{
					throw new OSAException(typeof(GridParams).Name + ".cellPrefab.LayoutElement: Please specify at least preferredWidth or minWidth when using a variable number of cells per group (Grid.MaxCellsPerGroup is " + Grid.MaxCellsPerGroup + ")");
				}
			}
			num3 = size.x - (float)Grid.GroupPadding.horizontal - (float)ContentPadding.horizontal;
		}
		int num4 = Mathf.FloorToInt((num3 + Grid.SpacingInGroup) / (num2 + Grid.SpacingInGroup));
		if (num4 < 1)
		{
			num4 = 1;
		}
		return num4 * -Grid.MaxCellsPerGroup;
	}

	public virtual LayoutGroup GetGroupPrefab(int forGroupAtThisIndex)
	{
		if (_TheOnlyGroupPrefab == null)
		{
			throw new OSAException("GridParams.InitIfNeeded() was not called by OSA. Did you forget to call base.Start() in <YourAdapter>.Start()?");
		}
		return _TheOnlyGroupPrefab;
	}

	public virtual int GetGroupIndex(int cellIndex)
	{
		return cellIndex / _CurrentUsedNumCellsPerGroup;
	}

	public virtual int GetNumberOfRequiredGroups(int numberOfCells)
	{
		if (numberOfCells != 0)
		{
			return GetGroupIndex(numberOfCells - 1) + 1;
		}
		return 0;
	}

	public float GetCellTransversalSizeIfKnown()
	{
		return _CellTransversalSizeIfConstant;
	}

	public bool ConfigureCellViewsHolderAspectRatio(CellViewsHolder cellVH)
	{
		bool result = false;
		if (Grid.PreserveCellAspectRatio)
		{
			LayoutElement rootLayoutElement = cellVH.rootLayoutElement;
			if (IsHorizontal)
			{
				rootLayoutElement.preferredWidth = -1f;
				rootLayoutElement.preferredHeight = _CellTransversalSizeIfConstant;
				rootLayoutElement.flexibleWidth = 1f;
				rootLayoutElement.flexibleHeight = -1f;
			}
			else
			{
				rootLayoutElement.flexibleHeight = -1f;
				rootLayoutElement.preferredWidth = _CellTransversalSizeIfConstant;
				rootLayoutElement.flexibleHeight = 1f;
				rootLayoutElement.flexibleWidth = -1f;
			}
			result = true;
		}
		return result;
	}

	protected void CreateOrReinitCellGroupPrefab()
	{
		if (!_TheOnlyGroupPrefab)
		{
			GameObject gameObject = CreateCellGroupPrefabGameObject();
			if (!(gameObject.transform is RectTransform))
			{
				Debug.LogException(new OSAException("Don't call OSA.Init() outside MonoBehaviour.Start()!"));
			}
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(ScrollViewRT, worldPositionStays: false);
			_TheOnlyGroupPrefab = AddLayoutGroupToCellGroupPrefab(gameObject);
			_TheOnlyGroupPrefabAsHorizontalOrVertical = _TheOnlyGroupPrefab as HorizontalOrVerticalLayoutGroup;
		}
		InitOrReinitCellGroupPrefabLayoutGroup(_TheOnlyGroupPrefab);
	}

	protected virtual GameObject CreateCellGroupPrefabGameObject()
	{
		return new GameObject(ScrollViewRT.name + "_CellGroupPrefab", typeof(RectTransform));
	}

	protected virtual LayoutGroup AddLayoutGroupToCellGroupPrefab(GameObject cellGroupGameObject)
	{
		if (IsHorizontal)
		{
			return cellGroupGameObject.AddComponent<VerticalLayoutGroup>();
		}
		return cellGroupGameObject.AddComponent<HorizontalLayoutGroup>();
	}

	protected virtual void InitOrReinitCellGroupPrefabLayoutGroup(LayoutGroup cellGroupGameObject)
	{
		if ((bool)_TheOnlyGroupPrefabAsHorizontalOrVertical)
		{
			_TheOnlyGroupPrefabAsHorizontalOrVertical.spacing = Grid.SpacingInGroup;
			_TheOnlyGroupPrefabAsHorizontalOrVertical.childForceExpandWidth = Grid.CellWidthForceExpandInGroup;
			_TheOnlyGroupPrefabAsHorizontalOrVertical.childForceExpandHeight = Grid.CellHeightForceExpandInGroup;
		}
		_TheOnlyGroupPrefab.childAlignment = Grid.AlignmentOfCellsInGroup;
		_TheOnlyGroupPrefab.padding = Grid.GroupPadding;
	}

	private bool AnyWidthPropertiesEnabledFor(LayoutElement el)
	{
		if (el.preferredHeight == -1f && el.minHeight == -1f)
		{
			return el.flexibleHeight != -1f;
		}
		return true;
	}

	private bool AnyHeightPropertiesEnabledFor(LayoutElement el)
	{
		if (el.preferredWidth == -1f && el.minWidth == -1f)
		{
			return el.flexibleWidth != -1f;
		}
		return true;
	}
}
