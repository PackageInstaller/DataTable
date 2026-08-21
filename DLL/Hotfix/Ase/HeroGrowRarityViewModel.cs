using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class HeroGrowRarityViewModel : OptionBase
{
	public static int LayerBranchCount = 4;

	private HeroModel _heroModel;

	private Dictionary<int, DRHeroSeat> _heroSeatConfigs = new Dictionary<int, DRHeroSeat>();

	private int minLayer;

	private int maxLayer;

	private int curLayer;

	private bool showLeftArrow;

	private bool showRightArrow;

	private string curRarityLittleIcon = "";

	private string curRarityName;

	private string curRarityDesc;

	private string curSpineAniName = "";

	private bool midPointSelected;

	private HeroGrowRarityItemData curSelectedItemData;

	private HeroGrowRarityItemData.ItemStateEnum layerState;

	private DRHeroSeat curSeatConfig;

	private int curOptType;

	private int curSeatPoint;

	private bool isSelf;

	private HeroGrowRarityItemData.ItemStateEnum curItemState;

	private InteractionRequest<int> focusPointRequest = new InteractionRequest<int>();

	private InteractionRequest<DRHeroSeat> onCurLayerChanged = new InteractionRequest<DRHeroSeat>();

	private InteractionRequest<int> onPointItemLighted = new InteractionRequest<int>();

	private InteractionRequest onMiddleItemLighted = new InteractionRequest();

	private InteractionRequest onSpineAniChanged = new InteractionRequest();

	private int curFocusIndex = -1;

	public int CurLayer
	{
		get
		{
			return curLayer;
		}
		set
		{
			if (value < minLayer)
			{
				value = minLayer;
			}
			else if (value > maxLayer)
			{
				value = maxLayer;
			}
			ShowLeftArrow = value > minLayer;
			ShowRightArrow = value < maxLayer;
			int num = curLayer;
			Set(ref curLayer, value, "CurLayer");
			if (num != curLayer)
			{
				RefreshWithLayerChange();
			}
		}
	}

	public int MaxLayer => maxLayer;

	public HeroModel HeroModel => _heroModel;

	public Dictionary<int, DRHeroSeat> HeroSeatConfigs => _heroSeatConfigs;

	public HeroGrowRarityItemData.ItemStateEnum LayerState
	{
		get
		{
			return layerState;
		}
		set
		{
			Set(ref layerState, value, "LayerState");
		}
	}

	public bool ShowLeftArrow
	{
		get
		{
			return showLeftArrow;
		}
		set
		{
			Set(ref showLeftArrow, value, "ShowLeftArrow");
		}
	}

	public bool ShowRightArrow
	{
		get
		{
			return showRightArrow;
		}
		set
		{
			Set(ref showRightArrow, value, "ShowRightArrow");
		}
	}

	public string CurRarityLittleIcon
	{
		get
		{
			return curRarityLittleIcon;
		}
		set
		{
			Set(ref curRarityLittleIcon, value, "CurRarityLittleIcon");
		}
	}

	public string CurSpineAniName
	{
		get
		{
			return curSpineAniName;
		}
		set
		{
			Set(ref curSpineAniName, value, "CurSpineAniName");
		}
	}

	public string CurRarityName
	{
		get
		{
			return curRarityName;
		}
		set
		{
			Set(ref curRarityName, value, "CurRarityName");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public InteractionRequest OnSpineAniChanged => onSpineAniChanged;

	public bool MidPointSelected
	{
		get
		{
			return midPointSelected;
		}
		set
		{
			Set(ref midPointSelected, value, "MidPointSelected");
		}
	}

	public DRHeroSeat CurSeatConfig => curSeatConfig;

	public int CurOptType => curOptType;

	public int CurSeatPoint => curSeatPoint;

	public InteractionRequest<int> FocusPointRequest => focusPointRequest;

	public HeroGrowRarityItemData.ItemStateEnum CurItemState => curItemState;

	public InteractionRequest<DRHeroSeat> OnCurLayerChanged => onCurLayerChanged;

	public InteractionRequest<int> OnPointItemLighted => onPointItemLighted;

	public InteractionRequest OnMiddleItemLighted => onMiddleItemLighted;

	public HeroGrowRarityViewModel()
	{
	}

	public HeroGrowRarityViewModel(OptionBase parent, HeroModel heroModel, bool isSelf = true)
	{
		base.parent = parent;
		IsSelf = isSelf;
		RefreshData(heroModel);
	}

	public void RefreshData(HeroModel heroModel)
	{
		_heroModel = heroModel;
		minLayer = 1;
		_heroSeatConfigs = GameEntry.DataTable.GetDataRows((DRHeroSeat p) => p.HeroId.Equals(heroModel.Id)).ToDictionary((DRHeroSeat p) => p.TargetSeat);
		maxLayer = _heroSeatConfigs.Keys.Max();
		CurLayer = heroModel.DestinyLevel + 1;
		RefreshWithLayerChange();
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		RefreshWithLayerChange();
		if (MidPointSelected)
		{
			OnMidRarityBtnClick();
		}
		else if (curSelectedItemData != null)
		{
			OnPointItemClick(curSelectedItemData);
		}
	}

	public void ResetCurLayer()
	{
		CurLayer = _heroModel.DestinyLevel + 1;
	}

	private void RefreshWithLayerChange()
	{
		if (_heroSeatConfigs.ContainsKey(CurLayer))
		{
			DRHeroSeat dRHeroSeat = (curSeatConfig = _heroSeatConfigs[CurLayer]);
			CurRarityLittleIcon = $"Hero_Seat_{CurLayer}";
			CurRarityName = dRHeroSeat.SeatName;
			RefreshLayerState();
			onCurLayerChanged.Raise(dRHeroSeat);
		}
	}

	public void RefreshLayerState()
	{
		if (curSeatConfig == null)
		{
			return;
		}
		string text = $"Seat0{CurLayer}";
		string text2 = "_black";
		if (_heroModel.DestinyLevel >= CurLayer)
		{
			LayerState = HeroGrowRarityItemData.ItemStateEnum.Lighted;
			text2 = "_idle";
		}
		else if (_heroModel.DestinyLevel == CurLayer - 1)
		{
			if (_heroModel.DestinyData.Count >= LayerBranchCount)
			{
				bool flag = true;
				foreach (int destinyDatum in _heroModel.DestinyData)
				{
					if (destinyDatum != 1)
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					text2 = "_idle";
					DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(curSeatConfig.NeedItem);
					if (dataRow != null)
					{
						bool flag2 = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().CheckEnough(new PropData(dataRow, curSeatConfig.UpItemNum));
						LayerState = (flag2 ? HeroGrowRarityItemData.ItemStateEnum.Enough : HeroGrowRarityItemData.ItemStateEnum.NotEnough);
					}
					else
					{
						LayerState = HeroGrowRarityItemData.ItemStateEnum.Enough;
					}
				}
			}
			else
			{
				text2 = "_frozen";
				LayerState = HeroGrowRarityItemData.ItemStateEnum.Lock;
			}
		}
		else
		{
			LayerState = HeroGrowRarityItemData.ItemStateEnum.Lock;
		}
		CurSpineAniName = text + text2;
		onSpineAniChanged.Raise();
	}

	public void OnMidRarityBtnClick()
	{
		curOptType = 2;
		curSeatPoint = 0;
		curItemState = LayerState;
		SetSelected();
		parent?.ItemOnClick(this);
	}

	private void OnPointItemClick(HeroGrowRarityItemData itemData)
	{
		SetSelected(itemData);
		curOptType = 1;
		curSeatPoint = itemData.PointIndex;
		curItemState = itemData.State;
		parent?.ItemOnClick(this);
	}

	public void OnLightSuccess(int heroId, int optType, int point = 0)
	{
		if (_heroModel.Id != heroId)
		{
			return;
		}
		if (optType == 1 && point > 0)
		{
			onPointItemLighted.Raise(point);
		}
		else if (optType == 2)
		{
			LayerState = HeroGrowRarityItemData.ItemStateEnum.Lighting;
			onMiddleItemLighted.Raise();
			if (CurLayer == MaxLayer)
			{
				Toast.ShowInfo("已解锁满冠头像，请在头像处查看");
			}
		}
	}

	private void SetSelected(HeroGrowRarityItemData itemData = null)
	{
		if (itemData == null)
		{
			MidPointSelected = true;
			return;
		}
		itemData.Selected = true;
		curSelectedItemData = itemData;
	}

	private void ResetSelected()
	{
		if (curSelectedItemData != null)
		{
			curSelectedItemData.Selected = false;
		}
		MidPointSelected = false;
	}

	public void OnInfoViewVisibleChanged(bool visible, int pointIndex)
	{
		SetFocus(pointIndex);
		if (!visible)
		{
			ResetSelected();
		}
	}

	public void SetFocus(int pointIndex)
	{
		if (curFocusIndex != pointIndex)
		{
			curFocusIndex = pointIndex;
			focusPointRequest.Raise(pointIndex);
		}
	}

	public void UpdateWindowMaskTime(float time)
	{
		parent?.ItemOnClick(new OptionArg(time, "UpdateWindowMaskTime"));
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HeroGrowRarityItemData itemData)
		{
			OnPointItemClick(itemData);
		}
	}
}
