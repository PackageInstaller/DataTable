using UnityEngine;

namespace Ase;

[Trigger("交互物2修改机关开关")]
public class MapItem2SwitchMechanismEventTrigger : MapItemEventTrigger
{
	public MechanismNode[] MechanismNodes;

	public override string TriggerName => "交互物-修改机关开关";

	protected override async void DoExecute()
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
