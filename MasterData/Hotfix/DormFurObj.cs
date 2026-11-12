using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using Pathfinding;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;

[DisallowMultipleComponent]
public class DormFurObj : DormEntity
{
	public enum DormFurObjState
	{
		None,
		Idle,
		Interactive,
		Decorate
	}

	[ReadOnly]
	public int FurId;

	public HotfixEnum.DormFurType Type;

	public HotfixEnum.DormFurRotate Rotate;

	public HotfixEnum.DormFurFixedType FixedType;

	public int Length = 1;

	public int Width = 1;

	public int Height = 1;

	[ReadOnly]
	public Vector3 ZeroCellPos = Vector3.zero;

	public Vector3Int RoomPos = Vector3Int.zero;

	public GameObject TemplateCell;

	public GameObject TemplateIndicator;

	public GameObject TemplateDotLine_Row;

	public GameObject TemplateDotLine_Col;

	[ReadOnly]
	public bool IsNewCreate;

	[ReadOnly]
	public bool IsLegal;

	private EFurCellVisible eCellVisible;

	private Transform Root_Cell;

	private Transform Root_Collider;

	private Transform Root_Navicut;

	[ReadOnly]
	public Transform Root_Bubble;

	private Transform Root_Model;

	private Transform Root_DotLine;

	private Transform Root_Interactive;

	private GameObject goAnimNaviCut;

	private bool animNaviCutProbed;

	private bool hasAnimNaviCut;

	private DormFurObjCell[,,] cells;

	private DormFurObjInteractivePoint[] interactivePoints;

	private Collider[] Colliders;

	private Vector3 v3Delta = Vector3.zero;

	private Vector3 v3Offset = Vector3.zero;

	private HotfixEnum.DormFurRotate PreviousLandedRotate;

	private Vector3Int PreviousLandedRoomPos = Vector3Int.zero;

	private List<DormInteractive> _interactiveDataRows = new List<DormInteractive>();

	protected DormFurObjStateMgr stateMgr;

	public bool CanDoInteractived
	{
		get
		{
			if (interactivePoints != null)
			{
				return interactivePoints.Length != 0;
			}
			return false;
		}
	}

	public DormFurObjInteractivePoint[] InteractivePoints => interactivePoints;

	public int LEN
	{
		get
		{
			if (cells == null)
			{
				return 0;
			}
			return cells.GetLength(0);
		}
	}

	public int WID
	{
		get
		{
			if (cells == null)
			{
				return 0;
			}
			return cells.GetLength(1);
		}
	}

	public int HEI
	{
		get
		{
			if (cells == null)
			{
				return 0;
			}
			return cells.GetLength(2);
		}
	}

	public bool CalcFloorCapacity
	{
		get
		{
			if (Type != HotfixEnum.DormFurType.OnFloor && Type != HotfixEnum.DormFurType.FloorCarpet)
			{
				return Type == HotfixEnum.DormFurType.FloorPoster;
			}
			return true;
		}
	}

	public bool IsOnWall
	{
		get
		{
			if (Type != HotfixEnum.DormFurType.OnWall)
			{
				return Type == HotfixEnum.DormFurType.Poster;
			}
			return true;
		}
	}

	public bool CanSwitchTo
	{
		get
		{
			if (FixedType != HotfixEnum.DormFurFixedType.Wall && FixedType != HotfixEnum.DormFurFixedType.Floor)
			{
				return FixedType != HotfixEnum.DormFurFixedType.Elevator;
			}
			return false;
		}
	}

	public bool IsFlatDecor
	{
		get
		{
			if (Type != HotfixEnum.DormFurType.Carpet && Type != HotfixEnum.DormFurType.Poster && Type != HotfixEnum.DormFurType.Wall)
			{
				return Type == HotfixEnum.DormFurType.Floor;
			}
			return true;
		}
	}

	public bool IsElevator => FixedType == HotfixEnum.DormFurFixedType.Elevator;

	public bool HasFreeInteractivePoint
	{
		get
		{
			if (interactivePoints == null)
			{
				return false;
			}
			for (int i = 0; i < interactivePoints.Length; i++)
			{
				if (interactivePoints[i] != null && !interactivePoints[i].IsUsing)
				{
					return true;
				}
			}
			return false;
		}
	}

	public bool HasAnyOccupiedInteractivePoint
	{
		get
		{
			if (interactivePoints == null)
			{
				return false;
			}
			for (int i = 0; i < interactivePoints.Length; i++)
			{
				if (interactivePoints[i] != null && interactivePoints[i].IsUsing)
				{
					return true;
				}
			}
			return false;
		}
	}

	public DormCommonInteractionAnimationLibrary animLibrary { get; private set; }

