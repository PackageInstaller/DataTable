using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace YooAsset;

internal static class ManifestTools
{
	public static bool VerifyManifestData(byte[] fileData, string hashValue)
	{
		if (fileData == null || fileData.Length == 0)
		{
			return false;
		}
		if (string.IsNullOrEmpty(hashValue))
		{
			return false;
		}
		string text = ((hashValue.Length != 32) ? HashUtility.BytesCRC32(fileData) : HashUtility.BytesMD5(fileData));
		if (text == hashValue)
		{
			return true;
		}
		return false;
	}

	public static void SerializeToJson(string savePath, PackageManifest manifest)
	{
		string content = JsonUtility.ToJson(manifest, prettyPrint: true);
		FileUtility.WriteAllText(savePath, content);
	}

	public static void SerializeToBinary(string savePath, PackageManifest manifest)
	{
		using FileStream fileStream = new FileStream(savePath, FileMode.Create);
		BufferWriter bufferWriter = new BufferWriter(104857600);
		bufferWriter.WriteUInt32(5853007u);
		bufferWriter.WriteUTF8(manifest.FileVersion);
		bufferWriter.WriteBool(manifest.EnableAddressable);
		bufferWriter.WriteBool(manifest.LocationToLower);
		bufferWriter.WriteBool(manifest.IncludeAssetGUID);
		bufferWriter.WriteInt32(manifest.OutputNameStyle);
		bufferWriter.WriteInt32(manifest.BuildBundleType);
		bufferWriter.WriteUTF8(manifest.BuildPipeline);
		bufferWriter.WriteUTF8(manifest.PackageName);
		bufferWriter.WriteUTF8(manifest.PackageVersion);
		bufferWriter.WriteUTF8(manifest.PackageNote);
		bufferWriter.WriteInt32(manifest.AssetList.Count);
		for (int i = 0; i < manifest.AssetList.Count; i++)
		{
			PackageAsset packageAsset = manifest.AssetList[i];
			bufferWriter.WriteUTF8(packageAsset.Address);
			bufferWriter.WriteUTF8(packageAsset.AssetPath);
			bufferWriter.WriteUTF8(packageAsset.AssetGUID);
			bufferWriter.WriteUTF8Array(packageAsset.AssetTags);
			bufferWriter.WriteInt32(packageAsset.BundleID);
			bufferWriter.WriteInt32Array(packageAsset.DependBundleIDs);
		}
		bufferWriter.WriteInt32(manifest.BundleList.Count);
		for (int j = 0; j < manifest.BundleList.Count; j++)
		{
			PackageBundle packageBundle = manifest.BundleList[j];
			bufferWriter.WriteUTF8(packageBundle.BundleName);
			bufferWriter.WriteUInt32(packageBundle.UnityCRC);
			bufferWriter.WriteUTF8(packageBundle.FileHash);
			bufferWriter.WriteUTF8(packageBundle.FileCRC);
			bufferWriter.WriteInt64(packageBundle.FileSize);
			bufferWriter.WriteBool(packageBundle.Encrypted);
			bufferWriter.WriteUTF8Array(packageBundle.Tags);
			bufferWriter.WriteUTF8(packageBundle.DownloadTag ?? string.Empty);
			bufferWriter.WriteInt32Array(packageBundle.DependBundleIDs);
		}
		bufferWriter.WriteToStream(fileStream);
		fileStream.Flush();
	}

	public static PackageManifest DeserializeFromJson(string jsonContent)
	{
		return JsonUtility.FromJson<PackageManifest>(jsonContent);
	}

