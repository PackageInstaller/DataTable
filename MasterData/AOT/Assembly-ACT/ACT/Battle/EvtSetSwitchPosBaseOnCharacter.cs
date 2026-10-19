using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class EvtSetSwitchPosBaseOnCharacter : BaseEvt
{
	public Entity beforeEntity;

	public Vector3 configPos;

	public Entity target;

	public override void Reset()
	{
		beforeEntity = default;
		target = default;
	}
}