	public DormFurObjState FSMState => stateMgr?.State ?? DormFurObjState.None;

	protected override void Awake()
	{
		base.Awake();
		entityType = DormConstValue.LAYER_FURNITURE;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InitRoots();
		if (Application.isPlaying)
		{
			SwitchToIdle();
		}
	}

	private void OnDestroy()
	{
		ClearFur(bForce: true);
	}

	public void InitRoots()
	{
		if (Root_Cell == null)
		{
			Root_Cell = transform.Find("==cell_root==");
		}
		if (Root_Collider == null)
		{
			Root_Collider = transform.Find("==collider_root==");
		}
		if (Root_Navicut == null)
		{
			Root_Navicut = transform.Find("==navicut_root==");
		}
		if (Root_Bubble == null)
		{
			Root_Bubble = transform.Find("==bubble_root==");
		}
		if (Root_Model == null)
		{
			Root_Model = transform.Find("==model_root==");
		}
		if (Root_DotLine == null)
		{
			Root_DotLine = transform.Find("==dot_line_root==");
		}
		if (Root_Interactive == null)
		{
			Root_Interactive = transform.Find("==interactive_root==");
		}
	}

	public void Init(FurnitureInfo furInfo, EFurCellVisible e)
	{
		eCellVisible = e;
		ClearFur(bForce: false);
		EnableAnimNaviCut(bEnable: false);
		Root_DotLine.gameObject.SetActive(value: false);
		if (furInfo != null)
		{
			FurId = (int)furInfo.FurnitureId;
			DormFurniture dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture(FurId);
			Type = (HotfixEnum.DormFurType)dormFurniture.PutType;
			Rotate = (HotfixEnum.DormFurRotate)furInfo.Rotation;
			FixedType = (HotfixEnum.DormFurFixedType)dormFurniture.Fixed;
			Length = dormFurniture.L;
			Width = dormFurniture.W;
			Height = dormFurniture.H;
			CacheInteractiveData();
		}
		Quaternion localRotation = AdjustRotate();
		Root_Collider.localRotation = localRotation;
		Root_Navicut.localRotation = localRotation;
		Root_Bubble.localRotation = localRotation;
		Root_Model.localRotation = localRotation;
		Root_Interactive.localRotation = localRotation;
		InitCells();
		InitCollider();
		InitNaviCut();
		InitInteractivePoint();
		InitDotLine();
		CalcOffset();
	}

	private Quaternion AdjustRotate()
	{
		switch (Type)
		{
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.Poster:
			if (Rotate == HotfixEnum.DormFurRotate.Half)
			{
				Rotate = HotfixEnum.DormFurRotate.None;
			}
			else if (Rotate == HotfixEnum.DormFurRotate.Quarter3)
			{
				Rotate = HotfixEnum.DormFurRotate.Quarter;
			}
			break;
		case HotfixEnum.DormFurType.Wall:
			Rotate = HotfixEnum.DormFurRotate.None;
			break;
		case HotfixEnum.DormFurType.Floor:
			Rotate = HotfixEnum.DormFurRotate.None;
			Height = 1;
			break;
		}
		return Quaternion.AngleAxis(90 * (int)Rotate, Vector3.up);
	}

	private void InitCells()
	{
		switch (Rotate)
		{
		case HotfixEnum.DormFurRotate.None:
		case HotfixEnum.DormFurRotate.Half:
			cells = new DormFurObjCell[Length, Width, Height];
			break;
		case HotfixEnum.DormFurRotate.Quarter:
		case HotfixEnum.DormFurRotate.Quarter3:
			cells = new DormFurObjCell[Width, Length, Height];
			break;
		}
		int length = cells.GetLength(0);
		int length2 = cells.GetLength(1);
		int length3 = cells.GetLength(2);
		InitZeroCellPos(length, length2, length3);
		FillCell(length, length2, length3);
	}

	private void InitZeroCellPos(float Len, float Wid, float Hei)
	{
		ZeroCellPos = Vector3.zero;
		switch (Type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.Carpet:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			ZeroCellPos = new Vector3(0.5f - Len / 2f, 0.5f, 0.5f - Wid / 2f);
			break;
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.Poster:
			if (Rotate == HotfixEnum.DormFurRotate.None)
			{
				ZeroCellPos = new Vector3(0.5f - Len / 2f, 0.5f - Hei / 2f, 0.5f);
			}
			else if (Rotate == HotfixEnum.DormFurRotate.Quarter)
			{
				ZeroCellPos = new Vector3(0.5f, 0.5f - Hei / 2f, 0.5f - Wid / 2f);
			}
			break;
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
			ZeroCellPos = new Vector3(0.5f, 0.5f, 0.5f);
			break;
		}
	}

