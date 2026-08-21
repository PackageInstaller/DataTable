using Ase.ECS;

namespace Ase;

public class MarkBuff : BuffOperationBase<BuffDataMark>
{
	protected override void OnExecute()
	{
		MarkTimeType markTimeType = ((dataBase.duration != -1f) ? MarkTimeType.TimerIsLifeDuration : MarkTimeType.None);
		base.buffOwner.GetComponent<DataNodeComponent>()?.AddMark(dataBase.markId, dataBase.layer, dataBase.duration, "", markTimeType);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"MarkBuff   markId : {dataBase.markId}  layer {dataBase.layer}" + $" duration  {dataBase.duration}  markTimeType  : {markTimeType} ", base.buffOwner);
		}
	}
}
