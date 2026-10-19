using System;
using System.Collections.Generic;

namespace YooAsset;

public class FileSystemParameters
{
	internal readonly Dictionary<string, object> CreateParameters = new Dictionary<string, object>(100);

	public string FileSystemClass { get; private set; }

	public string PackageRoot { get; private set; }

	public FileSystemParameters(string fileSystemClass, string packageRoot)
	{
		FileSystemClass = fileSystemClass;
		PackageRoot = packageRoot;
	}

	public void AddParameter(string name, object value)
	{
		CreateParameters.Add(name, value);
	}

	internal IFileSystem CreateFileSystem(string packageName)
	{
		Type type = Type.GetType(FileSystemClass);
		if (type == null)
		{
			YooLogger.Error("Can not found file system class type " + FileSystemClass);
			return null;
		}
		IFileSystem fileSystem = (IFileSystem)Activator.CreateInstance(type, nonPublic: true);
		if (fileSystem == null)
		{
			YooLogger.Error("Failed to create file system instance " + FileSystemClass);
			return null;
		}
		foreach (KeyValuePair<string, object> createParameter in CreateParameters)
		{
			fileSystem.SetParameter(createParameter.Key, createParameter.Value);
		}
		fileSystem.OnCreate(packageName, PackageRoot);
		return fileSystem;
	}

	public static FileSystemParameters CreateDefaultEditorFileSystemParameters(string packageRoot)
	{
		return new FileSystemParameters(typeof(DefaultEditorFileSystem).FullName, packageRoot);
	}

	public static FileSystemParameters CreateDefaultBuildinFileSystemParameters(IDecryptionServices decryptionServices = null, string packageRoot = null)
	{
		FileSystemParameters fileSystemParameters = new FileSystemParameters(typeof(DefaultBuildinFileSystem).FullName, packageRoot);
		fileSystemParameters.AddParameter("DECRYPTION_SERVICES", decryptionServices);
		return fileSystemParameters;
	}

	public static FileSystemParameters CreateDefaultCacheFileSystemParameters(IRemoteServices remoteServices, IDecryptionServices decryptionServices = null, string packageRoot = null)
	{
		FileSystemParameters fileSystemParameters = new FileSystemParameters(typeof(DefaultCacheFileSystem).FullName, packageRoot);
		fileSystemParameters.AddParameter("REMOTE_SERVICES", remoteServices);
		fileSystemParameters.AddParameter("DECRYPTION_SERVICES", decryptionServices);
		return fileSystemParameters;
	}

	public static FileSystemParameters CreateDefaultWebServerFileSystemParameters(IWebDecryptionServices decryptionServices = null, bool disableUnityWebCache = false)
	{
		FileSystemParameters fileSystemParameters = new FileSystemParameters(typeof(DefaultWebServerFileSystem).FullName, null);
		fileSystemParameters.AddParameter("DECRYPTION_SERVICES", decryptionServices);
		fileSystemParameters.AddParameter("DISABLE_UNITY_WEB_CACHE", disableUnityWebCache);
		return fileSystemParameters;
	}

	public static FileSystemParameters CreateDefaultWebRemoteFileSystemParameters(IRemoteServices remoteServices, IWebDecryptionServices decryptionServices = null, bool disableUnityWebCache = false)
	{
		FileSystemParameters fileSystemParameters = new FileSystemParameters(typeof(DefaultWebRemoteFileSystem).FullName, null);
		fileSystemParameters.AddParameter("REMOTE_SERVICES", remoteServices);
		fileSystemParameters.AddParameter("DECRYPTION_SERVICES", decryptionServices);
		fileSystemParameters.AddParameter("DISABLE_UNITY_WEB_CACHE", disableUnityWebCache);
		return fileSystemParameters;
	}
}
