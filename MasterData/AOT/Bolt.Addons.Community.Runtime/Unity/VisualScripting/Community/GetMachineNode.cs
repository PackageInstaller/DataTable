using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitTitle("Get Machine")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.GetMachineUnit")]
[UnitCategory("Community/Graphs")]
[TypeIcon(typeof(ScriptMachine))]
public sealed class GetMachineNode : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput target;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput asset;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput machine;

	protected override void Definition()
	{
		target = ValueInput<GameObject>("target", null);
		target.NullMeansSelf();
		asset = ValueInput<ScriptGraphAsset>("asset", null);
		machine = ValueOutput("machine", (Flow flow) =>
		{
			ScriptMachine[] components = flow.GetValue<GameObject>(target).GetComponents<ScriptMachine>();
			ScriptMachine result = null;
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].nest.macro == flow.GetValue<ScriptGraphAsset>(asset))
				{
					return components[i];
				}
			}
			return result;
		});
	}
}
