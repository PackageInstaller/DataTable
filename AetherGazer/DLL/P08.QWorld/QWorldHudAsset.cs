using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "QworldHudAsset.asset", menuName = "箱庭/Hud/创建配置文件")]
public class QWorldHudAsset : ScriptableObject
{
	[SerializeField]
	private List<QWorldHudConfig> hudConfig;

	private Dictionary<QWorldHudType, int> cfgMap;

	public void Init()
	{
		cfgMap = new Dictionary<QWorldHudType, int>();
		for (int i = 0; i < hudConfig.Count; i++)
		{
			cfgMap.Add(hudConfig[i].hudType, i);
		}
	}

	public QWorldHudConfig GetConfig(QWorldHudType type)
	{
		return hudConfig[cfgMap[type]];
	}
}
