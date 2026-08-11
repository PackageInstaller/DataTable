using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase;

[Name("改变移动平台暂停", 0)]
[Description("根据指定的移动平台ID改变其暂停状态。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeMovingPlatformPause : ActionTaskBase
{
	[Name("是否暂停", 0)]
	[Description("指定移动平台是否应该暂停。")]
	public BBParameter<bool> isPause;

	[Name("移动平台ID", 0)]
	[Description("要修改暂停状态的移动平台的ID。")]
	public BBParameter<int> movPlatformId;

	protected override void OnExecute()
	{
		base.OnExecute();
		SceneSystem system = GetOwnerEntity().GetSystem<SceneSystem>();
		if (system != null)
		{
			LevelMapData levelMapData = system.GetLevelMapData();
			if ((Object)(object)levelMapData != null)
			{
				levelMapData.SetMovingPaltformPauseById(movPlatformId.value, isPause.value);
			}
		}
		OnActionFinish();
	}
}