	private void FillCell(int Len, int Wid, int Hei)
	{
		for (int i = 0; i < Hei; i++)
		{
			for (int j = 0; j < Wid; j++)
			{
				for (int k = 0; k < Len; k++)
				{
					if (k <= 0 || j <= 0 || Type != HotfixEnum.DormFurType.Wall)
					{
						cells[k, j, i] = new DormFurObjCell();
						DormFurObjCell dormFurObjCell = cells[k, j, i];
						dormFurObjCell.x = ZeroCellPos.x + (float)k;
						dormFurObjCell.y = ZeroCellPos.y + (float)i;
						dormFurObjCell.z = ZeroCellPos.z + (float)j;
						if (dormFurObjCell.Cube != null)
						{
							UnityEngine.Object.DestroyImmediate(dormFurObjCell.Cube);
							dormFurObjCell.Cube = null;
						}
						switch (eCellVisible)
						{
						case EFurCellVisible.Invisible:
							dormFurObjCell.Cube = new GameObject();
							break;
						case EFurCellVisible.Visible_All:
							dormFurObjCell.Cube = UnityEngine.Object.Instantiate(TemplateCell);
							break;
						}
						if (dormFurObjCell.Cube != null)
						{
							dormFurObjCell.Cube.transform.SetParent(Root_Cell);
							dormFurObjCell.Cube.name = $"{k}={(DormConstValue.NAME_BY_LWH ? j : i)}={(DormConstValue.NAME_BY_LWH ? i : j)}";
							dormFurObjCell.Cube.transform.localPosition = new Vector3(dormFurObjCell.x, dormFurObjCell.y, dormFurObjCell.z);
						}
					}
				}
			}
		}
	}

	private void InitCollider()
	{
		if (Colliders == null)
		{
			Colliders = GetComponentsInChildren<Collider>();
		}
		if (Colliders == null || Colliders.Length == 0)
		{
			return;
		}
		Collider[] colliders = Colliders;
		foreach (Collider collider in colliders)
		{
			if (Type == HotfixEnum.DormFurType.Wall || Type == HotfixEnum.DormFurType.Floor)
			{
				collider.gameObject.layer = DormConstValue.LAYER_FLOOR_WALL;
			}
			else
			{
				collider.gameObject.layer = DormConstValue.LAYER_FURNITURE;
			}
		}
	}

	private void InitNaviCut()
	{
		if (FixedType == HotfixEnum.DormFurFixedType.Elevator)
		{
			EnableAnimNaviCut(bEnable: true);
		}
	}

