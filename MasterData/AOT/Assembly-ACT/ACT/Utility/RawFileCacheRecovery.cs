using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEngine;
using YooAsset;

namespace ACT.Utility;

internal static class RawFileCacheRecovery
{
	private sealed class StartupCacheAccess
	{
		public readonly Type CacheType;

		public readonly FieldInfo Query;

		public readonly FieldInfo Bundle;

		public readonly FieldInfo FileSystem;

		public readonly FieldInfo Records;

		public readonly FieldInfo CacheRoot;

		public readonly FieldInfo FileSize;

		public readonly FieldInfo FileCrc;

		public readonly PropertyInfo BundleGuid;

		public readonly PropertyInfo RecordDataPath;

		public readonly PropertyInfo RecordInfoPath;

		public readonly PropertyInfo RecordSize;

		public readonly PropertyInfo RecordCrc;

		public readonly MethodInfo GetMainBundleInfo;

		public readonly MethodInfo GetDataPath;

		public readonly MethodInfo GetInfoPath;

		public readonly MethodInfo WriteInfo;

		public readonly ConstructorInfo RecordConstructor;

		private readonly MethodInfo _appendDelta;

		private readonly MethodInfo _getDeltaPath;

		public StartupCacheAccess()
		{
			Assembly assembly = typeof(ResourcePackage).Assembly;
			CacheType = assembly.GetType("YooAsset.DefaultCacheFileSystem", throwOnError: true);
			Type type = assembly.GetType("YooAsset.BundleInfo", throwOnError: true);
			Type type2 = assembly.GetType("YooAsset.PackageBundle", throwOnError: true);
			Type type3 = assembly.GetType("YooAsset.RecordFileElement", throwOnError: true);
			Query = RequireField(typeof(ResourcePackage), "_bundleQuery");
			GetMainBundleInfo = RequireMethod(Query.FieldType, "GetMainBundleInfo");
			Bundle = RequireField(type, "Bundle");
			FileSystem = RequireField(type, "_fileSystem");
			Records = RequireField(CacheType, "_records");
			CacheRoot = RequireField(CacheType, "_cacheBundleFilesRoot");
			FileSize = RequireField(type2, "FileSize");
			FileCrc = RequireField(type2, "FileCRC");
			BundleGuid = RequireProperty(type2, "BundleGUID");
			RecordDataPath = RequireProperty(type3, "DataFilePath");
			RecordInfoPath = RequireProperty(type3, "InfoFilePath");
			RecordSize = RequireProperty(type3, "DataFileSize");
			RecordCrc = RequireProperty(type3, "DataFileCRC");
			GetDataPath = RequireMethod(CacheType, "GetBundleDataFilePath");
			GetInfoPath = RequireMethod(CacheType, "GetBundleInfoFilePath");
			WriteInfo = RequireMethod(CacheType, "WriteBundleInfoFile");
			_appendDelta = RequireMethod(CacheType, "AppendRecordDelta");
			_getDeltaPath = RequireMethod(CacheType, "GetCacheRecordDeltaFilePath");
			RecordConstructor = type3.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, new Type[4]
			{
				typeof(string),
				typeof(string),
				typeof(string),
				typeof(long)
			}, null) ?? throw new MissingMethodException(type3.FullName, ".ctor");
		}

		public void AppendChange(object fileSystem, bool add, string guid, string info, string data, string crc, long size)
		{
			string text = NormalizePath(_getDeltaPath.Invoke(fileSystem, null) as string);
			FileInfo fileInfo = new FileInfo(text);
			long num = (fileInfo.Exists ? fileInfo.Length : 0);
			_appendDelta.Invoke(fileSystem, new object[6] { add, guid, info, data, crc, size });
			FileInfo fileInfo2 = new FileInfo(text);
			if (!fileInfo2.Exists || fileInfo2.Length <= num)
			{
				throw new IOException("RawFile cache record delta was not persisted: " + text);
			}
			using FileStream fileStream = new FileStream(text, FileMode.Open, FileAccess.Read, FileShare.ReadWrite);
			using BinaryReader binaryReader = new BinaryReader(fileStream);
			fileStream.Position = num;
			if (binaryReader.ReadByte() != (add ? 1 : 2) || binaryReader.ReadString() != guid || (add && (binaryReader.ReadString() != info || binaryReader.ReadString() != data || binaryReader.ReadString() != (crc ?? string.Empty) || binaryReader.ReadInt64() != size)))
			{
				throw new IOException("RawFile cache record delta is incomplete: " + text);
			}
		}

		private static FieldInfo RequireField(Type type, string name)
		{
			return type.GetField(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) ?? throw new MissingFieldException(type.FullName, name);
		}

