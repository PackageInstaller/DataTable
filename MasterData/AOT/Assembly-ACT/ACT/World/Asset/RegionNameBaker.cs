using UnityEngine;

namespace ACT.World.Asset;

public class RegionNameBaker : MonoDataBaker
{
	[SerializeField]
	public DataBaker<RegionNameData> dataBaker = new DataBaker<RegionNameData>();

	public override IDataBaker Baker => dataBaker;
}