	private void InitInteractivePoint()
	{
		for (int num = Root_Interactive.childCount - 1; num >= 0; num--)
		{
			Root_Interactive.GetChild(num).gameObject.SetActive(value: false);
		}
		if (!CalcFloorCapacity)
		{
			return;
		}
		Transform[] componentsInChildren = Root_Model.GetComponentsInChildren<Transform>();
		Transform transform = null;
		Transform transform2 = null;
		Transform[] array = componentsInChildren;
		foreach (Transform transform3 in array)
		{
			string text = transform3.name;
			string oldValue;
			string text2;
			if (text.StartsWith(DormConstValue.INTER_POINT_IN_FBX_START))
			{
				oldValue = DormConstValue.INTER_POINT_IN_FBX_START;
				text2 = DormConstValue.INTER_POINT_NAME_START;
			}
			else
			{
				if (!text.StartsWith(DormConstValue.INTER_POINT_IN_FBX_END))
				{
					text2 = string.Empty;
					continue;
				}
				oldValue = DormConstValue.INTER_POINT_IN_FBX_END;
				text2 = DormConstValue.INTER_POINT_NAME_END;
			}
			text = text.Replace(oldValue, text2);
			if (!text.Equals(text2))
			{
				transform = Root_Interactive.Find(text);
				if (transform == null)
				{
					GameObject gameObject = new GameObject(text);
					gameObject.transform.SetParent(Root_Interactive);
					gameObject.transform.position = transform3.position;
				}
				else
				{
					transform.position = transform3.position;
					transform.rotation = transform3.rotation;
					transform.gameObject.SetActive(value: true);
				}
			}
		}
		Dictionary<string, DormFurObjInteractivePoint> dictionary = new Dictionary<string, DormFurObjInteractivePoint>();
		DormFurObjInteractivePoint dormFurObjInteractivePoint = null;
		bool flag = false;
		for (int num2 = Root_Interactive.childCount - 1; num2 >= 0; num2--)
		{
			GameObject gameObject = Root_Interactive.GetChild(num2).gameObject;
			if (!gameObject.activeSelf)
			{
				UnityEngine.Object.DestroyImmediate(gameObject);
				continue;
			}
			transform = gameObject.transform;
			string text;
			if (gameObject.name.StartsWith(DormConstValue.INTER_POINT_NAME_START))
			{
				flag = true;
				text = gameObject.name.Replace(DormConstValue.INTER_POINT_NAME_START, string.Empty);
			}
			else
			{
				if (!gameObject.name.StartsWith(DormConstValue.INTER_POINT_NAME_END))
				{
					flag = false;
					text = string.Empty;
					UnityEngine.Object.DestroyImmediate(gameObject);
					continue;
				}
				flag = false;
				text = gameObject.name.Replace(DormConstValue.INTER_POINT_NAME_END, string.Empty);
			}
			dormFurObjInteractivePoint = null;
			if (!dictionary.ContainsKey(text))
			{
				dormFurObjInteractivePoint = new DormFurObjInteractivePoint();
				dictionary.Add(text, dormFurObjInteractivePoint);
			}
			else
			{
				dormFurObjInteractivePoint = dictionary.get_Item(text);
				if (dormFurObjInteractivePoint == null)
				{
					dictionary.set_Item(text, new DormFurObjInteractivePoint());
					dormFurObjInteractivePoint = dictionary.get_Item(text);
				}
			}
			dormFurObjInteractivePoint.bindEntityID = 0L;
			dormFurObjInteractivePoint.reserveEntityID = 0L;
			if (flag)
			{
				dormFurObjInteractivePoint.target_by_anim_start = transform;
			}
			else
			{
				dormFurObjInteractivePoint.target_by_anim_end = transform;
			}
			transform2 = null;
			for (int num3 = transform.childCount - 1; num3 >= 0; num3--)
			{
				if (num3 == 0)
				{
					transform2 = transform.GetChild(num3);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(transform.GetChild(num3).gameObject);
				}
			}
			if (transform2 == null)
			{
				gameObject = new GameObject("design");
				gameObject.transform.parent = transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.transform.localScale = Vector3.one;
				transform2 = gameObject.transform;
			}
			if (flag)
			{
				dormFurObjInteractivePoint.target_by_design_start = transform2;
				for (int num4 = transform2.childCount - 1; num4 >= 0; num4--)
				{
					if (num4 == 0)
					{
						dormFurObjInteractivePoint.indicator = transform2.GetChild(num4).gameObject;
					}
					else
					{
						UnityEngine.Object.DestroyImmediate(transform2.GetChild(num4).gameObject);
					}
				}
				if (dormFurObjInteractivePoint.indicator == null)
				{
					dormFurObjInteractivePoint.indicator = UnityEngine.Object.Instantiate(TemplateIndicator, transform2);
					dormFurObjInteractivePoint.indicator.transform.localPosition = Vector3.zero;
					dormFurObjInteractivePoint.indicator.transform.localScale = Vector3.one;
				}
				dormFurObjInteractivePoint.indicator.name = "indicator";
				Quaternion rotation = transform.rotation;
				Quaternion quaternion = Quaternion.Inverse(rotation);
				Quaternion rotation2 = transform2.rotation;
				Quaternion quaternion2 = Quaternion.Inverse(rotation2);
				dormFurObjInteractivePoint.indicator.transform.rotation = rotation * quaternion * rotation2 * quaternion2 * Quaternion.identity;
				dormFurObjInteractivePoint.indicator.SetActive(eCellVisible == EFurCellVisible.Visible_All);
			}
			else
			{
				dormFurObjInteractivePoint.target_by_design_end = transform2;
			}
		}
		interactivePoints = dictionary.Values.ToArray();
	}

	private void CalcOffset()
	{
		v3Offset = Vector3.zero;
		int num = LEN - 1;
		int num2 = WID - 1;
		int rotate = (int)Rotate;
		if (IsOnWall)
		{
			if (rotate % 2 == 0)
			{
				num2 = 0;
			}
			else
			{
				num = 0;
			}
		}
		DormFurObjCell dormFurObjCell = cells[num, num2, 0];
		if (dormFurObjCell == null)
		{
			return;
		}
		if (IsOnWall)
		{
			if (rotate % 2 == 0)
			{
				v3Offset = new Vector3(dormFurObjCell.x, dormFurObjCell.y, 0f);
			}
			else
			{
				v3Offset = new Vector3(0f, dormFurObjCell.y, dormFurObjCell.z);
			}
		}
		else
		{
			v3Offset = new Vector3(dormFurObjCell.x, 0f, dormFurObjCell.z);
		}
	}