	public static PackageManifest DeserializeFromBinary(byte[] binaryData)
	{
		BufferReader bufferReader = new BufferReader(binaryData);
		if (bufferReader.ReadUInt32() != 5853007)
		{
			throw new Exception("Invalid manifest file !");
		}
		string text = bufferReader.ReadUTF8();
		if (text != "2.3.1")
		{
			throw new Exception("The manifest file version are not compatible : " + text + " != 2.3.1");
		}
		PackageManifest packageManifest = new PackageManifest();
		packageManifest.FileVersion = text;
		packageManifest.EnableAddressable = bufferReader.ReadBool();
		packageManifest.LocationToLower = bufferReader.ReadBool();
		packageManifest.IncludeAssetGUID = bufferReader.ReadBool();
		packageManifest.OutputNameStyle = bufferReader.ReadInt32();
		packageManifest.BuildBundleType = bufferReader.ReadInt32();
		packageManifest.BuildPipeline = bufferReader.ReadUTF8();
		packageManifest.PackageName = bufferReader.ReadUTF8();
		packageManifest.PackageVersion = bufferReader.ReadUTF8();
		packageManifest.PackageNote = bufferReader.ReadUTF8();
		if (packageManifest.EnableAddressable && packageManifest.LocationToLower)
		{
			throw new Exception("Addressable not support location to lower !");
		}
		int num = bufferReader.ReadInt32();
		CreateAssetCollection(packageManifest, num);
		for (int i = 0; i < num; i++)
		{
			PackageAsset packageAsset = new PackageAsset();
			packageAsset.Address = bufferReader.ReadUTF8();
			packageAsset.AssetPath = bufferReader.ReadUTF8();
			packageAsset.AssetGUID = bufferReader.ReadUTF8();
			packageAsset.AssetTags = bufferReader.ReadUTF8Array();
			packageAsset.BundleID = bufferReader.ReadInt32();
			packageAsset.DependBundleIDs = bufferReader.ReadInt32Array();
			FillAssetCollection(packageManifest, packageAsset);
		}
		int num2 = bufferReader.ReadInt32();
		CreateBundleCollection(packageManifest, num2);
		for (int j = 0; j < num2; j++)
		{
			PackageBundle packageBundle = new PackageBundle();
			packageBundle.BundleName = bufferReader.ReadUTF8();
			packageBundle.UnityCRC = bufferReader.ReadUInt32();
			packageBundle.FileHash = bufferReader.ReadUTF8();
			packageBundle.FileCRC = bufferReader.ReadUTF8();
			packageBundle.FileSize = bufferReader.ReadInt64();
			packageBundle.Encrypted = bufferReader.ReadBool();
			packageBundle.Tags = bufferReader.ReadUTF8Array();
			packageBundle.DownloadTag = bufferReader.ReadUTF8();
			packageBundle.DependBundleIDs = bufferReader.ReadInt32Array();
			FillBundleCollection(packageManifest, packageBundle);
		}
		InitManifest(packageManifest);
		return packageManifest;
	}

	public static void InitManifest(PackageManifest manifest)
	{
		foreach (PackageAsset asset in manifest.AssetList)
		{
			int bundleID = asset.BundleID;
			if (bundleID >= 0 && bundleID < manifest.BundleList.Count)
			{
				manifest.BundleList[bundleID].IncludeMainAssets.Add(asset);
				continue;
			}
			throw new Exception($"Invalid bundle id : {bundleID} Asset path : {asset.AssetPath}");
		}
		for (int i = 0; i < manifest.BundleList.Count; i++)
		{
			int[] dependBundleIDs = manifest.BundleList[i].DependBundleIDs;
			foreach (int index in dependBundleIDs)
			{
				manifest.BundleList[index].AddReferenceBundleID(i);
			}
		}
	}

	public static void CreateAssetCollection(PackageManifest manifest, int assetCount)
	{
		manifest.AssetList = new List<PackageAsset>(assetCount);
		manifest.AssetDic = new Dictionary<string, PackageAsset>(assetCount);
		if (manifest.EnableAddressable)
		{
			manifest.AssetPathMapping1 = new Dictionary<string, string>(assetCount * 3);
		}
		else if (manifest.LocationToLower)
		{
			manifest.AssetPathMapping1 = new Dictionary<string, string>(assetCount * 2, StringComparer.OrdinalIgnoreCase);
		}
		else
		{
			manifest.AssetPathMapping1 = new Dictionary<string, string>(assetCount * 2);
		}
		if (manifest.IncludeAssetGUID)
		{
			manifest.AssetPathMapping2 = new Dictionary<string, string>(assetCount);
		}
		else
		{
			manifest.AssetPathMapping2 = new Dictionary<string, string>();
		}
	}

