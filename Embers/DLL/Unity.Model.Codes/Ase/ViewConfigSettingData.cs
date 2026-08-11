using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

[CreateAssetMenu(fileName = "ViewConfigSettingData", menuName = "Ase/Setting/ViewConfigSettingData")]
public class ViewConfigSettingData : SerializedScriptableObject
{
	private const int ToolOrder = -100;

	private const int DataOrder = 100;

	public Dictionary<int, ViewConfig> ViewConfigs = new Dictionary<int, ViewConfig>();
}
