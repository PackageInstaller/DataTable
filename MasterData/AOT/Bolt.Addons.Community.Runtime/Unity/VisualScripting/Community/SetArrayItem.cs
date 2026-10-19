using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[TypeIcon(typeof(object[]))]
[RenamedFrom("Lasm.BoltExtensions.SetArrayItem")]
[RenamedFrom("Lasm.UAlive.SetArrayItem")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Collections.SetArrayItem")]
[UnitCategory("Community/Collections/Arrays")]
public class SetArrayItem : Unit
{
	[Serialize]
	private int _dimensions = 1;

	[DoNotSerialize]
	public ValueInput array;

	[DoNotSerialize]
	public List<ValueInput> indexes = new List<ValueInput>();

	[DoNotSerialize]
	public ValueInput value;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit;

	[UnitHeaderInspectable("Dimensions")]
	[Inspectable]
	public int dimensions
	{
		get
		{
			return _dimensions;
		}
		set
		{
			_dimensions = Mathf.Clamp(value, 1, 32);
		}
	}

	protected override void Definition()
	{
		indexes.Clear();
		enter = ControlInput("enter", SetItem);
		array = ValueInput<Array>("array");
		for (int i = 0; i < dimensions; i++)
		{
			ValueInput item = ValueInput(i + " Index", 0);
			indexes.Add(item);
		}
		value = ValueInput<object>("value");
		exit = ControlOutput("exit");
		Succession(enter, exit);
		for (int j = 0; j < indexes.Count; j++)
		{
			Requirement(indexes[j], enter);
		}
	}

	private ControlOutput SetItem(Flow flow)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < indexes.Count; i++)
		{
			list.Add(flow.GetValue<int>(indexes[i]));
		}
		switch (_dimensions)
		{
		case 1:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), new int[1] { list[0] });
			break;
		case 2:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), new int[2]
			{
				list[0],
				list[1]
			});
			break;
		case 3:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), new int[3]
			{
				list[0],
				list[1],
				list[2]
			});
			break;
		case 4:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3]);
			break;
		case 5:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4]);
			break;
		case 6:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5]);
			break;
		case 7:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6]);
			break;
		case 8:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7]);
			break;
		case 9:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8]);
			break;
		case 10:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9]);
			break;
		case 11:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10]);
			break;
		case 12:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11]);
			break;
		case 13:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12]);
			break;
		case 14:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13]);
			break;
		case 15:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14]);
			break;
		case 16:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15]);
			break;
		case 17:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16]);
			break;
		case 18:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17]);
			break;
		case 19:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18]);
			break;
		case 20:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19]);
			break;
		case 21:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20]);
			break;
		case 22:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21]);
			break;
		case 23:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22]);
			break;
		case 24:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23]);
			break;
		case 25:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24]);
			break;
		case 26:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25]);
			break;
		case 27:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26]);
			break;
		case 28:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27]);
			break;
		case 29:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28]);
			break;
		case 30:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29]);
			break;
		case 31:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29], list[30]);
			break;
		case 32:
			flow.GetValue<Array>(array).SetValue(flow.GetValue<object>(value), list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29], list[30], list[31]);
			break;
		}
		return exit;
	}
}
