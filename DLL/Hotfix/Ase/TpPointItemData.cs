using UnityEngine;

namespace Ase;

public class TpPointItemData : InteractivePointData
{
	private DRTransferPoint configData;

	private string highLightIcon = "";

	private string lockIcon = "";

	private bool isHighlight;

	private Vector3 nameBgScale;

	public string HighLightIcon
	{
		get
		{
			return highLightIcon;
		}
		private set
		{
			Set(ref highLightIcon, value, "HighLightIcon");
		}
	}

	public string LockIcon
	{
		get
		{
			return lockIcon;
		}
		private set
		{
			Set(ref lockIcon, value, "LockIcon");
		}
	}

	public bool IsHighlight
	{
		get
		{
			return isHighlight;
		}
		set
		{
			Set(ref isHighlight, value, "IsHighlight");
		}
	}

	public Vector3 NameBgScale
	{
		get
		{
			return nameBgScale;
		}
		set
		{
			Set(ref nameBgScale, value, "NameBgScale");
		}
	}

	public TpPointItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public void RefreshData(DRTransferPoint drData, DRMap drMap, Vector2 mapSize, float sceneRatio = 0f)
	{
		configData = drData;
		InteractivePoint.PointType type = ((drData.PointType != 1) ? InteractivePoint.PointType.SpecialTp : InteractivePoint.PointType.NormalTp);
		Vector2 worldPos = new Vector2((drData.TransferPointPos.Count > 0) ? drData.TransferPointPos[0] : 0f, (drData.TransferPointPos.Count > 1) ? drData.TransferPointPos[1] : 0f);
		Vector2 posOffset = new Vector2((drMap.WorldPosOffset.Count > 0) ? drMap.WorldPosOffset[0] : 0f, (drMap.WorldPosOffset.Count > 1) ? drMap.WorldPosOffset[1] : 0f);
		base.PointInfo = new InteractivePoint.PointInfo(type, drData.Id, drData.TransferPointName, worldPos, posOffset, mapSize, sceneRatio);
		base.Pos = base.PointInfo.Pos;
		base.Icon = $"map_mark_{drData.PointType + 1}_1";
		HighLightIcon = $"map_mark_{drData.PointType + 1}_2";
		LockIcon = $"map_mark_{drData.PointType + 1}_0";
	}

	public void RefreshState(bool active)
	{
		base.IsLock = !active;
	}

	public override void SetScale(float scale)
	{
		base.SetScale(scale);
		float num = 1f / scale;
		float num2 = 1f + (num - 1f) * 0.5f;
		NameBgScale = Vector3.one * num2;
	}
}
