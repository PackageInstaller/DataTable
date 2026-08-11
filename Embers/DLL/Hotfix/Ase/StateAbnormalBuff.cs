#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class StateAbnormalBuff : BuffOperationBase<BuffDataStateAbnormal>
{
	protected override void OnExecute()
	{
		switch (dataBase.changeType)
		{
		case ChangeType.Add:
			if (base.buffFrom != null)
			{
				base.buffOwner.GetComponent<AbnormalStateComponent>()?.AddAbnormalState(dataBase.stateId, base.buffFrom.Id, dataBase.progress);
			}
			break;
		case ChangeType.Dec:
			base.buffOwner.GetComponent<AbnormalStateComponent>()?.RemoveAbnormalState(dataBase.stateId);
			break;
		default:
			Toast.ShowError($"异常状态Buff,修改类型{dataBase.changeType}无效！");
			break;
		}
	}

	protected override void OnDispose()
	{
		switch (dataBase.changeType)
		{
		case ChangeType.Add:
			base.buffOwner.GetComponent<AbnormalStateComponent>()?.RemoveAbnormalState(dataBase.stateId);
			break;
		case ChangeType.Dec:
			Log.Error("异常状态Buff, ChangeType Dec 无法清理Buff效果！");
			Toast.ShowError("异常状态Buff, ChangeType Dec 无法清理Buff效果！");
			break;
		}
	}
}
