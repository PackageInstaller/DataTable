using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace YooAsset;

internal static class CatalogTools
{
	public static void SerializeToJson(string savePath, DefaultBuildinFileCatalog catalog)
	{
		string content = JsonUtility.ToJson(catalog, prettyPrint: true);
		FileUtility.WriteAllText(savePath, content);
	}

	public static DefaultBuildinFileCatalog DeserializeFromJson(string jsonContent)
	{
		return JsonUtility.FromJson<DefaultBuildinFileCatalog>(jsonContent);
	}

	public static void SerializeToBinary(string savePath, DefaultBuildinFileCatalog catalog)
	{
		using FileStream fileStream = new FileStream(savePath, FileMode.Create);
		BufferWriter bufferWriter = new BufferWriter(104857600);
		bufferWriter.WriteUInt32(20170222u);
		bufferWriter.WriteUTF8("1.0.0");
		bufferWriter.WriteUTF8(catalog.PackageName);
		bufferWriter.WriteUTF8(catalog.PackageVersion);
		bufferWriter.WriteInt32(catalog.Wrappers.Count);
		for (int i = 0; i < catalog.Wrappers.Count; i++)
		{
			DefaultBuildinFileCatalog.FileWrapper fileWrapper = catalog.Wrappers[i];
			bufferWriter.WriteUTF8(fileWrapper.BundleGUID);
			bufferWriter.WriteUTF8(fileWrapper.FileName);
		}
		bufferWriter.WriteToStream(fileStream);
		fileStream.Flush();
	}

	public static DefaultBuildinFileCatalog DeserializeFromBinary(byte[] binaryData)
	{
		BufferReader bufferReader = new BufferReader(binaryData);
		if (bufferReader.ReadUInt32() != 20170222)
		{
			throw new Exception("Invalid catalog file !");
		}
		string text = bufferReader.ReadUTF8();
		if (text != "1.0.0")
		{
			throw new Exception("The catalog file version are not compatible : " + text + " != 1.0.0");
		}
		DefaultBuildinFileCatalog defaultBuildinFileCatalog = new DefaultBuildinFileCatalog();
		defaultBuildinFileCatalog.FileVersion = text;
		defaultBuildinFileCatalog.PackageName = bufferReader.ReadUTF8();
		defaultBuildinFileCatalog.PackageVersion = bufferReader.ReadUTF8();
		int num = bufferReader.ReadInt32();
		defaultBuildinFileCatalog.Wrappers = new List<DefaultBuildinFileCatalog.FileWrapper>(num);
		for (int i = 0; i < num; i++)
		{
			DefaultBuildinFileCatalog.FileWrapper fileWrapper = new DefaultBuildinFileCatalog.FileWrapper();
			fileWrapper.BundleGUID = bufferReader.ReadUTF8();
			fileWrapper.FileName = bufferReader.ReadUTF8();
			defaultBuildinFileCatalog.Wrappers.Add(fileWrapper);
		}
		return defaultBuildinFileCatalog;
	}
}
