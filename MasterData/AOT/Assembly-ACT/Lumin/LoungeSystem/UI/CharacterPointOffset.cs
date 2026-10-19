using System;
using UnityEngine;

namespace Lumin.LoungeSystem.UI;

[Serializable]
public struct CharacterPointOffset
{
	[Tooltip("相对于点位的局部位置偏移")]
	public Vector3 positionOffset;

	[Tooltip("相对于点位的局部旋转偏移（欧拉角）")]
	public Vector3 rotationOffset;

	public static readonly CharacterPointOffset Zero = new CharacterPointOffset
	{
		positionOffset = Vector3.zero,
		rotationOffset = Vector3.zero
	};
}
