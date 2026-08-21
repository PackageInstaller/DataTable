using Ase;
using UnityEngine;

public class BuffBulletRuntimeData : BuffRuntimeDataBase
{
	public int bulletConfigId;

	public int skillConfigId;

	public Vector3 bulletPos;

	public HitColliderVariableData variableData;

	public HitVolume hitVolume;

	public override BuffRuntimeDataBase Copy()
	{
		return new BuffBulletRuntimeData
		{
			bulletConfigId = bulletConfigId,
			skillConfigId = skillConfigId,
			bulletPos = bulletPos,
			variableData = variableData,
			hitVolume = hitVolume
		};
	}

	public override void Clear()
	{
		variableData = null;
		hitVolume = null;
	}
}
