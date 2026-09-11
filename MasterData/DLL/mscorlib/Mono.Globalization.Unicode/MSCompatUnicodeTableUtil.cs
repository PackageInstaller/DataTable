using System;
using System.Runtime.CompilerServices;

namespace Mono.Globalization.Unicode;

internal class MSCompatUnicodeTableUtil
{
	public static readonly CodePointIndexer Ignorable;

	public static readonly CodePointIndexer Category;

	public static readonly CodePointIndexer Level1;

	public static readonly CodePointIndexer Level2;

	public static readonly CodePointIndexer Level3;

	public static readonly CodePointIndexer CjkCHS;

	public static readonly CodePointIndexer Cjk;

	static MSCompatUnicodeTableUtil()
	{
		//IL_00cb: Field data (rva=0x670) could not be found in any section!
		//IL_00cb: Field data (rva=0x670) could not be found in any section!
		//IL_0023: Field data (rva=0x580) could not be found in any section!
		//IL_0023: Field data (rva=0x580) could not be found in any section!
		int[] starts = new int[3] { 0, 40960, 63744 };
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		int[] ends = array;
		int[] starts2 = new int[6] { 10, 18864, 7, 1, 30, 42168 };
		int[] ends2 = new int[6] { 171, 118, 202, 130, 201, 125 };
		int[] starts3 = new int[6] { 10, 18864, 7, 1, 30, 42168 };
		int[] ends3 = new int[6] { 171, 118, 202, 130, 201, 125 };
		int[] starts4 = new int[4] { 919, 929, 937, 941 };
		int[] ends4 = new int[4] { 7733248, 5963776, 10616832, 4784128 };
		int[] starts5 = new int[4] { 919, 929, 937, 941 };
		int[] ends5 = new int[4] { 14336, 62720, 48128, 46592 };
		int[] array2 = new int[3];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		int[] starts6 = array2;
		int[] ends6 = new int[3] { 5851, 5857, 5861 };
		int[] starts7 = new int[3] { -64976, -1, -1 };
		int[] ends7 = new int[3] { 103, 43, 254 };
		Ignorable = new CodePointIndexer(starts, ends, -1, -1);
		Category = new CodePointIndexer(starts2, ends2, 0, 0);
		Level1 = new CodePointIndexer(starts3, ends3, 0, 0);
		Level2 = new CodePointIndexer(starts4, ends4, 0, 0);
		Level3 = new CodePointIndexer(starts5, ends5, 0, 0);
		CjkCHS = new CodePointIndexer(starts6, ends6, -1, -1);
		Cjk = new CodePointIndexer(starts7, ends7, -1, -1);
	}
}
