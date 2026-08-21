using System.Runtime.InteropServices;

namespace CriLipsToolUtility;

public static class CriAdxlipParser
{
	public enum FormatVersion
	{
		V1_0,
		V2_0
	}

	public static class FormatV1
	{
		public static bool ParseByFormat(byte[] data, out FrameData result)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV1_ParseByFormat(data, out result);
		}

		public static bool GenerateEmptyHeaderLines(byte[] data, int data_length)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV1_GenerateEmptyHeaderLines(data, data_length);
		}

		public static bool GenerateLine(byte[] data, int data_length, ref FrameData result)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV1_GenerateLine(data, data_length, ref result);
		}
	}

	public static class FormatV2
	{
		public static bool ParseByFormat(byte[] data, out FrameData result)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV2_ParseByFormat(data, out result);
		}

		public static bool GenerateEmptyHeaderLines(byte[] data, int data_length)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV2_GenerateEmptyHeaderLines(data, data_length);
		}

		public static bool GenerateLine(byte[] data, int data_length, ref FrameData result)
		{
			return SafeNativeMethods.criAdxlipParser_FormatV2_GenerateLine(data, data_length, ref result);
		}
	}

	internal static class SafeNativeMethods
	{
		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern FormatVersion criAdxlipParser_GetFormatVersion([In] byte[] data);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern int criAdxlipParser_GetNumResults([In] byte[] data);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_Parse([In] byte[] data, [Out] FrameData[] result, int num_result);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV1_ParseByFormat([In] byte[] line, out FrameData result);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV1_GenerateEmptyHeaderLines([Out] byte[] lines, int lines_length);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV1_GenerateLine([Out] byte[] lines, int lines_length, [In] ref FrameData result);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV2_ParseByFormat([In] byte[] line, out FrameData result);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV2_GenerateEmptyHeaderLines([Out] byte[] lines, int lines_length);

		[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
		public static extern bool criAdxlipParser_FormatV2_GenerateLine([Out] byte[] lines, int lines_length, [In] ref FrameData result);
	}

	public struct FrameData
	{
		public uint frame_count;

		public uint msec;

		public float width;

		public float height;

		public float tongue;

		public float a;

		public float i;

		public float u;

		public float e;

		public float o;

		public float vol;
	}

	public static FormatVersion GetFormatVersion(byte[] data)
	{
		return SafeNativeMethods.criAdxlipParser_GetFormatVersion(data);
	}

	public static int GetNumResults(byte[] data)
	{
		return SafeNativeMethods.criAdxlipParser_GetNumResults(data);
	}

	public static bool Parse(byte[] data, FrameData[] result, int num_result)
	{
		return SafeNativeMethods.criAdxlipParser_Parse(data, result, num_result);
	}
}