	public void ClearFur(bool bForce)
	{
		if (bForce)
		{
			FurId = 0;
			Type = HotfixEnum.DormFurType.OnFloor;
			Rotate = HotfixEnum.DormFurRotate.None;
			FixedType = HotfixEnum.DormFurFixedType.None;
			Length = (Width = (Height = 0));
			ZeroCellPos = Vector3.zero;
			RoomPos = Vector3Int.zero;
		}
		if (cells != null)
		{
			for (int i = 0; i < HEI; i++)
			{
				for (int j = 0; j < WID; j++)
				{
					for (int k = 0; k < LEN; k++)
					{
						cells[k, j, i]?.Clear();
					}
				}
			}
			cells = null;
		}
		if (Root_Cell != null && Root_Cell.childCount > 0)
		{
			for (int num = Root_Cell.childCount - 1; num >= 0; num--)
			{
				UnityEngine.Object.DestroyImmediate(Root_Cell.GetChild(num).gameObject);
			}
		}
		EnableAnimNaviCut(bEnable: false);
		if (interactivePoints == null)
		{
			return;
		}
		DormFurObjInteractivePoint[] array = interactivePoints;
		foreach (DormFurObjInteractivePoint dormFurObjInteractivePoint in array)
		{
			if (dormFurObjInteractivePoint.target_by_design_start != null && dormFurObjInteractivePoint.target_by_design_start.childCount > 0)
			{
				for (int num2 = dormFurObjInteractivePoint.target_by_design_start.childCount - 1; num2 >= 0; num2--)
				{
					UnityEngine.Object.DestroyImmediate(dormFurObjInteractivePoint.target_by_design_start.GetChild(num2).gameObject);
				}
			}
		}
		interactivePoints = null;
	}

	public void SetPos(Vector3Int v3i)
	{
		SetPos(v3i.x, v3i.y, v3i.z);
	}

	public void SetPos(int x, int y, int z)
	{
		switch (Type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.Carpet:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			y = 0;
			break;
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.Poster:
			if (Rotate == HotfixEnum.DormFurRotate.None)
			{
				z = 0;
			}
			else if (Rotate == HotfixEnum.DormFurRotate.Quarter)
			{
				x = 0;
			}
			break;
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
			x = (y = (z = 0));
			break;
		}
		RoomPos.x = x;
		RoomPos.y = y;
		RoomPos.z = z;
		transform.localPosition = RoomPos - ZeroCellPos + DormConstValue.V3_ZERO_OFFSET;
		if (y <= 2 && IsOnWall && Root_Navicut != null && Application.isPlaying)
		{
			float x2 = Root_Navicut.position.x;
			float z2 = Root_Navicut.position.z;
			Root_Navicut.position = new Vector3(x2, 0f, z2);
		}
		v3Delta = Vector3.zero;
	}

	public void SetRotate(bool bClockwise)
	{
		HotfixEnum.DormFurType type = Type;
		if ((uint)(type - 4) > 1u && type != HotfixEnum.DormFurType.FloorPoster)
		{
			int rotate = (int)Rotate;
			rotate = ((!bClockwise) ? (rotate - 1) : (rotate + 1));
			int num = 0;
			int num2 = 3;
			if (rotate > num2)
			{
				rotate = num;
			}
			if (rotate < num)
			{
				rotate = num2;
			}
			Rotate = (HotfixEnum.DormFurRotate)rotate;
			Init(null, EFurCellVisible.None);
			SetAllInteractivePointVisible(bVisible: true);
		}
	}

	public void Follow(Vector3 v3)
	{
		switch (Type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.Carpet:
		case HotfixEnum.DormFurType.FloorCarpet:
			v3.y = 0f;
			break;
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.Poster:
			if (Rotate == HotfixEnum.DormFurRotate.None)
			{
				v3.z = 0f;
			}
			else if (Rotate == HotfixEnum.DormFurRotate.Quarter)
			{
				v3.x = 0f;
			}
			break;
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
		case HotfixEnum.DormFurType.FloorPoster:
			v3 = transform.position;
			break;
		}
		transform.position = v3 - v3Offset;
	}

	public Vector3 GetZeroCellWorldPos()
	{
		return transform.localPosition + ZeroCellPos - DormConstValue.V3_ZERO_OFFSET;
	}

