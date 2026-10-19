using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.GetMachinesUnit")]
[UnitCategory("Community/Graphs")]
[UnitTitle("Get Machines")]
[TypeIcon(typeof(ScriptMachine))]
public sealed class GetMachinesNode : Unit
{
	[DoNotSerialize]
	[NullMeansSelf]
	[PortLabelHidden]
	public ValueInput target;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput asset;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput machines;

	protected override void Definition()
	{
		target = ValueInput<GameObject>("target", null);
		target.NullMeansSelf();
		asset = ValueInput<ScriptGraphAsset>("asset", null);
		machines = ValueOutput("machine", (Flow flow) =>
		{
			ScriptMachine[] components = flow.GetValue<GameObject>(target).GetComponents<ScriptMachine>();
			List<ScriptMachine> list = new List<ScriptMachine>();
			for (int i = 0; i < components.Length; i++)
			{
				if (components[i].nest.macro == flow.GetValue<ScriptGraphAsset>(asset))
				{
					list.Add(components[i]);
				}
			}
			return list.ToArrayPooled();
		});
	}
}
