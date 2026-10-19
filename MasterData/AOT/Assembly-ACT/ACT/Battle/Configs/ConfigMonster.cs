using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
public class ConfigMonster : MonoBehaviour
{
	public string _monsterName;

	public int monsterPointId;

	public int monsterLevel;

	public List<Transform> transformPoint = new List<Transform>();
}