	public DormFurObjInteractivePoint GetInteractivePoint(Transform trRole)
	{
		if (interactivePoints == null)
		{
			return null;
		}
		DormFurObjInteractivePoint dormFurObjInteractivePoint = null;
		int num = interactivePoints.Length;
		float num2 = 9999f;
		float num3 = 0f;
		for (int i = 0; i < num; i++)
		{
			DormFurObjInteractivePoint dormFurObjInteractivePoint2 = interactivePoints[i];
			dormFurObjInteractivePoint2.indicator.SetActive(!dormFurObjInteractivePoint2.IsUsing);
			if (dormFurObjInteractivePoint2.IsUsing)
			{
				continue;
			}
			num3 = Vector3.Distance(trRole.position, dormFurObjInteractivePoint2.target_by_design_start.position);
			if (num3 < num2)
			{
				num2 = num3;
				if (dormFurObjInteractivePoint != null && dormFurObjInteractivePoint != dormFurObjInteractivePoint2)
				{
					dormFurObjInteractivePoint.indicator.transform.localScale = Vector3.one;
				}
				dormFurObjInteractivePoint = dormFurObjInteractivePoint2;
				dormFurObjInteractivePoint.indicator.transform.localScale = DormConstValue.V3_SCALE;
			}
			else
			{
				dormFurObjInteractivePoint.indicator.transform.localScale = Vector3.one;
			}
		}
		return dormFurObjInteractivePoint;
	}

	public DormFurObjInteractivePoint GetFreeInteractivePoint(long forEntityID = 0L)
	{
		if (interactivePoints == null)
		{
			return null;
		}
		for (int i = 0; i < interactivePoints.Length; i++)
		{
			if (interactivePoints[i] != null && interactivePoints[i].IsFreeFor(forEntityID))
			{
				return interactivePoints[i];
			}
		}
		return null;
	}

	public void SetAllInteractivePointVisible(bool bVisible)
	{
		if (interactivePoints == null)
		{
			return;
		}
		for (int num = interactivePoints.Length - 1; num >= 0; num--)
		{
			GameObject indicator = interactivePoints[num].indicator;
			if (!(indicator == null))
			{
				indicator.SetActive(bVisible);
				indicator.transform.localScale = Vector3.one;
			}
		}
	}

	public void SetDotLine(bool bVisible)
	{
		if ((Type == HotfixEnum.DormFurType.Floor || Type == HotfixEnum.DormFurType.Wall) && Root_DotLine != null && Root_DotLine.gameObject.activeSelf != bVisible)
		{
			Root_DotLine.gameObject.SetActive(bVisible);
		}
	}

	public void InitDotLine()
	{
	}

	public void MarkLanded()
	{
		PreviousLandedRotate = Rotate;
		PreviousLandedRoomPos = RoomPos;
		IsNewCreate = false;
	}

	public void SetToLastLanded()
	{
		Rotate = PreviousLandedRotate;
		Init(null, EFurCellVisible.None);
		SetAllInteractivePointVisible(bVisible: true);
		SetPos(PreviousLandedRoomPos);
	}

	public bool EnableAnimNaviCut(bool bEnable)
	{
		if (goAnimNaviCut == null)
		{
			goAnimNaviCut = transform.Find(DormConstValue.FUR_ANIM_NAVI_CUT)?.gameObject;
		}
		goAnimNaviCut?.SetActive(bEnable);
		return goAnimNaviCut != null;
	}

	public void ApplyInteractionNaviCut(bool bEnable)
	{
		if (!IsElevator && HasAnimNaviCut() && goAnimNaviCut.activeSelf != bEnable)
		{
			EnableAnimNaviCut(bEnable);
			(ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController)?.ForceUpdateNavCuts();
		}
	}

	private bool HasAnimNaviCut()
	{
		if (animNaviCutProbed)
		{
			return hasAnimNaviCut;
		}
		animNaviCutProbed = true;
		if (goAnimNaviCut == null)
		{
			goAnimNaviCut = transform.Find(DormConstValue.FUR_ANIM_NAVI_CUT)?.gameObject;
		}
		hasAnimNaviCut = goAnimNaviCut != null && goAnimNaviCut.GetComponentsInChildren<NavmeshCut>(includeInactive: true).Length != 0;
		return hasAnimNaviCut;
	}

	public void TryHideFurObj(bool bIsFloorFurObj, bool bVisible)
	{
		if (Type == HotfixEnum.DormFurType.Wall || Type == HotfixEnum.DormFurType.Floor || Type == HotfixEnum.DormFurType.FloorCarpet)
		{
			return;
		}
		if (bIsFloorFurObj)
		{
			if (Type != HotfixEnum.DormFurType.OnFloor)
			{
				return;
			}
		}
		else if (Type != HotfixEnum.DormFurType.OnWall)
		{
			return;
		}
		Root_Collider?.gameObject.SetActive(bVisible);
		Root_Model?.gameObject.SetActive(bVisible);
	}

	public void SetElevatorCollider(bool bEnable)
	{
		if (FixedType != HotfixEnum.DormFurFixedType.Elevator)
		{
			return;
		}
		Root_Collider?.gameObject.SetActive(bEnable);
		if (Colliders != null)
		{
			Collider[] colliders = Colliders;
			for (int i = 0; i < colliders.Length; i++)
			{
				colliders[i].enabled = bEnable;
			}
		}
	}

