using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigGlobalSpeed : ScriptableObject
{
	public SystemTime.ConfigChangeGlobalSpeed superArmorConfig;

	public List<HitGlobalSpeed> configs;
}
