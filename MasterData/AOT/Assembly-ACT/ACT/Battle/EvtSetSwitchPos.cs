using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class EvtSetSwitchPos : BaseEvt
{
	public Entity beforeEntity;

	public Vector3 configPos;

	public SwitchSkillPosData data;

	public override void Reset()
	{
		beforeEntity = default;
	}
}
