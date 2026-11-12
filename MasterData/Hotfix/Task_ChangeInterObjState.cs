using UnityEngine;

[AddComponentMenu("触发器结果/物件事件/设置交互物激活状态", 1)]
public class Task_ChangeInterObjState : TaskCellBase
{
	public string id;

	public string groupTag;

	public InteractiveManager.processState _activeState;

	public bool forceFinish;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(id) && string.IsNullOrEmpty(groupTag))
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		if (!string.IsNullOrEmpty(id))
		{
			Singleton<InteractiveManager>.Instance.setInteractiveObjActiveState(id, _activeState, () =>
			{
				EndAction();
			});
		}
		if (!string.IsNullOrEmpty(groupTag))
		{
			Singleton<InteractiveManager>.Instance.setInteractiveInterActiveByGroup(groupTag, _activeState);
			EndAction();
		}
		if (forceFinish)
		{
			EndAction();
		}
	}
}
