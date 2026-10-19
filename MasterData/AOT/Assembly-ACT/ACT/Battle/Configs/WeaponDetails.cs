using System;
using System.Collections.Generic;

namespace ACT.Battle.Configs;

[Serializable]
public struct WeaponDetails
{
	public YooAssetReference weaponAssetAssetID;

	public int attachID;

	public WeaponStructure structure;

	public List<WeaponScale> weaponScale;
}
