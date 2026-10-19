using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAnimLayer
{
	public string name;

	public bool isAdditive;

	public AvatarMask avatarMask;

	public string defaultMachine;
}
