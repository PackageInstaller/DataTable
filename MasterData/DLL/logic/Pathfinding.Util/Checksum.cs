using System;
using System.Runtime.CompilerServices;

namespace Pathfinding.Util;

public class Checksum
{
	private static readonly uint[] CRCTable;

	public static uint GetChecksum(byte[] Value)
	{
		uint cRCVal = uint.MaxValue;
		return GetChecksum(Value, cRCVal);
	}

	public static uint GetChecksum(byte[] Value, uint CRCVal)
	{
		for (int i = 0; i < Value.Length; i++)
		{
			CRCVal = (CRCVal >> 8) ^ CRCTable[(CRCVal & 0xFF) ^ Value[i]];
		}
		return CRCVal;
	}

	static Checksum()
	{
		//IL_0010: Field data (rva=0x490) could not be found in any section!
		//IL_0010: Field data (rva=0x490) could not be found in any section!
		uint[] array = new uint[256];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		CRCTable = array;
	}
}
