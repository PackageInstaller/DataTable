#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class StateBuff : BuffOperationBase<BuffDataState>
{
	protected override void OnExecute()
	{
		switch (dataBase.changeType)
		{
		case ChangeType.Add:
			base.buffOwner.GetComponent<StateComponent>().AddState(dataBase.stateId, base.buffFrom.Id);
			break;
		case ChangeType.Dec:
			base.buffOwner.GetComponent<StateComponent>().RemoveState(dataBase.stateId);
			break;
		default:
			Log.Error($"状态Buff,修改类型{dataBase.changeType}无效！");
			Toast.ShowError($"状态Buff,修改类型{dataBase.changeType}无效！");
			break;
		}
	}

	protected override void OnDispose()
	{
		switch (dataBase.changeType)
		{
		case ChangeType.Add:
			base.buffOwner.GetComponent<StateComponent>().RemoveState(dataBase.stateId);
			break;
		case ChangeType.Dec:
			Log.Error("状态Buff,ChangeType Dec 无法清理Buff效果！");
			Toast.ShowError("状态Buff,ChangeType Dec 无法清理Buff效果！");
			break;
		}
	}
}
