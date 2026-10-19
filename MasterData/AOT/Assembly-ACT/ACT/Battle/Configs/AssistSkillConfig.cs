using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class AssistSkillConfig
{
	public string motionName;

	public float CD;

	public Vector2 positionOffset;

	public bool setGround;
}
