using UnityEngine;

namespace Ase;

[Trigger("新手引导触发器")]
public class TeachGuideTrigger : BaseTrigger
{
	[SerializeField]
	private int teachGuideId;

	public override string TriggerName => "新手引导触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		sceneSystem.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(teachGuideId, delayShow: false);
	}
}
