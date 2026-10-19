using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Collections.GetArrayItem")]
[UnitCategory("Community/Collections/Arrays")]
[RenamedFrom("Lasm.BoltExtensions.GetArrayItem")]
[RenamedFrom("Lasm.UAlive.GetArrayItem")]
public sealed class GetArrayItem : Unit
{
	[Serialize]
	private int _dimensions = 1;

	[DoNotSerialize]
	public ValueInput array;

	[DoNotSerialize]
	public List<ValueInput> indexes = new List<ValueInput>();

	[DoNotSerialize]
	public ValueOutput value;

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
		array = ValueInput<Array>("array");
		for (int i = 0; i < dimensions; i++)
		{
			ValueInput item = ValueInput(i + " Index", 0);
			indexes.Add(item);
		}
		value = ValueOutput("result", GetItem);
	}

	private object GetItem(Flow flow)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < indexes.Count; i++)
		{
			list.Add(flow.GetValue<int>(indexes[i]));
		}
		return dimensions switch
		{
			1 => flow.GetValue<Array>(array).GetValue(new int[1] { list[0] }), 
			2 => flow.GetValue<Array>(array).GetValue(new int[2]
			{
				list[0],
				list[1]
			}), 
			3 => flow.GetValue<Array>(array).GetValue(new int[3]
			{
				list[0],
				list[1],
				list[2]
			}), 
			4 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3]), 
			5 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4]), 
			6 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5]), 
			7 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6]), 
			8 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7]), 
			9 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8]), 
			10 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9]), 
			11 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10]), 
			12 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11]), 
			13 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12]), 
			14 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13]), 
			15 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14]), 
			16 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15]), 
			17 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16]), 
			18 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17]), 
			19 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18]), 
			20 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19]), 
			21 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20]), 
			22 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21]), 
			23 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22]), 
			24 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23]), 
			25 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24]), 
			26 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25]), 
			27 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26]), 
			28 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27]), 
			29 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28]), 
			30 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29]), 
			31 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29], list[30]), 
			32 => flow.GetValue<Array>(array).GetValue(list[0], list[1], list[2], list[3], list[4], list[5], list[6], list[7], list[8], list[9], list[10], list[11], list[12], list[13], list[14], list[15], list[16], list[17], list[18], list[19], list[20], list[21], list[22], list[23], list[24], list[25], list[26], list[27], list[28], list[29], list[30], list[31]), 
			_ => null, 
		};
	}
}
