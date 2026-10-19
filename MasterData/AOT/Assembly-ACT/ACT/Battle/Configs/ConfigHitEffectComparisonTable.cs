using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class ConfigHitEffectComparisonTable : LuminSerializedScriptableObject
{
	public Dictionary<HitMaterialEffectSheet, Dictionary<HitMaterial, YooAssetReference>> tableAssetID = new Dictionary<HitMaterialEffectSheet, Dictionary<HitMaterial, YooAssetReference>>();
}
