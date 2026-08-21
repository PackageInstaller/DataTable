using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class MapGuidePointItemData : ItemOptionBase
{
	private List<MapGuidePointData> datas;

	private Vector3 curAngle;

	private Vector2 showPos;

	private int guideCount;

	private string guideIcon1;

	private string guideIcon2;

	private string guideIcon3;

	public Vector3 CurAngle
	{
		get
		{
			return curAngle;
		}
		set
		{
			Set(ref curAngle, value, "CurAngle");
		}
	}

	public Vector2 ShowPos
	{
		get
		{
			return showPos;
		}
		set
		{
			Set(ref showPos, value, "ShowPos");
		}
	}

	public int GuideCount
	{
		get
		{
			return guideCount;
		}
		set
		{
			Set(ref guideCount, value, "GuideCount");
		}
	}

	public string GuideIcon1
	{
		get
		{
			return guideIcon1;
		}
		set
		{
			Set(ref guideIcon1, value, "GuideIcon1");
		}
	}

	public string GuideIcon2
	{
		get
		{
			return guideIcon2;
		}
		set
		{
			Set(ref guideIcon2, value, "GuideIcon2");
		}
	}

	public string GuideIcon3
	{
		get
		{
			return guideIcon3;
		}
		set
		{
			Set(ref guideIcon3, value, "GuideIcon3");
		}
	}

	public MapGuidePointItemData()
	{
	}

	public MapGuidePointItemData(OptionBase parent, float angle, List<MapGuidePointData> guideDatas)
	{
		base.parent = parent;
		datas = guideDatas;
		if (angle >= 0f)
		{
			CurAngle = new Vector3(0f, 0f, angle - 180f);
		}
		else
		{
			CurAngle = new Vector3(0f, 0f, angle + 180f);
		}
		GuideCount = guideDatas.Count;
		ShowPos = ((GuideCount > 0) ? guideDatas[0].ShowPos : (Vector2.one * 10000f));
		GuideIcon1 = ((GuideCount > 0) ? InteractivePoint.GetPointIcon(guideDatas[0].PointInfo) : string.Empty);
		GuideIcon2 = ((GuideCount > 1) ? InteractivePoint.GetPointIcon(guideDatas[1].PointInfo) : string.Empty);
		GuideIcon3 = ((GuideCount > 2) ? InteractivePoint.GetPointIcon(guideDatas[2].PointInfo) : string.Empty);
	}

	public void OnClick()
	{
		if (datas.Count > 0)
		{
			parent?.ItemOnClick(datas[0]);
		}
	}
}
