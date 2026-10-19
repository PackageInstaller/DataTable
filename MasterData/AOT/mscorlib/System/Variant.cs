using System.Runtime.InteropServices;

namespace System;

[StructLayout(LayoutKind.Explicit)]
internal struct Variant
{
	[FieldOffset(0)]
	public short vt;

	[FieldOffset(2)]
	public ushort wReserved1;

	[FieldOffset(4)]
	public ushort wReserved2;

	[FieldOffset(6)]
	public ushort wReserved3;

	[FieldOffset(8)]
	public long llVal;

	[FieldOffset(8)]
	public int lVal;

	[FieldOffset(8)]
	public byte bVal;

	[FieldOffset(8)]
	public short iVal;

	[FieldOffset(8)]
	public float fltVal;

	[FieldOffset(8)]
	public double dblVal;

	[FieldOffset(8)]
	public short boolVal;

	[FieldOffset(8)]
	public IntPtr bstrVal;

	[FieldOffset(8)]
	public sbyte cVal;

	[FieldOffset(8)]
	public ushort uiVal;

	[FieldOffset(8)]
	public uint ulVal;

	[FieldOffset(8)]
	public ulong ullVal;

	[FieldOffset(8)]
	public int intVal;

	[FieldOffset(8)]
	public uint uintVal;

	[FieldOffset(8)]
	public IntPtr pdispVal;

	[FieldOffset(8)]
	public BRECORD bRecord;

	public void SetValue(object obj)
	{
		vt = 0;
		if (obj == null)
		{
			return;
		}
		Type type = obj.GetType();
		if (type.IsEnum)
		{
			type = Enum.GetUnderlyingType(type);
		}
		if (type == typeof(sbyte))
		{
			vt = 16;
			cVal = (sbyte)obj;
			return;
		}
		if (type == typeof(byte))
		{
			vt = 17;
			bVal = (byte)obj;
			return;
		}
		if (type == typeof(short))
		{
			vt = 2;
			iVal = (short)obj;
			return;
		}
		if (type == typeof(ushort))
		{
			vt = 18;
			uiVal = (ushort)obj;
			return;
		}
		if (type == typeof(int))
		{
			vt = 3;
			lVal = (int)obj;
			return;
		}
		if (type == typeof(uint))
		{
			vt = 19;
			ulVal = (uint)obj;
			return;
		}
		if (type == typeof(long))
		{
			vt = 20;
			llVal = (long)obj;
			return;
		}
		if (type == typeof(ulong))
		{
			vt = 21;
			ullVal = (ulong)obj;
			return;
		}
		if (type == typeof(float))
		{
			vt = 4;
			fltVal = (float)obj;
			return;
		}
		if (type == typeof(double))
		{
			vt = 5;
			dblVal = (double)obj;
			return;
		}
		if (type == typeof(string))
		{
			vt = 8;
			bstrVal = Marshal.StringToBSTR((string)obj);
			return;
		}
		if (type == typeof(bool))
		{
			vt = 11;
			lVal = (((bool)obj) ? (-1) : 0);
			return;
		}
		if (type == typeof(BStrWrapper))
		{
			vt = 8;
			bstrVal = Marshal.StringToBSTR(((BStrWrapper)obj).WrappedObject);
			return;
		}
		throw new NotImplementedException($"Variant couldn't handle object of type {obj.GetType()}");
	}

	public static object GetValueAt(int vt, IntPtr addr)
	{
		object result = null;
		switch ((VarEnum)vt)
		{
		case VarEnum.VT_I1:
			result = (sbyte)Marshal.ReadByte(addr);
			break;
		case VarEnum.VT_UI1:
			result = Marshal.ReadByte(addr);
			break;
		case VarEnum.VT_I2:
			result = Marshal.ReadInt16(addr);
			break;
		case VarEnum.VT_UI2:
			result = (ushort)Marshal.ReadInt16(addr);
			break;
		case VarEnum.VT_I4:
			result = Marshal.ReadInt32(addr);
			break;
		case VarEnum.VT_UI4:
			result = (uint)Marshal.ReadInt32(addr);
			break;
		case VarEnum.VT_I8:
			result = Marshal.ReadInt64(addr);
			break;
		case VarEnum.VT_UI8:
			result = (ulong)Marshal.ReadInt64(addr);
			break;
		case VarEnum.VT_R4:
			result = Marshal.PtrToStructure(addr, typeof(float));
			break;
		case VarEnum.VT_R8:
			result = Marshal.PtrToStructure(addr, typeof(double));
			break;
		case VarEnum.VT_BOOL:
			result = Marshal.ReadInt16(addr) != 0;
			break;
		case VarEnum.VT_BSTR:
			result = Marshal.PtrToStringBSTR(Marshal.ReadIntPtr(addr));
			break;
		}
		return result;
	}

	public object GetValue()
	{
		object result = null;
		switch ((VarEnum)vt)
		{
		case VarEnum.VT_I1:
			result = cVal;
			break;
		case VarEnum.VT_UI1:
			result = bVal;
			break;
		case VarEnum.VT_I2:
			result = iVal;
			break;
		case VarEnum.VT_UI2:
			result = uiVal;
			break;
		case VarEnum.VT_I4:
			result = lVal;
			break;
		case VarEnum.VT_UI4:
			result = ulVal;
			break;
		case VarEnum.VT_I8:
			result = llVal;
			break;
		case VarEnum.VT_UI8:
			result = ullVal;
			break;
		case VarEnum.VT_R4:
			result = fltVal;
			break;
		case VarEnum.VT_R8:
			result = dblVal;
			break;
		case VarEnum.VT_BOOL:
			result = boolVal != 0;
			break;
		case VarEnum.VT_BSTR:
			result = Marshal.PtrToStringBSTR(bstrVal);
			break;
		default:
			if ((vt & 0x4000) == 16384 && pdispVal != IntPtr.Zero)
			{
				result = GetValueAt(vt & -16385, pdispVal);
			}
			break;
		}
		return result;
	}

	public void Clear()
	{
		if (vt == 8)
		{
			Marshal.FreeBSTR(bstrVal);
		}
	}
}
