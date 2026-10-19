using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community/Collections/Arrays")]
[TypeIcon(typeof(object[]))]
[RenamedFrom("Lasm.BoltExtensions.CreateArray")]
[RenamedFrom("Lasm.BoltExtensions.CreateMultiArray")]
[RenamedFrom("Lasm.UAlive.CreateMultiArray")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Collections.CreateMultiArray")]
public sealed class CreateArray : Unit
{
	[Serialize]
	private int _dimensions = 2;

	[Serialize]
	[Inspectable]
	[UnitHeaderInspectable("Type")]
	public Type type;

	[DoNotSerialize]
	public List<ValueInput> indexes = new List<ValueInput>();

	[DoNotSerialize]
	[RenamedFrom("Lasm.BoltExtensions.CreateMultiArray.list")]
	public ValueOutput result;

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
		for (int i = 0; i < dimensions; i++)
		{
			ValueInput item = ValueInput(i + " Length", 0);
			indexes.Add(item);
		}
		result = ValueOutput("array", Create);
	}

	private Array Create(Flow flow)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < indexes.Count; i++)
		{
			list.Add(flow.GetValue<int>(indexes[i]));
		}
		return MakeArrayType(dimensions, list);
	}

	public Array MakeArrayType(int dimensions, List<int> lengths)
	{
		return dimensions switch
		{
			1 => Array.CreateInstance(type, new int[1] { lengths[0] }), 
			2 => Array.CreateInstance(type, new int[2]
			{
				lengths[0],
				lengths[1]
			}), 
			3 => Array.CreateInstance(type, new int[3]
			{
				lengths[0],
				lengths[1],
				lengths[2]
			}), 
			4 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3]), 
			5 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4]), 
			6 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5]), 
			7 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6]), 
			8 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7]), 
			9 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8]), 
			10 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9]), 
			11 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10]), 
			12 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11]), 
			13 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12]), 
			14 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13]), 
			15 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14]), 
			16 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15]), 
			17 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16]), 
			18 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17]), 
			19 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18]), 
			20 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19]), 
			21 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20]), 
			22 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21]), 
			23 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22]), 
			24 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23]), 
			25 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24]), 
			26 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25]), 
			27 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26]), 
			28 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26], lengths[27]), 
			29 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26], lengths[27], lengths[28]), 
			30 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26], lengths[27], lengths[28], lengths[29]), 
			31 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26], lengths[27], lengths[28], lengths[29], lengths[30]), 
			32 => Array.CreateInstance(type, lengths[0], lengths[1], lengths[2], lengths[3], lengths[4], lengths[5], lengths[6], lengths[7], lengths[8], lengths[9], lengths[10], lengths[11], lengths[12], lengths[13], lengths[14], lengths[15], lengths[16], lengths[17], lengths[18], lengths[19], lengths[20], lengths[21], lengths[22], lengths[23], lengths[24], lengths[25], lengths[26], lengths[27], lengths[28], lengths[29], lengths[30], lengths[31]), 
			_ => null, 
		};
	}
}