	public static void FillAssetCollection(PackageManifest manifest, PackageAsset packageAsset)
	{
		manifest.AssetList.Add(packageAsset);
		string assetPath = packageAsset.AssetPath;
		if (manifest.AssetDic.ContainsKey(assetPath))
		{
			throw new Exception("AssetPath have existed : " + assetPath);
		}
		manifest.AssetDic.Add(assetPath, packageAsset);
		string assetPath2 = packageAsset.AssetPath;
		if (manifest.AssetPathMapping1.ContainsKey(assetPath2))
		{
			throw new Exception("Location have existed : " + assetPath2);
		}
		manifest.AssetPathMapping1.Add(assetPath2, packageAsset.AssetPath);
		string text = Path.ChangeExtension(assetPath2, null);
		if ((object)assetPath2 != text)
		{
			if (manifest.AssetPathMapping1.ContainsKey(text))
			{
				YooLogger.Warning("Location have existed : " + text);
			}
			else
			{
				manifest.AssetPathMapping1.Add(text, packageAsset.AssetPath);
			}
		}
		if (manifest.EnableAddressable)
		{
			string address = packageAsset.Address;
			if (!string.IsNullOrEmpty(address))
			{
				if (manifest.AssetPathMapping1.ContainsKey(address))
				{
					throw new Exception("Location have existed : " + address);
				}
				manifest.AssetPathMapping1.Add(address, packageAsset.AssetPath);
			}
		}
		if (manifest.IncludeAssetGUID)
		{
			if (manifest.AssetPathMapping2.ContainsKey(packageAsset.AssetGUID))
			{
				throw new Exception("AssetGUID have existed : " + packageAsset.AssetGUID);
			}
			manifest.AssetPathMapping2.Add(packageAsset.AssetGUID, packageAsset.AssetPath);
		}
	}

	public static void CreateBundleCollection(PackageManifest manifest, int bundleCount)
	{
		manifest.BundleList = new List<PackageBundle>(bundleCount);
		manifest.BundleDic1 = new Dictionary<string, PackageBundle>(bundleCount);
		manifest.BundleDic2 = new Dictionary<string, PackageBundle>(bundleCount);
		manifest.BundleDic3 = new Dictionary<string, PackageBundle>(bundleCount);
	}

	public static void FillBundleCollection(PackageManifest manifest, PackageBundle packageBundle)
	{
		packageBundle.InitBundle(manifest);
		manifest.BundleList.Add(packageBundle);
		manifest.BundleDic1.Add(packageBundle.BundleName, packageBundle);
		manifest.BundleDic2.Add(packageBundle.FileName, packageBundle);
		manifest.BundleDic3.Add(packageBundle.BundleGUID, packageBundle);
	}

	public static string GetRemoteBundleFileExtension(string bundleName)
	{
		return Path.GetExtension(bundleName);
	}

	public static string GetRemoteBundleFileName(int nameStyle, string bundleName, string fileExtension, string fileHash)
	{
		switch (nameStyle)
		{
		case 0:
			return StringUtility.Format("{0}{1}", fileHash, fileExtension);
		case 1:
			return bundleName;
		case 2:
		{
			if (string.IsNullOrEmpty(fileExtension))
			{
				return StringUtility.Format("{0}_{1}", bundleName, fileHash);
			}
			string arg = bundleName.Remove(bundleName.LastIndexOf('.'));
			return StringUtility.Format("{0}_{1}{2}", arg, fileHash, fileExtension);
		}
		default:
			throw new NotImplementedException($"Invalid name style : {nameStyle}");
		}
	}
}
