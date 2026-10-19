using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public struct WeaponPartAttach
{
	public Transform weaponPos;

	public int attachID;

	public Transform[] bones;

	public WeaponStruc type;
}