	public void SetNaviCurRoot(bool bActive)
	{
		if (Root_Navicut != null)
		{
			Root_Navicut.gameObject.SetActive(bActive);
		}
	}

	private void CacheInteractiveData()
	{
		_interactiveDataRows.Clear();
		foreach (KeyValuePair<int, DormInteractive> dormInteractiveDatum in Singleton<HotfixDataController>.Instance.DormInteractiveData)
		{
			DormInteractive value = dormInteractiveDatum.Value;
			if (value != null && value.FurniturnId == FurId)
			{
				_interactiveDataRows.Add(value);
			}
		}
	}

	public DormInteractive MatchInteractiveData(DormActor actor)
	{
		if (null == actor)
		{
			return null;
		}
		foreach (DormInteractive interactiveDataRow in _interactiveDataRows)
		{
			if (interactiveDataRow != null)
			{
				if (interactiveDataRow.DormInterType == 1)
				{
					return interactiveDataRow;
				}
				if (interactiveDataRow.DormInterType == 2 && interactiveDataRow.CharId == actor.SkinId)
				{
					return interactiveDataRow;
				}
			}
		}
		return null;
	}

	public bool CanInteractBy(DormActor actor)
	{
		if (null == actor)
		{
			return false;
		}
		if (IsElevator)
		{
			return actor is DormPlayer;
		}
		return MatchInteractiveData(actor) != null;
	}

	public DormFurObjInteractivePoint GetInteractivePointByBindEntity(long entityID)
	{
		if (interactivePoints == null)
		{
			return null;
		}
		for (int i = 0; i < interactivePoints.Length; i++)
		{
			DormFurObjInteractivePoint dormFurObjInteractivePoint = interactivePoints[i];
			if (dormFurObjInteractivePoint != null && dormFurObjInteractivePoint.bindEntityID == entityID)
			{
				return dormFurObjInteractivePoint;
			}
		}
		return null;
	}

	public void BindInteractivePoint(DormFurObjInteractivePoint point, long entityID)
	{
		if (point != null)
		{
			point.bindEntityID = entityID;
		}
	}

	public bool ReleaseInteractivePoint(long entityID)
	{
		DormFurObjInteractivePoint interactivePointByBindEntity = GetInteractivePointByBindEntity(entityID);
		if (interactivePointByBindEntity == null)
		{
			return false;
		}
		interactivePointByBindEntity.bindEntityID = 0L;
		return true;
	}

	public void ReserveInteractivePoint(DormFurObjInteractivePoint point, long entityID)
	{
		if (point != null)
		{
			point.reserveEntityID = entityID;
		}
	}

	public void ReleasePointReservation(DormFurObjInteractivePoint point, long entityID)
	{
		if (point != null && point.reserveEntityID == entityID)
		{
			point.reserveEntityID = 0L;
		}
	}

	public void PlaceActorAtPointStart(DormActor actor, DormFurObjInteractivePoint point)
	{
		if (!(actor == null) && point != null && !(point.target_by_anim_start == null))
		{
			Vector3 position = point.target_by_anim_start.position;
			position.y = 0f;
			actor.transform.SetPositionAndRotation(position, point.target_by_anim_start.rotation);
		}
	}

	public void PlaceActorAtPointEnd(DormActor actor, DormFurObjInteractivePoint point)
	{
		ApplyInteractionNaviCut(bEnable: false);
		if (!(actor == null) && point != null)
		{
			Transform transform;
			if (point.target_by_anim_end != null)
			{
				transform = point.target_by_anim_end;
			}
			else
			{
				transform = ((point.target_by_anim_start != null) ? point.target_by_anim_start : point.target_by_design_end);
			}
			if (!(transform == null))
			{
				actor.SyncMovementLocation(new TSVector2(transform.position.x, transform.position.z), 0);
				actor.SyncRotation(transform.eulerAngles.y);
			}
		}
	}

	public void ResetInteractiveState()
	{
		if (interactivePoints != null)
		{
			for (int i = 0; i < interactivePoints.Length; i++)
			{
				if (interactivePoints[i] != null)
				{
					interactivePoints[i].bindEntityID = 0L;
					interactivePoints[i].reserveEntityID = 0L;
				}
			}
		}
		SetAllInteractivePointVisible(bVisible: false);
		StopTimelineAnimation();
		if (FSMState == DormFurObjState.Interactive)
		{
			SwitchToIdle();
		}
	}

