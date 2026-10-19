using System;
using Lumin.LoungeSystem.UI;
using UnityEngine;

namespace Lumin.LoungeSystem;

[Serializable]
public class CharacterPointOffsetEntry
{
	[Tooltip("角色ID")]
	public int characterId;

	[Tooltip("点位ID（LoungePoint.id）")]
	public int pointId;

	[Tooltip("相对于点位的位置/旋转偏移")]
	public CharacterPointOffset offset;
}
