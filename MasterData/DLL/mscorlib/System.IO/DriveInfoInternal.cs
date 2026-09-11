using System.Runtime.CompilerServices;

namespace System.IO;

internal static class DriveInfoInternal
{
	public static string[] GetLogicalDrives()
	{
		//IL_004d: Field data (rva=0x590) could not be found in any section!
		//IL_004d: Field data (rva=0x590) could not be found in any section!
		//IL_004d: Field data (rva=0x590) could not be found in any section!
		//IL_004d: Field data (rva=0x590) could not be found in any section!
		int num = 0;
		try
		{
			num = Interop.Kernel32.GetLogicalDrives();
		}
		catch (DllNotFoundException)
		{
			throw new InvalidOperationException("GetLogicalDrives is not supported using this version of the Windows SDK. Use SDK versions greater than 16299.");
		}
		if (num == 0)
		{
			throw Win32Marshal.GetExceptionForLastWin32Error();
		}
		uint num2 = (uint)num;
		int num3 = 0;
		while (num2 != 0)
		{
			if ((num2 & 1) != 0)
			{
				num3++;
			}
			num2 >>= 1;
		}
		string[] array = new string[num3];
		char[] array2 = new char[3];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		char[] array3 = array2;
		num2 = (uint)num;
		num3 = 0;
		while (num2 != 0)
		{
			if ((num2 & 1) != 0)
			{
				array[num3++] = new string(array3);
			}
			num2 >>= 1;
			array3[0] += '\u0001';
		}
		return array;
	}
}
