using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class SwitchSkillPosData
{
	public Vector3 foundPos;

	public float uncrossableOffsetX;

	public Entity target;

	public void Reset()
	{
		foundPos = Vector3.zero;
		uncrossableOffsetX = 0f;
		target = default;
	}
}
