using System;
using UnityEngine;

namespace Ase;

[Serializable]
public struct TalentLamp
{
	public int minLevel;

	public int maxLevel;

	public string imageName;

	public GameObject animationGo;
}
