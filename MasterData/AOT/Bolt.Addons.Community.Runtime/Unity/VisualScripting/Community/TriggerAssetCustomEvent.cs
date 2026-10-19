using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Lasm.AssetLibrary.Nodes.TriggerAssetCustomEvent")]
[UnitCategory("Events/Community")]
[TypeIcon(typeof(EventUnit<CustomEventArgs>))]
public sealed class TriggerAssetCustomEvent : Unit
{
	[Serialize]
	private int _count;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput asset;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name;

	[DoNotSerialize]
	public List<ValueInput> args = new List<ValueInput>();

	[Inspectable]
	[InspectorLabel("Count")]
	[UnitHeaderInspectable]
	public int count
	{
		get
		{
			return _count;
		}
		set
		{
			_count = Mathf.Clamp(value, 0, 10);
		}
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow flow) =>
		{
			List<object> list = new List<object>();
			for (int i = 0; i < args.Count; i++)
			{
				list.Add(flow.GetValue<object>(args[i]));
			}
			GraphReference.New(flow.GetValue<ScriptGraphAsset>(asset), ensureValid: true).TriggerEventHandler((EventHook hook) => hook == "Custom", new CustomEventArgs(flow.GetValue<string>(name), list.ToArray()), (IGraphParentElement parent) => true, force: true);
			return exit;
		});
		asset = ValueInput<ScriptGraphAsset>("asset", null);
		name = ValueInput("name", string.Empty);
		args.Clear();
		for (int num = 0; num < count; num++)
		{
			args.Add(ValueInput<object>("arg " + num));
			Requirement(args[num], enter);
		}
		exit = ControlOutput("exit");
		Requirement(asset, enter);
		Succession(enter, exit);
	}
}
