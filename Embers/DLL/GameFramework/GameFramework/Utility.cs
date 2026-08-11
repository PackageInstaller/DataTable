using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Internal;

namespace GameFramework;

public static class Utility
{
	public static class Assembly
	{
		private static readonly System.Reflection.Assembly[] s_Assemblies;

		private static readonly Dictionary<string, Type> s_CachedTypes;

		static Assembly()
		{
			s_Assemblies = null;
			s_CachedTypes = new Dictionary<string, Type>();
			s_Assemblies = AppDomain.CurrentDomain.GetAssemblies();
		}

		public static System.Reflection.Assembly[] GetAssemblies()
		{
			return s_Assemblies;
		}

		public static Type[] GetTypes()
		{
			List<Type> list = new List<Type>();
			System.Reflection.Assembly[] array = s_Assemblies;
			foreach (System.Reflection.Assembly assembly in array)
			{
				list.AddRange(assembly.GetTypes());
			}
			return list.ToArray();
		}

		public static void GetTypes(List<Type> results)
		{
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			System.Reflection.Assembly[] array = s_Assemblies;
			foreach (System.Reflection.Assembly assembly in array)
			{
				results.AddRange(assembly.GetTypes());
			}
		}

		public static Type GetType(string typeName)
		{
			if (string.IsNullOrEmpty(typeName))
			{
				throw new GameFrameworkException("Type name is invalid.");
			}
			Type value = null;
			if (s_CachedTypes.TryGetValue(typeName, out value))
			{
				return value;
			}
			value = Type.GetType(typeName);
			if (value != null)
			{
				s_CachedTypes.Add(typeName, value);
				return value;
			}
			System.Reflection.Assembly[] array = s_Assemblies;
			foreach (System.Reflection.Assembly assembly in array)
			{
				value = Type.GetType(Text.Format("{0}, {1}", typeName, assembly.FullName));
				if (value != null)
				{
					s_CachedTypes.Add(typeName, value);
					return value;
				}
			}
			return null;
		}

		public static Dictionary<string, Type> GetAssemblyTypes()
		{
			Dictionary<string, Type> dictionary = new Dictionary<string, Type>();
			System.Reflection.Assembly[] array = s_Assemblies;
			foreach (System.Reflection.Assembly assembly in array)
			{
				Type[] types = assembly.GetTypes();
				foreach (Type type in types)
				{
					if (type.FullName != null)
					{
						dictionary[type.FullName] = type;
					}
				}
			}
			return dictionary;
		}

		public static Dictionary<string, Type> GetAssemblyTypes(params System.Reflection.Assembly[] args)
		{
			Dictionary<string, Type> dictionary = new Dictionary<string, Type>();
			foreach (System.Reflection.Assembly assembly in args)
			{
				Type[] types = assembly.GetTypes();
				foreach (Type type in types)
				{
					if (type.FullName != null)
					{
						dictionary[type.FullName] = type;
					}
				}
			}
			return dictionary;
		}
	}

	public static class Compression
	{
		public interface ICompressionHelper
		{
			bool Compress(byte[] bytes, int offset, int length, Stream compressedStream);

			bool Compress(Stream stream, Stream compressedStream);

			bool Decompress(byte[] bytes, int offset, int length, Stream decompressedStream);

			bool Decompress(Stream stream, Stream decompressedStream);
		}

		private static ICompressionHelper s_CompressionHelper;

		public static void SetCompressionHelper(ICompressionHelper compressionHelper)
		{
			s_CompressionHelper = compressionHelper;
		}

		public static byte[] Compress(byte[] bytes)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Compress(bytes, 0, bytes.Length);
		}

