using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace Ase;

public static class BinaryReaderExtension
{
	public static Color32 ReadColor32(this BinaryReader binaryReader)
	{
		return new Color32(binaryReader.ReadByte(), binaryReader.ReadByte(), binaryReader.ReadByte(), binaryReader.ReadByte());
	}

	public static Color ReadColor(this BinaryReader binaryReader)
	{
		return new Color(binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}

	public static DateTime ReadDateTime(this BinaryReader binaryReader)
	{
		return new DateTime(binaryReader.ReadInt64());
	}

	public static Quaternion ReadQuaternion(this BinaryReader binaryReader)
	{
		return new Quaternion(binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}

	public static List<int> ReadListInt(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListInt(binaryReader.ReadString());
	}

	public static List<bool> ReadListBool(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListBool(binaryReader.ReadString());
	}

	public static List<string> ReadListString(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListString(binaryReader.ReadString());
	}

	public static List<float> ReadListFloat(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListFloat(binaryReader.ReadString());
	}

	public static List<T> ReadListEnum<T>(this BinaryReader binaryReader) where T : struct
	{
		return DataTableExtension.ParseListEnum<T>(binaryReader.ReadString());
	}

	public static List<List<string>> ReadListListString(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListStringList(binaryReader.ReadString());
	}

	public static List<List<float>> ReadListListFloat(this BinaryReader binaryReader)
	{
		return DataTableExtension.ParseListFloatList(binaryReader.ReadString());
	}

	public static Rect ReadRect(this BinaryReader binaryReader)
	{
		return new Rect(binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}

	public static Vector2 ReadVector2(this BinaryReader binaryReader)
	{
		return new Vector2(binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}

	public static Vector3 ReadVector3(this BinaryReader binaryReader)
	{
		return new Vector3(binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}

	public static Vector4 ReadVector4(this BinaryReader binaryReader)
	{
		return new Vector4(binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle(), binaryReader.ReadSingle());
	}
}
