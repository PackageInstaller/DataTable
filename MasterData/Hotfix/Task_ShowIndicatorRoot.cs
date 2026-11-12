using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/关闭指示器节点", 0)]
public class Task_ShowIndicatorRoot : TaskCellBase
{
	public bool isShow = true;

	protected override void OnExecute()
	{
		SceneSingleton<AdventureIndicatorController>.Instance?.ShowBlobIndicatorsRootNode(isShow);
		EndAction();
	}
}