		public static bool Compress(byte[] bytes, Stream compressedStream)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Compress(bytes, 0, bytes.Length, compressedStream);
		}

		public static byte[] Compress(byte[] bytes, int offset, int length)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Compress(bytes, offset, length, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Compress(byte[] bytes, int offset, int length, Stream compressedStream)
		{
			if (s_CompressionHelper == null)
			{
				throw new GameFrameworkException("Compressed helper is invalid.");
			}
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			if (offset < 0 || length < 0 || offset + length > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			if (compressedStream == null)
			{
				throw new GameFrameworkException("Compressed stream is invalid.");
			}
			try
			{
				return s_CompressionHelper.Compress(bytes, offset, length, compressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not compress with exception '{0}'.", ex), ex);
			}
		}

		public static byte[] Compress(Stream stream)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Compress(stream, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Compress(Stream stream, Stream compressedStream)
		{
			if (s_CompressionHelper == null)
			{
				throw new GameFrameworkException("Compressed helper is invalid.");
			}
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			if (compressedStream == null)
			{
				throw new GameFrameworkException("Compressed stream is invalid.");
			}
			try
			{
				return s_CompressionHelper.Compress(stream, compressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not compress with exception '{0}'.", ex), ex);
			}
		}

		public static byte[] Decompress(byte[] bytes)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Decompress(bytes, 0, bytes.Length);
		}

		public static bool Decompress(byte[] bytes, Stream decompressedStream)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Decompress(bytes, 0, bytes.Length, decompressedStream);
		}

		public static byte[] Decompress(byte[] bytes, int offset, int length)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Decompress(bytes, offset, length, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Decompress(byte[] bytes, int offset, int length, Stream decompressedStream)
		{
			if (s_CompressionHelper == null)
			{
				throw new GameFrameworkException("Compressed helper is invalid.");
			}
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			if (offset < 0 || length < 0 || offset + length > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			if (decompressedStream == null)
			{
				throw new GameFrameworkException("Decompressed stream is invalid.");
			}
			try
			{
				return s_CompressionHelper.Decompress(bytes, offset, length, decompressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not decompress with exception '{0}'.", ex), ex);
			}
		}

		public static byte[] Decompress(Stream stream)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Decompress(stream, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Decompress(Stream stream, Stream decompressedStream)
		{
			if (s_CompressionHelper == null)
			{
				throw new GameFrameworkException("Compressed helper is invalid.");
			}
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			if (decompressedStream == null)
			{
				throw new GameFrameworkException("Decompressed stream is invalid.");
			}
			try
			{
				return s_CompressionHelper.Decompress(stream, decompressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not decompress with exception '{0}'.", ex), ex);
			}
		}
	}

	public static class Converter
	{
		private const float InchesToCentimeters = 2.54f;

		private const float CentimetersToInches = 0.39370078f;

		public static bool IsLittleEndian => BitConverter.IsLittleEndian;

		public static float ScreenDpi { get; set; }

		public static float GetCentimetersFromPixels(float pixels)
		{
			if (ScreenDpi <= 0f)
			{
				throw new GameFrameworkException("You must set screen DPI first.");
			}
			return 2.54f * pixels / ScreenDpi;
		}

		public static float GetPixelsFromCentimeters(float centimeters)
		{
			if (ScreenDpi <= 0f)
			{
				throw new GameFrameworkException("You must set screen DPI first.");
			}
			return 0.39370078f * centimeters * ScreenDpi;
		}

		public static float GetInchesFromPixels(float pixels)
		{
			if (ScreenDpi <= 0f)
			{
				throw new GameFrameworkException("You must set screen DPI first.");
			}
			return pixels / ScreenDpi;
		}

		public static float GetPixelsFromInches(float inches)
		{
			if (ScreenDpi <= 0f)
			{
				throw new GameFrameworkException("You must set screen DPI first.");
			}
			return inches * ScreenDpi;
		}

		public static byte[] GetBytes(bool value)
		{
			byte[] array = new byte[1];
			GetBytes(value, array, 0);
			return array;
		}

		public static void GetBytes(bool value, byte[] buffer)
		{
			GetBytes(value, buffer, 0);
		}

		public static void GetBytes(bool value, byte[] buffer, int startIndex)
		{
			if (buffer == null)
			{
				throw new GameFrameworkException("Buffer is invalid.");
			}
			if (startIndex < 0 || startIndex + 1 > buffer.Length)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			buffer[startIndex] = (byte)(value ? 1 : 0);
		}

		public static bool GetBoolean(byte[] value)
		{
			return BitConverter.ToBoolean(value, 0);
		}

		public static bool GetBoolean(byte[] value, int startIndex)
		{
			return BitConverter.ToBoolean(value, startIndex);
		}

		public static byte[] GetBytes(char value)
		{
			byte[] array = new byte[2];
			GetBytes((short)value, array, 0);
			return array;
		}

		public static void GetBytes(char value, byte[] buffer)
		{
			GetBytes((short)value, buffer, 0);
		}

		public static void GetBytes(char value, byte[] buffer, int startIndex)
		{
			GetBytes((short)value, buffer, startIndex);
		}

		public static char GetChar(byte[] value)
		{
			return BitConverter.ToChar(value, 0);
		}

		public static char GetChar(byte[] value, int startIndex)
		{
			return BitConverter.ToChar(value, startIndex);
		}

		public static byte[] GetBytes(short value)
		{
			byte[] array = new byte[2];
			GetBytes(value, array, 0);
			return array;
		}

		public static void GetBytes(short value, byte[] buffer)
		{
			GetBytes(value, buffer, 0);
		}

		public unsafe static void GetBytes(short value, byte[] buffer, int startIndex)
		{
			if (buffer == null)
			{
				throw new GameFrameworkException("Buffer is invalid.");
			}
			if (startIndex < 0 || startIndex + 2 > buffer.Length)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			fixed (byte* ptr = buffer)
			{
				*(short*)(ptr + startIndex) = value;
			}
		}

		public static short GetInt16(byte[] value)
		{
			return BitConverter.ToInt16(value, 0);
		}

		public static short GetInt16(byte[] value, int startIndex)
		{
			return BitConverter.ToInt16(value, startIndex);
		}

		public static byte[] GetBytes(ushort value)
		{
			byte[] array = new byte[2];
			GetBytes((short)value, array, 0);
			return array;
		}

		public static void GetBytes(ushort value, byte[] buffer)
		{
			GetBytes((short)value, buffer, 0);
		}

		public static void GetBytes(ushort value, byte[] buffer, int startIndex)
		{
			GetBytes((short)value, buffer, startIndex);
		}

		public static ushort GetUInt16(byte[] value)
		{
			return BitConverter.ToUInt16(value, 0);
		}

		public static ushort GetUInt16(byte[] value, int startIndex)
		{
			return BitConverter.ToUInt16(value, startIndex);
		}

		public static byte[] GetBytes(int value)
		{
			byte[] array = new byte[4];
			GetBytes(value, array, 0);
			return array;
		}

		public static void GetBytes(int value, byte[] buffer)
		{
			GetBytes(value, buffer, 0);
		}

		public unsafe static void GetBytes(int value, byte[] buffer, int startIndex)
		{
			if (buffer == null)
			{
				throw new GameFrameworkException("Buffer is invalid.");
			}
			if (startIndex < 0 || startIndex + 4 > buffer.Length)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			fixed (byte* ptr = buffer)
			{
				*(int*)(ptr + startIndex) = value;
			}
		}

		public static int GetInt32(byte[] value)
		{
			return BitConverter.ToInt32(value, 0);
		}

		public static int GetInt32(byte[] value, int startIndex)
		{
			return BitConverter.ToInt32(value, startIndex);
		}

		public static byte[] GetBytes(uint value)
		{
			byte[] array = new byte[4];
			GetBytes((int)value, array, 0);
			return array;
		}

		public static void GetBytes(uint value, byte[] buffer)
		{
			GetBytes((int)value, buffer, 0);
		}

		public static void GetBytes(uint value, byte[] buffer, int startIndex)
		{
			GetBytes((int)value, buffer, startIndex);
		}

		public static uint GetUInt32(byte[] value)
		{
			return BitConverter.ToUInt32(value, 0);
		}

		public static uint GetUInt32(byte[] value, int startIndex)
		{
			return BitConverter.ToUInt32(value, startIndex);
		}

		public static byte[] GetBytes(long value)
		{
			byte[] array = new byte[8];
			GetBytes(value, array, 0);
			return array;
		}

		public static void GetBytes(long value, byte[] buffer)
		{
			GetBytes(value, buffer, 0);
		}

		public unsafe static void GetBytes(long value, byte[] buffer, int startIndex)
		{
			if (buffer == null)
			{
				throw new GameFrameworkException("Buffer is invalid.");
			}
			if (startIndex < 0 || startIndex + 8 > buffer.Length)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			fixed (byte* ptr = buffer)
			{
				*(long*)(ptr + startIndex) = value;
			}
		}

		public static long GetInt64(byte[] value)
		{
			return BitConverter.ToInt64(value, 0);
		}

		public static long GetInt64(byte[] value, int startIndex)
		{
			return BitConverter.ToInt64(value, startIndex);
		}

		public static byte[] GetBytes(ulong value)
		{
			byte[] array = new byte[8];
			GetBytes((long)value, array, 0);
			return array;
		}

		public static void GetBytes(ulong value, byte[] buffer)
		{
			GetBytes((long)value, buffer, 0);
		}

		public static void GetBytes(ulong value, byte[] buffer, int startIndex)
		{
			GetBytes((long)value, buffer, startIndex);
		}

		public static ulong GetUInt64(byte[] value)
		{
			return BitConverter.ToUInt64(value, 0);
		}

		public static ulong GetUInt64(byte[] value, int startIndex)
		{
			return BitConverter.ToUInt64(value, startIndex);
		}

		public unsafe static byte[] GetBytes(float value)
		{
			byte[] array = new byte[4];
			GetBytes(*(int*)(&value), array, 0);
			return array;
		}

		public unsafe static void GetBytes(float value, byte[] buffer)
		{
			GetBytes(*(int*)(&value), buffer, 0);
		}

		public unsafe static void GetBytes(float value, byte[] buffer, int startIndex)
		{
			GetBytes(*(int*)(&value), buffer, startIndex);
		}

		public static float GetSingle(byte[] value)
		{
			return BitConverter.ToSingle(value, 0);
		}

		public static float GetSingle(byte[] value, int startIndex)
		{
			return BitConverter.ToSingle(value, startIndex);
		}

		public unsafe static byte[] GetBytes(double value)
		{
			byte[] array = new byte[8];
			GetBytes(*(long*)(&value), array, 0);
			return array;
		}

		public unsafe static void GetBytes(double value, byte[] buffer)
		{
			GetBytes(*(long*)(&value), buffer, 0);
		}

		public unsafe static void GetBytes(double value, byte[] buffer, int startIndex)
		{
			GetBytes(*(long*)(&value), buffer, startIndex);
		}

		public static double GetDouble(byte[] value)
		{
			return BitConverter.ToDouble(value, 0);
		}

		public static double GetDouble(byte[] value, int startIndex)
		{
			return BitConverter.ToDouble(value, startIndex);
		}

		public static byte[] GetBytes(string value)
		{
			return GetBytes(value, Encoding.UTF8);
		}

		public static int GetBytes(string value, byte[] buffer)
		{
			return GetBytes(value, Encoding.UTF8, buffer, 0);
		}

		public static int GetBytes(string value, byte[] buffer, int startIndex)
		{
			return GetBytes(value, Encoding.UTF8, buffer, startIndex);
		}

		public static byte[] GetBytes(string value, Encoding encoding)
		{
			if (value == null)
			{
				throw new GameFrameworkException("Value is invalid.");
			}
			if (encoding == null)
			{
				throw new GameFrameworkException("Encoding is invalid.");
			}
			return encoding.GetBytes(value);
		}

		public static int GetBytes(string value, Encoding encoding, byte[] buffer)
		{
			return GetBytes(value, encoding, buffer, 0);
		}

		public static int GetBytes(string value, Encoding encoding, byte[] buffer, int startIndex)
		{
			if (value == null)
			{
				throw new GameFrameworkException("Value is invalid.");
			}
			if (encoding == null)
			{
				throw new GameFrameworkException("Encoding is invalid.");
			}
			return encoding.GetBytes(value, 0, value.Length, buffer, startIndex);
		}

		public static string GetString(byte[] value)
		{
			return GetString(value, Encoding.UTF8);
		}

		public static string GetString(byte[] value, Encoding encoding)
		{
			if (value == null)
			{
				throw new GameFrameworkException("Value is invalid.");
			}
			if (encoding == null)
			{
				throw new GameFrameworkException("Encoding is invalid.");
			}
			return encoding.GetString(value);
		}

		public static string GetString(byte[] value, int startIndex, int length)
		{
			return GetString(value, startIndex, length, Encoding.UTF8);
		}

		public static string GetString(byte[] value, int startIndex, int length, Encoding encoding)
		{
			if (value == null)
			{
				throw new GameFrameworkException("Value is invalid.");
			}
			if (encoding == null)
			{
				throw new GameFrameworkException("Encoding is invalid.");
			}
			return encoding.GetString(value, startIndex, length);
		}
	}

	public static class Encryption
	{
		internal const int QuickEncryptLength = 220;

		public static byte[] GetQuickXorBytes(byte[] bytes, byte[] code)
		{
			return GetXorBytes(bytes, 0, 220, code);
		}

		public static void GetQuickSelfXorBytes(byte[] bytes, byte[] code)
		{
			GetSelfXorBytes(bytes, 0, 220, code);
		}

		public static byte[] GetXorBytes(byte[] bytes, byte[] code)
		{
			if (bytes == null)
			{
				return null;
			}
			return GetXorBytes(bytes, 0, bytes.Length, code);
		}

		public static void GetSelfXorBytes(byte[] bytes, byte[] code)
		{
			if (bytes != null)
			{
				GetSelfXorBytes(bytes, 0, bytes.Length, code);
			}
		}

		public static byte[] GetXorBytes(byte[] bytes, int startIndex, int length, byte[] code)
		{
			if (bytes == null)
			{
				return null;
			}
			int num = bytes.Length;
			byte[] array = new byte[num];
			Array.Copy(bytes, 0, array, 0, num);
			GetSelfXorBytes(array, startIndex, length, code);
			return array;
		}

		public static void GetSelfXorBytes(byte[] bytes, int startIndex, int length, byte[] code)
		{
			if (bytes != null)
			{
				if (code == null)
				{
					throw new GameFrameworkException("Code is invalid.");
				}
				int num = code.Length;
				if (num <= 0)
				{
					throw new GameFrameworkException("Code length is invalid.");
				}
				if (startIndex < 0 || length < 0 || startIndex + length > bytes.Length)
				{
					throw new GameFrameworkException("Start index or length is invalid.");
				}
				int num2 = startIndex % num;
				for (int i = startIndex; i < length; i++)
				{
					bytes[i] ^= code[num2++];
					num2 %= num;
				}
			}
		}
	}

	public static class Json
	{
		public interface IJsonHelper
		{
			string ToJson(object obj);

			T ToObject<T>(string json);

			object ToObject(Type objectType, string json);
		}

		private static IJsonHelper s_JsonHelper;

		public static void SetJsonHelper(IJsonHelper jsonHelper)
		{
			s_JsonHelper = jsonHelper;
		}

		public static string ToJson(object obj)
		{
			if (s_JsonHelper == null)
			{
				throw new GameFrameworkException("JSON helper is invalid.");
			}
			try
			{
				return s_JsonHelper.ToJson(obj);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not convert to JSON with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static byte[] ToJsonData(object obj)
		{
			return Converter.GetBytes(ToJson(obj));
		}

		public static T ToObject<T>(string json)
		{
			if (s_JsonHelper == null)
			{
				throw new GameFrameworkException("JSON helper is invalid.");
			}
			try
			{
				return s_JsonHelper.ToObject<T>(json);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not convert to object with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static object ToObject(Type objectType, string json)
		{
			if (s_JsonHelper == null)
			{
				throw new GameFrameworkException("JSON helper is invalid.");
			}
			if (objectType == null)
			{
				throw new GameFrameworkException("Object type is invalid.");
			}
			try
			{
				return s_JsonHelper.ToObject(objectType, json);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not convert to object with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static T ToObject<T>(byte[] jsonData)
		{
			return ToObject<T>(Converter.GetString(jsonData));
		}

		public static object ToObject(Type objectType, byte[] jsonData)
		{
			return ToObject(objectType, Converter.GetString(jsonData));
		}
	}

	public static class Marshal
	{
		private const int BlockSize = 4096;

		private static IntPtr s_CachedHGlobalPtr = IntPtr.Zero;

		private static int s_CachedHGlobalSize = 0;

		public static int CachedHGlobalSize => s_CachedHGlobalSize;

		public static void EnsureCachedHGlobalSize(int ensureSize)
		{
			if (ensureSize < 0)
			{
				throw new GameFrameworkException("Ensure size is invalid.");
			}
			if (s_CachedHGlobalPtr == IntPtr.Zero || s_CachedHGlobalSize < ensureSize)
			{
				FreeCachedHGlobal();
				int cb = (ensureSize - 1 + 4096) / 4096 * 4096;
				s_CachedHGlobalPtr = System.Runtime.InteropServices.Marshal.AllocHGlobal(cb);
				s_CachedHGlobalSize = cb;
			}
		}

		public static void FreeCachedHGlobal()
		{
			if (s_CachedHGlobalPtr != IntPtr.Zero)
			{
				System.Runtime.InteropServices.Marshal.FreeHGlobal(s_CachedHGlobalPtr);
				s_CachedHGlobalPtr = IntPtr.Zero;
				s_CachedHGlobalSize = 0;
			}
		}

		public static byte[] StructureToBytes<T>(T structure)
		{
			return StructureToBytes(structure, System.Runtime.InteropServices.Marshal.SizeOf(typeof(T)));
		}

		internal static byte[] StructureToBytes<T>(T structure, int structureSize)
		{
			if (structureSize < 0)
			{
				throw new GameFrameworkException("Structure size is invalid.");
			}
			EnsureCachedHGlobalSize(structureSize);
			System.Runtime.InteropServices.Marshal.StructureToPtr(structure, s_CachedHGlobalPtr, fDeleteOld: true);
			byte[] array = new byte[structureSize];
			System.Runtime.InteropServices.Marshal.Copy(s_CachedHGlobalPtr, array, 0, structureSize);
			return array;
		}

		public static void StructureToBytes<T>(T structure, byte[] result)
		{
			StructureToBytes(structure, System.Runtime.InteropServices.Marshal.SizeOf(typeof(T)), result, 0);
		}

		internal static void StructureToBytes<T>(T structure, int structureSize, byte[] result)
		{
			StructureToBytes(structure, structureSize, result, 0);
		}

		public static void StructureToBytes<T>(T structure, byte[] result, int startIndex)
		{
			StructureToBytes(structure, System.Runtime.InteropServices.Marshal.SizeOf(typeof(T)), result, startIndex);
		}

		internal static void StructureToBytes<T>(T structure, int structureSize, byte[] result, int startIndex)
		{
			if (structureSize < 0)
			{
				throw new GameFrameworkException("Structure size is invalid.");
			}
			if (result == null)
			{
				throw new GameFrameworkException("Result is invalid.");
			}
			if (startIndex < 0)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			if (startIndex + structureSize > result.Length)
			{
				throw new GameFrameworkException("Result length is not enough.");
			}
			EnsureCachedHGlobalSize(structureSize);
			System.Runtime.InteropServices.Marshal.StructureToPtr(structure, s_CachedHGlobalPtr, fDeleteOld: true);
			System.Runtime.InteropServices.Marshal.Copy(s_CachedHGlobalPtr, result, startIndex, structureSize);
		}

		public static T BytesToStructure<T>(byte[] buffer)
		{
			return BytesToStructure<T>(System.Runtime.InteropServices.Marshal.SizeOf(typeof(T)), buffer, 0);
		}

		public static T BytesToStructure<T>(byte[] buffer, int startIndex)
		{
			return BytesToStructure<T>(System.Runtime.InteropServices.Marshal.SizeOf(typeof(T)), buffer, startIndex);
		}

		internal static T BytesToStructure<T>(int structureSize, byte[] buffer)
		{
			return BytesToStructure<T>(structureSize, buffer, 0);
		}

		internal static T BytesToStructure<T>(int structureSize, byte[] buffer, int startIndex)
		{
			if (structureSize < 0)
			{
				throw new GameFrameworkException("Structure size is invalid.");
			}
			if (buffer == null)
			{
				throw new GameFrameworkException("Buffer is invalid.");
			}
			if (startIndex < 0)
			{
				throw new GameFrameworkException("Start index is invalid.");
			}
			if (startIndex + structureSize > buffer.Length)
			{
				throw new GameFrameworkException("Buffer length is not enough.");
			}
			EnsureCachedHGlobalSize(structureSize);
			System.Runtime.InteropServices.Marshal.Copy(buffer, startIndex, s_CachedHGlobalPtr, structureSize);
			return (T)System.Runtime.InteropServices.Marshal.PtrToStructure(s_CachedHGlobalPtr, typeof(T));
		}
	}

	public static class Nullable
	{
		public static bool IsNullable<T>(T t)
		{
			return false;
		}

		public static bool IsNullable<T>(T? t) where T : struct
		{
			return true;
		}
	}

	public static class Path
	{
		public static string GetRegularPath(string path)
		{
			return path?.Replace('\\', '/');
		}

		public static string GetCombinePath(params string[] path)
		{
			if (path == null || path.Length < 1)
			{
				return null;
			}
			string text = path[0];
			for (int i = 1; i < path.Length; i++)
			{
				text = System.IO.Path.Combine(text, path[i]);
			}
			return GetRegularPath(text);
		}

		public static string GetRemotePath(params string[] path)
		{
			string combinePath = GetCombinePath(path);
			if (combinePath == null)
			{
				return null;
			}
			return combinePath.Contains("://") ? combinePath : ("file:///" + combinePath).Replace("file:////", "file:///");
		}

		public static string GetResourceNameWithSuffix(string resourceName)
		{
			if (string.IsNullOrEmpty(resourceName))
			{
				throw new GameFrameworkException("Resource name is invalid.");
			}
			return Text.Format("{0}.dat", resourceName);
		}

		public static string GetResourceNameWithCrc32AndSuffix(string resourceName, int hashCode)
		{
			if (string.IsNullOrEmpty(resourceName))
			{
				throw new GameFrameworkException("Resource name is invalid.");
			}
			return Text.Format("{0}.{1:x8}.dat", resourceName, hashCode);
		}

		public static bool RemoveEmptyDirectory(string directoryName)
		{
			if (string.IsNullOrEmpty(directoryName))
			{
				throw new GameFrameworkException("Directory name is invalid.");
			}
			try
			{
				if (!Directory.Exists(directoryName))
				{
					return false;
				}
				string[] directories = Directory.GetDirectories(directoryName, "*");
				int num = directories.Length;
				string[] array = directories;
				foreach (string directoryName2 in array)
				{
					if (RemoveEmptyDirectory(directoryName2))
					{
						num--;
					}
				}
				if (num > 0)
				{
					return false;
				}
				if (Directory.GetFiles(directoryName, "*").Length != 0)
				{
					return false;
				}
				Directory.Delete(directoryName);
				return true;
			}
			catch
			{
				return false;
			}
		}
	}

	public static class Profiler
	{
		public interface IProfilerHelper
		{
			void BeginSample(string name);

			void EndSample();
		}

		private static IProfilerHelper s_ProfilerHelper;

		public static void SetProfilerHelper(IProfilerHelper profilerHelper)
		{
			s_ProfilerHelper = profilerHelper;
		}

		[Conditional("DEBUG")]
		public static void BeginSample(string name)
		{
			if (s_ProfilerHelper == null)
			{
				throw new GameFrameworkException("Profiler helper is invalid.");
			}
			s_ProfilerHelper.BeginSample(name);
		}

		[Conditional("DEBUG")]
		public static void EndSample()
		{
			if (s_ProfilerHelper == null)
			{
				throw new GameFrameworkException("Profiler helper is invalid.");
			}
			s_ProfilerHelper.EndSample();
		}
	}

	public static class Random
	{
		private static System.Random s_Random = new System.Random((int)DateTime.Now.Ticks);

		public static void SetSeed(int seed)
		{
			s_Random = new System.Random(seed);
		}

		public static int GetRandom()
		{
			return s_Random.Next();
		}

		public static int GetRandom(int maxValue)
		{
			return s_Random.Next(maxValue);
		}

		public static int GetRandom(int minValue, int maxValue)
		{
			return s_Random.Next(minValue, maxValue);
		}

		public static double GetRandomDouble()
		{
			return s_Random.NextDouble();
		}

		public static void GetRandomBytes(byte[] buffer)
		{
			s_Random.NextBytes(buffer);
		}
	}

	public static class Text
	{
		public interface ITextHelper
		{
			string Format(string format, params object[] arg);

			string Format<T>(string format, T arg);

			string Format<T1, T2>(string format, T1 arg1, T2 arg2);

			string Format<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3);

			string Format<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4);

			string Format<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5);

			string Format<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6);

			string Format<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15);

			string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16);
		}

		private static ITextHelper s_TextHelper;

		public static void SetTextHelper(ITextHelper textHelper)
		{
			s_TextHelper = textHelper;
		}

		public static string Format(string format, params object[] arg)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg);
			}
			return s_TextHelper.Format(format, arg);
		}

		public static string Format<T>(string format, T arg)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg);
			}
			return s_TextHelper.Format(format, arg);
		}

		public static string Format<T1, T2>(string format, T1 arg1, T2 arg2)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2);
			}
			return s_TextHelper.Format(format, arg1, arg2);
		}

		public static string Format<T1, T2, T3>(string format, T1 arg1, T2 arg2, T3 arg3)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3);
		}

		public static string Format<T1, T2, T3, T4>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4);
		}

		public static string Format<T1, T2, T3, T4, T5>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5);
		}

		public static string Format<T1, T2, T3, T4, T5, T6>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
		}

		public static string Format<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15, T16>(string format, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6, T7 arg7, T8 arg8, T9 arg9, T10 arg10, T11 arg11, T12 arg12, T13 arg13, T14 arg14, T15 arg15, T16 arg16)
		{
			if (format == null)
			{
				throw new GameFrameworkException("Format is invalid.");
			}
			if (s_TextHelper == null)
			{
				return string.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
			}
			return s_TextHelper.Format(format, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
		}
	}

	public static class Unity
	{
		private class MainBehaviour : MonoBehaviour
		{
			private event UnityAction updateEvent;

			private event UnityAction fixedUpdateEvent;

			private event UnityAction lateUpdateEvent;

			private event UnityAction destroyEvent;

			private event UnityAction onDrawGizmosEvent;

			private event UnityAction<bool> onApplicationPause;

			private void Update()
			{
				if (updateEvent != null)
				{
					updateEvent();
				}
			}

			private void FixedUpdate()
			{
				if (fixedUpdateEvent != null)
				{
					fixedUpdateEvent();
				}
			}

			private void LateUpdate()
			{
				if (lateUpdateEvent != null)
				{
					lateUpdateEvent();
				}
			}

			private void OnDestroy()
			{
				if (destroyEvent != null)
				{
					destroyEvent();
				}
			}

			private void OnDrawGizmos()
			{
				if (onDrawGizmosEvent != null)
				{
					onDrawGizmosEvent();
				}
			}

			private void OnApplicationPause(bool pauseStatus)
			{
				if (onApplicationPause != null)
				{
					onApplicationPause(pauseStatus);
				}
			}

			public void AddLateUpdateListener(UnityAction fun)
			{
				lateUpdateEvent += fun;
			}

			public void RemoveLateUpdateListener(UnityAction fun)
			{
				lateUpdateEvent -= fun;
			}

			public void AddFixedUpdateListener(UnityAction fun)
			{
				fixedUpdateEvent += fun;
			}

			public void RemoveFixedUpdateListener(UnityAction fun)
			{
				fixedUpdateEvent -= fun;
			}

			public void AddUpdateListener(UnityAction fun)
			{
				updateEvent += fun;
			}

			public void RemoveUpdateListener(UnityAction fun)
			{
				updateEvent -= fun;
			}

			public void AddDestroyListener(UnityAction fun)
			{
				destroyEvent += fun;
			}

			public void RemoveDestroyListener(UnityAction fun)
			{
				destroyEvent -= fun;
			}

			public void AddOnDrawGizmosListener(UnityAction fun)
			{
				onDrawGizmosEvent += fun;
			}

			public void RemoveOnDrawGizmosListener(UnityAction fun)
			{
				onDrawGizmosEvent -= fun;
			}

			public void AddOnApplicationPauseListener(UnityAction<bool> fun)
			{
				onApplicationPause += fun;
			}

			public void RemoveOnApplicationPauseListener(UnityAction<bool> fun)
			{
				onApplicationPause -= fun;
			}

			public void Release()
			{
				updateEvent = null;
				fixedUpdateEvent = null;
				lateUpdateEvent = null;
				onDrawGizmosEvent = null;
				destroyEvent = null;
				onApplicationPause = null;
			}
		}

		private static GameObject _entity;

		private static MainBehaviour _behaviour;

		public static Coroutine StartCoroutine(string methodName)
		{
			if (string.IsNullOrEmpty(methodName))
			{
				return null;
			}
			_MakeEntity();
			return _behaviour.StartCoroutine(methodName);
		}

		public static Coroutine StartCoroutine(IEnumerator routine)
		{
			if (routine == null)
			{
				return null;
			}
			_MakeEntity();
			return _behaviour.StartCoroutine(routine);
		}

		public static Coroutine StartCoroutine(string methodName, [DefaultValue("null")] object value)
		{
			if (string.IsNullOrEmpty(methodName))
			{
				return null;
			}
			_MakeEntity();
			return _behaviour.StartCoroutine(methodName, value);
		}

		public static void StopCoroutine(string methodName)
		{
			if (!string.IsNullOrEmpty(methodName) && _entity != null)
			{
				_behaviour.StopCoroutine(methodName);
			}
		}

		public static void StopCoroutine(IEnumerator routine)
		{
			if (routine != null && _entity != null)
			{
				_behaviour.StopCoroutine(routine);
			}
		}

		public static void StopCoroutine(Coroutine routine)
		{
			if (routine != null && _entity != null)
			{
				_behaviour.StopCoroutine(routine);
				routine = null;
			}
		}

		public static void StopAllCoroutines()
		{
			if (_entity != null)
			{
				_behaviour.StopAllCoroutines();
			}
		}

		public static void AddUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.AddUpdateListener(fun);
		}

		public static void AddFixedUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.AddFixedUpdateListener(fun);
		}

		public static void AddLateUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.AddLateUpdateListener(fun);
		}

		public static void RemoveUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveUpdateListener(fun);
		}

		public static void RemoveFixedUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveFixedUpdateListener(fun);
		}

		public static void RemoveLateUpdateListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveLateUpdateListener(fun);
		}

		public static void AddDestroyListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.AddDestroyListener(fun);
		}

		public static void RemoveDestroyListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveDestroyListener(fun);
		}

		public static void AddOnDrawGizmosListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveDestroyListener(fun);
		}

		public static void RemoveOnDrawGizmosListener(UnityAction fun)
		{
			_MakeEntity();
			_behaviour.RemoveDestroyListener(fun);
		}

		public static void AddOnApplicationPauseListener(UnityAction<bool> fun)
		{
			_MakeEntity();
			_behaviour.AddOnApplicationPauseListener(fun);
		}

		public static void RemoveOnApplicationPauseListener(UnityAction<bool> fun)
		{
			_MakeEntity();
			_behaviour.AddOnApplicationPauseListener(fun);
		}

		public static void Release()
		{
			_MakeEntity();
			_behaviour.Release();
		}

		private static void _MakeEntity()
		{
			if (!(_entity != null))
			{
				_entity = new GameObject("__MonoUtility__")
				{
					hideFlags = HideFlags.HideAndDontSave
				};
				_entity.SetActive(value: true);
				if (Application.isPlaying)
				{
					UnityEngine.Object.DontDestroyOnLoad(_entity);
				}
				_behaviour = _entity.AddComponent<MainBehaviour>();
			}
		}
	}

	public static class Verifier
	{
		private sealed class Crc32
		{
			private const int TableLength = 256;

			private const uint DefaultPolynomial = 3988292384u;

			private const uint DefaultSeed = uint.MaxValue;

			private readonly uint m_Seed;

			private readonly uint[] m_Table;

			private uint m_Hash;

			public Crc32()
				: this(3988292384u, uint.MaxValue)
			{
			}

			public Crc32(uint polynomial, uint seed)
			{
				m_Seed = seed;
				m_Table = InitializeTable(polynomial);
				m_Hash = seed;
			}

			public void Initialize()
			{
				m_Hash = m_Seed;
			}

			public void HashCore(byte[] bytes, int offset, int length)
			{
				m_Hash = CalculateHash(m_Table, m_Hash, bytes, offset, length);
			}

			public uint HashFinal()
			{
				return ~m_Hash;
			}

			private static uint CalculateHash(uint[] table, uint value, byte[] bytes, int offset, int length)
			{
				int num = offset + length;
				for (int i = offset; i < num; i++)
				{
					value = (value >> 8) ^ table[bytes[i] ^ (value & 0xFF)];
				}
				return value;
			}

			private static uint[] InitializeTable(uint polynomial)
			{
				uint[] array = new uint[256];
				for (int i = 0; i < 256; i++)
				{
					uint num = (uint)i;
					for (int j = 0; j < 8; j++)
					{
						num = (((num & 1) != 1) ? (num >> 1) : ((num >> 1) ^ polynomial));
					}
					array[i] = num;
				}
				return array;
			}
		}

		private const int CachedBytesLength = 4096;

		private static readonly byte[] s_CachedBytes = new byte[4096];

		private static readonly Crc32 s_Algorithm = new Crc32();

		public static int GetCrc32(byte[] bytes)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return GetCrc32(bytes, 0, bytes.Length);
		}

		public static int GetCrc32(byte[] bytes, int offset, int length)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			if (offset < 0 || length < 0 || offset + length > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			s_Algorithm.HashCore(bytes, offset, length);
			int result = (int)s_Algorithm.HashFinal();
			s_Algorithm.Initialize();
			return result;
		}

		public static int GetCrc32(Stream stream)
		{
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			while (true)
			{
				int num = stream.Read(s_CachedBytes, 0, 4096);
				if (num > 0)
				{
					s_Algorithm.HashCore(s_CachedBytes, 0, num);
					continue;
				}
				break;
			}
			int result = (int)s_Algorithm.HashFinal();
			s_Algorithm.Initialize();
			Array.Clear(s_CachedBytes, 0, 4096);
			return result;
		}

		public static byte[] GetCrc32Bytes(int crc32)
		{
			return new byte[4]
			{
				(byte)((crc32 >> 24) & 0xFF),
				(byte)((crc32 >> 16) & 0xFF),
				(byte)((crc32 >> 8) & 0xFF),
				(byte)(crc32 & 0xFF)
			};
		}

		public static void GetCrc32Bytes(int crc32, byte[] bytes)
		{
			GetCrc32Bytes(crc32, bytes, 0);
		}

		public static void GetCrc32Bytes(int crc32, byte[] bytes, int offset)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Result is invalid.");
			}
			if (offset < 0 || offset + 4 > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			bytes[offset] = (byte)((crc32 >> 24) & 0xFF);
			bytes[offset + 1] = (byte)((crc32 >> 16) & 0xFF);
			bytes[offset + 2] = (byte)((crc32 >> 8) & 0xFF);
			bytes[offset + 3] = (byte)(crc32 & 0xFF);
		}

		internal static int GetCrc32(Stream stream, byte[] code, int length)
		{
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			if (code == null)
			{
				throw new GameFrameworkException("Code is invalid.");
			}
			int num = code.Length;
			if (num <= 0)
			{
				throw new GameFrameworkException("Code length is invalid.");
			}
			int num2 = (int)stream.Length;
			if (length < 0 || length > num2)
			{
				length = num2;
			}
			int num3 = 0;
			while (true)
			{
				int num4 = stream.Read(s_CachedBytes, 0, 4096);
				if (num4 <= 0)
				{
					break;
				}
				if (length > 0)
				{
					for (int i = 0; i < num4 && i < length; i++)
					{
						s_CachedBytes[i] ^= code[num3++];
						num3 %= num;
					}
					length -= num4;
				}
				s_Algorithm.HashCore(s_CachedBytes, 0, num4);
			}
			int result = (int)s_Algorithm.HashFinal();
			s_Algorithm.Initialize();
			Array.Clear(s_CachedBytes, 0, 4096);
			return result;
		}
	}

	public static class Zip
	{
		public interface IZipHelper
		{
			bool Compress(byte[] bytes, int offset, int length, Stream compressedStream);

			bool Compress(Stream stream, Stream compressedStream);

			bool Decompress(byte[] bytes, int offset, int length, Stream decompressedStream);

			bool Decompress(Stream stream, Stream decompressedStream);
		}

		private static IZipHelper s_ZipHelper;

		public static void SetZipHelper(IZipHelper zipHelper)
		{
			s_ZipHelper = zipHelper;
		}

		public static byte[] Compress(byte[] bytes)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Compress(bytes, 0, bytes.Length);
		}

		public static bool Compress(byte[] bytes, Stream compressedStream)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Compress(bytes, 0, bytes.Length, compressedStream);
		}

		public static byte[] Compress(byte[] bytes, int offset, int length)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Compress(bytes, offset, length, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Compress(byte[] bytes, int offset, int length, Stream compressedStream)
		{
			if (s_ZipHelper == null)
			{
				throw new GameFrameworkException("Zip helper is invalid.");
			}
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			if (offset < 0 || length <= 0 || offset + length > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			if (compressedStream == null)
			{
				throw new GameFrameworkException("Compressed stream is invalid.");
			}
			try
			{
				return s_ZipHelper.Compress(bytes, offset, length, compressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not compress with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static byte[] Compress(Stream stream)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Compress(stream, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Compress(Stream stream, Stream compressedStream)
		{
			if (s_ZipHelper == null)
			{
				throw new GameFrameworkException("Zip helper is invalid.");
			}
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			if (compressedStream == null)
			{
				throw new GameFrameworkException("Compressed stream is invalid.");
			}
			try
			{
				return s_ZipHelper.Compress(stream, compressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not compress with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static byte[] Decompress(byte[] bytes)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Decompress(bytes, 0, bytes.Length);
		}

		public static bool Decompress(byte[] bytes, Stream decompressedStream)
		{
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			return Decompress(bytes, 0, bytes.Length, decompressedStream);
		}

		public static byte[] Decompress(byte[] bytes, int offset, int length)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Decompress(bytes, offset, length, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Decompress(byte[] bytes, int offset, int length, Stream decompressedStream)
		{
			if (s_ZipHelper == null)
			{
				throw new GameFrameworkException("Zip helper is invalid.");
			}
			if (bytes == null)
			{
				throw new GameFrameworkException("Bytes is invalid.");
			}
			if (offset < 0 || length <= 0 || offset + length > bytes.Length)
			{
				throw new GameFrameworkException("Offset or length is invalid.");
			}
			if (decompressedStream == null)
			{
				throw new GameFrameworkException("Decompressed stream is invalid.");
			}
			try
			{
				return s_ZipHelper.Decompress(bytes, offset, length, decompressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not decompress with exception '{0}'.", ex.ToString()), ex);
			}
		}

		public static byte[] Decompress(Stream stream)
		{
			using MemoryStream memoryStream = new MemoryStream();
			if (Decompress(stream, memoryStream))
			{
				return memoryStream.ToArray();
			}
			return null;
		}

		public static bool Decompress(Stream stream, Stream decompressedStream)
		{
			if (s_ZipHelper == null)
			{
				throw new GameFrameworkException("Zip helper is invalid.");
			}
			if (stream == null)
			{
				throw new GameFrameworkException("Stream is invalid.");
			}
			if (decompressedStream == null)
			{
				throw new GameFrameworkException("Decompressed stream is invalid.");
			}
			try
			{
				return s_ZipHelper.Decompress(stream, decompressedStream);
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Text.Format("Can not decompress with exception '{0}'.", ex.ToString()), ex);
			}
		}
	}
}