		private static PropertyInfo RequireProperty(Type type, string name)
		{
			return type.GetProperty(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) ?? throw new MissingMemberException(type.FullName, name);
		}

		private static MethodInfo RequireMethod(Type type, string name)
		{
			return type.GetMethod(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic) ?? throw new MissingMethodException(type.FullName, name);
		}
	}

	private const BindingFlags InstanceMembers = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

	private const int StartupBatchSize = 64;

	private static StartupCacheAccess _startupAccess;

	private static readonly StringComparison PathComparison = ((Path.DirectorySeparatorChar == '\\') ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);

	public static bool TryInvalidateMissingFile(ResourcePackage package, AssetInfo assetInfo, string loadError)
	{
		if (package == null || assetInfo == null || assetInfo.IsInvalid || string.IsNullOrEmpty(loadError))
		{
			return false;
		}
		if (!loadError.StartsWith("Faild rename raw data file : ", StringComparison.Ordinal) && !loadError.StartsWith("Failed to rename raw data file : ", StringComparison.Ordinal))
		{
			return false;
		}
		try
		{
			FieldInfo field = typeof(ResourcePackage).GetField("_bundleQuery", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			object obj = field?.GetValue(package);
			object obj2 = field?.FieldType.GetMethod("GetMainBundleInfo")?.Invoke(obj, new object[1] { assetInfo });
			if (obj2 == null)
			{
				return false;
			}
			Type type = obj2.GetType();
			object obj3 = type.GetField("Bundle", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(obj2);
			object obj4 = type.GetField("_fileSystem", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(obj2);
			Type type2 = typeof(ResourcePackage).Assembly.GetType("YooAsset.DefaultCacheFileSystem");
			if (obj3 == null || type2 == null || !type2.IsInstanceOfType(obj4))
			{
				return false;
			}
			IDictionary dictionary = type2.GetField("_records", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(obj4) as IDictionary;
			MethodInfo method = type2.GetMethod("AppendRecordDelta", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			MethodInfo method2 = type2.GetMethod("GetBundleDataFilePath", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			string text = obj3.GetType().GetProperty("BundleGUID")?.GetValue(obj3) as string;
			if (dictionary == null || method == null || method2 == null || string.IsNullOrEmpty(text))
			{
				return false;
			}
			object obj5 = dictionary[text];
			if (obj5 == null)
			{
				return false;
			}
			string text2 = obj5.GetType().GetProperty("DataFilePath")?.GetValue(obj5) as string;
			string text3 = method2.Invoke(obj4, new object[1] { obj3 }) as string;
			if (string.IsNullOrEmpty(text2) || string.IsNullOrEmpty(text3) || File.Exists(text2) || File.Exists(text3))
			{
				return false;
			}
			dictionary.Remove(text);
			method.Invoke(obj4, new object[6] { false, text, null, null, null, 0L });
			Debug.LogWarning("[RawFileCacheRecovery] Invalidated missing RawFile cache: " + text + "; retrying load.");
			return true;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[RawFileCacheRecovery] RawFile cache recovery failed: " + ex.GetBaseException().Message);
			return false;
		}
	}

	public static IEnumerator RepairStartupCache(ResourcePackage package, Action<float> onProgress = null)
	{
		if (package == null)
		{
			throw new ArgumentNullException("package");
		}
		StartupCacheAccess access = _startupAccess ?? (_startupAccess = new StartupCacheAccess());
		object query = access.Query.GetValue(package) ?? throw new InvalidOperationException("RawFile bundle query is not initialized.");
		AssetInfo[] assets = package.GetAllAssetInfos();
		HashSet<string> seen = new HashSet<string>(StringComparer.Ordinal);
		int preserved = 0;
		int rebound = 0;
		int invalidated = 0;
		int infoRepaired = 0;
		int unindexed = 0;
		int unsupported = 0;
		for (int index = 0; index < assets.Length; index++)
		{
			object obj = access.GetMainBundleInfo.Invoke(query, new object[1] { assets[index] }) ?? throw new InvalidOperationException("RawFile bundle info is missing.");
			object value = access.FileSystem.GetValue(obj);
			if (!access.CacheType.IsInstanceOfType(value))
			{
				unsupported++;
			}
			else
			{
				object obj2 = access.Bundle.GetValue(obj) ?? throw new InvalidOperationException("RawFile main bundle is missing.");
				string text = access.BundleGuid.GetValue(obj2) as string;
				if (string.IsNullOrEmpty(text))
				{
					throw new InvalidOperationException("RawFile bundle GUID is empty.");
				}
				if (seen.Add(text))
				{
					IDictionary dictionary = (access.Records.GetValue(value) as IDictionary) ?? throw new InvalidOperationException("RawFile cache records are unavailable.");
					object obj3 = dictionary[text];
					if (obj3 == null)
					{
						unindexed++;
					}
					else
					{
						string directory = NormalizePath(access.CacheRoot.GetValue(value) as string);
						string text2 = NormalizePath(access.GetDataPath.Invoke(value, new object[1] { obj2 }) as string);
						string text3 = NormalizePath(access.GetInfoPath.Invoke(value, new object[1] { obj2 }) as string);
						string directoryName = Path.GetDirectoryName(text2);
						if (!IsInsideDirectory(directory, text2) || !IsInsideDirectory(directory, text3) || !string.Equals(directoryName, Path.GetDirectoryName(text3), PathComparison))
						{
							throw new InvalidOperationException("RawFile cache path is outside the current bundle directory.");
						}
						long num = (long)access.FileSize.GetValue(obj2);
						string text4 = access.FileCrc.GetValue(obj2) as string;
						string text5 = access.RecordDataPath.GetValue(obj3) as string;
						string text6 = FindStartupCandidate(text2, text5, directoryName, num);
						if (text6 == null)
						{
							dictionary.Remove(text);
							try
							{
								access.AppendChange(value, add: false, text, null, null, null, 0L);
							}
							catch
							{
								dictionary[text] = obj3;
								throw;
							}
							invalidated++;
						}
						else
						{
							bool flag = IsSamePath(text5, text6) && IsSamePath(access.RecordInfoPath.GetValue(obj3) as string, text3) && (long)access.RecordSize.GetValue(obj3) == num && string.Equals(access.RecordCrc.GetValue(obj3) as string, text4, StringComparison.Ordinal);
							if (!File.Exists(text3) || !flag)
							{
								access.WriteInfo.Invoke(value, new object[3] { text3, text4, num });
								infoRepaired++;
							}
							if (flag)
							{
								preserved++;
							}
							else
							{
								object value2 = access.RecordConstructor.Invoke(new object[4] { text3, text6, text4, num });
								dictionary[text] = value2;
								try
								{
									access.AppendChange(value, add: true, text, text3, text6, text4, num);
								}
								catch
								{
									dictionary[text] = obj3;
									throw;
								}
								rebound++;
							}
						}
					}
				}
			}
			if ((index + 1) % 64 == 0)
			{
				onProgress?.Invoke((float)(index + 1) / (float)assets.Length);
				yield return null;
			}
		}
		onProgress?.Invoke(1f);
		Debug.Log($"[RawFileCacheRecovery] Startup cache checked: assets={assets.Length}, bundles={seen.Count}, " + $"preserved={preserved}, rebound={rebound}, invalidated={invalidated}, infoRepaired={infoRepaired}, " + $"unindexed={unindexed}, unsupported={unsupported}.");
	}

	private static string FindStartupCandidate(string target, string oldPath, string folder, long size)
	{
		FileInfo fileInfo = new FileInfo(target);
		if (fileInfo.Exists)
		{
			if (fileInfo.Length != size)
			{
				return null;
			}
			return target;
		}
		if (!string.IsNullOrEmpty(oldPath))
		{
			string text = NormalizePath(oldPath);
			if (string.Equals(Path.GetDirectoryName(text), folder, PathComparison) && HasExpectedSize(text, size))
			{
				return text;
			}
		}
		string text2 = Path.Combine(folder, "__data");
		if (HasExpectedSize(text2, size))
		{
			return text2;
		}
		if (!string.IsNullOrEmpty(oldPath))
		{
			text2 = Path.Combine(folder, Path.GetFileName(oldPath));
			if (HasExpectedSize(text2, size))
			{
				return text2;
			}
		}
		return null;
	}

	private static bool HasExpectedSize(string path, long size)
	{
		FileInfo fileInfo = new FileInfo(path);
		if (fileInfo.Exists)
		{
			return fileInfo.Length == size;
		}
		return false;
	}

	private static string NormalizePath(string path)
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new InvalidOperationException("RawFile cache path is empty.");
		}
		return Path.GetFullPath(path);
	}

	private static bool IsSamePath(string path, string expected)
	{
		if (!string.IsNullOrEmpty(path))
		{
			return string.Equals(NormalizePath(path), expected, PathComparison);
		}
		return false;
	}

	private static bool IsInsideDirectory(string directory, string path)
	{
		string text = directory.TrimEnd(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar);
		char directorySeparatorChar = Path.DirectorySeparatorChar;
		string value = text + directorySeparatorChar;
		return path.StartsWith(value, PathComparison);
	}
}