	public void StartInteraction(DormActor actor, DormInteractiveContext ctx, Action onComplete)
	{
		if (IsElevator)
		{
			actor.DoInteractiveWithObject(ctx);
			return;
		}
		actor.DoInteractiveWithObject(ctx);
		if (stateMgr?.GetFSM(DormFurObjState.Interactive) is DormFurObjFSM_Interactive dormFurObjFSM_Interactive)
		{
			dormFurObjFSM_Interactive.StartInteraction(actor, ctx.point, onComplete);
			return;
		}
		onComplete?.Invoke();
		actor.InterWithObjeComplete();
	}

	public bool ResumeInteraction(DormActor actor, Action onComplete)
	{
		DormFurObjInteractivePoint interactivePointByBindEntity = GetInteractivePointByBindEntity(actor.id);
		if (interactivePointByBindEntity == null)
		{
			return false;
		}
		SetAllInteractivePointVisible(bVisible: false);
		StartInteraction(actor, new DormInteractiveContext
		{
			furObj = this,
			point = interactivePointByBindEntity,
			placeAtStartImmediately = true
		}, onComplete);
		return true;
	}

	public void InterruptInteraction()
	{
		if (stateMgr?.GetFSM(DormFurObjState.Interactive) is DormFurObjFSM_Interactive dormFurObjFSM_Interactive)
		{
			dormFurObjFSM_Interactive.InterruptInteraction();
		}
	}

	protected override void InitializeAnimation()
	{
		base.InitializeAnimation();
		if (animLibrary == null)
		{
			animLibrary = GetComponent<DormCommonInteractionAnimationLibrary>();
		}
	}

	public void PlayIdleAnim()
	{
		if (animLibrary != null && animLibrary.idleTimelinePrefab != null)
		{
			PlayTimelineAnimation(animLibrary.idleTimelinePrefab, 1, null, DirectorWrapMode.Loop);
		}
		else
		{
			PlayAnimByName("Idle");
		}
	}

	public void PlayOpenAnim()
	{
		if (animLibrary != null && animLibrary.openTimelinePrefab != null)
		{
			PlayTimelineAnimation(animLibrary.openTimelinePrefab, 1, null, DirectorWrapMode.Hold);
		}
		else
		{
			PlayAnimByName("Open");
		}
	}

	public void PlayCloseAnim()
	{
		if (animLibrary != null && animLibrary.closeTimelinePrefab != null)
		{
			PlayTimelineAnimation(animLibrary.closeTimelinePrefab, 1, null, DirectorWrapMode.Hold);
		}
		else
		{
			PlayAnimByName("Close");
		}
	}

	public void PlayAnimByName(string aniName, float crossFadeTime = 0f)
	{
		if (animator != null && animator.runtimeAnimatorController != null)
		{
			if (crossFadeTime > 0f)
			{
				animator.CrossFade(aniName, crossFadeTime);
			}
			else
			{
				animator.Play(aniName);
			}
		}
	}

	protected override void InitializeComponents()
	{
		base.InitializeComponents();
		stateMgr = new DormFurObjStateMgr(this);
		RegisterFSM();
	}

	protected virtual void RegisterFSM()
	{
		RegisterFSM(DormFurObjState.None);
		RegisterFSM(DormFurObjState.Idle);
		RegisterFSM(DormFurObjState.Interactive);
		RegisterFSM(DormFurObjState.Decorate);
	}

	protected void RegisterFSM(DormFurObjState state)
	{
		stateMgr.Register(state);
	}

	protected void SwitchState(DormFurObjState state, object data = null)
	{
		stateMgr.Switch(state, data);
	}

	public void SwitchToIdle()
	{
		if (stateMgr != null && FSMState != DormFurObjState.Idle)
		{
			SwitchState(DormFurObjState.Idle);
		}
	}

	public void SwitchToDecorate()
	{
		if (stateMgr != null && FSMState != DormFurObjState.Decorate)
		{
			SwitchState(DormFurObjState.Decorate);
		}
	}

	public void SwitchToInteractive()
	{
		if (stateMgr != null && FSMState != DormFurObjState.Interactive)
		{
			SwitchState(DormFurObjState.Interactive);
		}
	}

	public void SwitchToNone()
	{
		if (stateMgr != null && FSMState != DormFurObjState.None)
		{
			SwitchState(DormFurObjState.None);
		}
	}

	protected virtual void Update()
	{
		stateMgr?.Update();
	}

	protected virtual void LateUpdate()
	{
		stateMgr?.LateUpdate();
	}

	protected override void OnDisable()
	{
		SwitchToNone();
		base.OnDisable();
	}

	protected override void InitializeVisual()
	{
		base.InitializeVisual();
		InitializeVisualComponents(0f, 0f, isOccludee: false);
	}
}
