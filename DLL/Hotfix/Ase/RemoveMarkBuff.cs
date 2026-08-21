using Ase.ECS;

namespace Ase;

public class RemoveMarkBuff : BuffOperationBase<BuffDataMark>
{
	protected override void OnExecute()
	{
		_ = dataBase.duration;
		_ = -1f;
		base.buffOwner.GetComponent<DataNodeComponent>()?.RemoveMarkLayer(dataBase.markId, dataBase.layer);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"RemoveMarkBuff   markId : {dataBase.markId}  layer {dataBase.layer}", base.buffOwner);
		}
	}
}
