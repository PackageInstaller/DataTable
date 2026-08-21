#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class StateAbnormalTimeBuff : BuffOperationBase<BuffDataStateAbnormalTime>
{
	protected override void OnExecute()
	{
		switch (dataBase.changeType)
		{
		case ChangeType.Add:
			base.buffOwner.GetComponent<AbnormalStateComponent>()?.AddAbnormalStateDuration(dataBase.stateId, dataBase.time);
			break;
		case ChangeType.Dec:
			base.buffOwner.GetComponent<AbnormalStateComponent>()?.AddAbnormalStateDuration(dataBase.stateId, 0f - dataBase.time);
			break;
		case ChangeType.Set:
			base.buffOwner.GetComponent<AbnormalStateComponent>()?.SetAbnormalStateDuration(dataBase.stateId, dataBase.time);
			break;
		default:
			Log.Error($"异常状态Buff,修改类型{dataBase.changeType}无效！");
			Toast.ShowError($"异常状态Buff,修改类型{dataBase.changeType}无效！");
			break;
		}
	}

	protected override void OnDispose()
	{
		Log.Error("Buff 5011 无法结束时清除效果");
	}
}
