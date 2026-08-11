using UnityEngine;

namespace Ase;

[Trigger("修改机关开关触发器")]
public class SwitchMechanismTrigger : BaseTrigger
{
	public MechanismNode[] MechanismNodes;

	public override string TriggerName => "修改机关开关触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (MechanismNodes == null)
		{
			return;
		}
		MechanismNode[] mechanismNodes = MechanismNodes;
		foreach (MechanismNode mechanismNode in mechanismNodes)
		{
			if ((Object)(object)mechanismNode != null)
			{
				mechanismNode.SwitchMechanism();
			}
		}
	}
}
