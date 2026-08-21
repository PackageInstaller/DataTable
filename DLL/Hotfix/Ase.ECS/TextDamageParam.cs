using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class TextDamageParam : IReference
{
	public string showContent;

	public bool HitDownOrBreak;

	public int WeaknessLevel;

	public int maxSiteLevel;

	public Vector3 OffsetPos;

	public void Clear()
	{
		showContent = string.Empty;
		HitDownOrBreak = false;
		WeaknessLevel = 0;
		maxSiteLevel = 0;
		OffsetPos = Vector3.zero;
	}
}
