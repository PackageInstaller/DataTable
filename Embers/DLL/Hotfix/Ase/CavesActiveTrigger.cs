using UnityEngine;

namespace Ase;

[Trigger("激活洞窟入口")]
public class CavesActiveTrigger : BaseTrigger
{
	public int CavesId;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	public override string TriggerName => "洞窟入口按钮状态触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem != null)
		{
			int levelId = sceneSystem.GetLevelId();
			if (IsSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ActiveCaves(levelId, CavesId);
			}
			if (IsSaveData && IsSaveLevelData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
			}
		}
	}
}
