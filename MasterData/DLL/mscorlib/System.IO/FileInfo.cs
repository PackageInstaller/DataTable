using System.Runtime.Serialization;
using System.Security.AccessControl;
using System.Text;

namespace System.IO;

[Serializable]
public sealed class FileInfo : FileSystemInfo
{
	public long Length
	{
		get
		{
			if ((base.Attributes & FileAttributes.Directory) == FileAttributes.Directory)
			{
				throw new FileNotFoundException(SR.Format("Could not find file '{0}'.", FullPath), FullPath);
			}
			return base.LengthCore;
		}
	}

	public string DirectoryName => Path.GetDirectoryName(FullPath);

	public DirectoryInfo Directory
	{
		get
		{
			string directoryName = DirectoryName;
			if (directoryName == null)
			{
				return null;
			}
			return new DirectoryInfo(directoryName);
		}
	}

	public bool IsReadOnly
	{
		get
		{
			return (base.Attributes & FileAttributes.ReadOnly) != 0;
		}
		set
		{
			if (value)
			{
				base.Attributes |= FileAttributes.ReadOnly;
			}
			else
			{
				base.Attributes &= ~FileAttributes.ReadOnly;
			}
		}
	}

	public override string Name => _name;

	private FileInfo()
	{
	}

	public FileInfo(string fileName)
		: this(fileName, null, null, false)
	{
	}

	internal FileInfo(string originalPath, string fullPath = null, string fileName = null, bool isNormalized = false)
	{
		OriginalPath = originalPath ?? throw new ArgumentNullException("fileName");
		fullPath = fullPath ?? originalPath;
		FullPath = (isNormalized ? (fullPath ?? originalPath) : Path.GetFullPath(fullPath));
		_name = fileName ?? Path.GetFileName(originalPath);
	}

	public StreamReader OpenText()
	{
		return new StreamReader(base.NormalizedPath, Encoding.UTF8, detectEncodingFromByteOrderMarks: true);
	}

	public StreamWriter CreateText()
	{
		return new StreamWriter(base.NormalizedPath, append: false);
	}

	public StreamWriter AppendText()
	{
		return new StreamWriter(base.NormalizedPath, append: true);
	}

	public FileInfo CopyTo(string destFileName)
	{
		return CopyTo(destFileName, overwrite: false);
	}

	public FileInfo CopyTo(string destFileName, bool overwrite)
	{
		if (destFileName == null)
		{
			throw new ArgumentNullException("destFileName", "File name cannot be null.");
		}
		if (destFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destFileName");
		}
		string fullPath = Path.GetFullPath(destFileName);
		FileSystem.CopyFile(FullPath, fullPath, overwrite);
		return new FileInfo(fullPath, null, null, isNormalized: true);
	}

	public FileStream Create()
	{
		return File.Create(base.NormalizedPath);
	}

	public override void Delete()
	{
		FileSystem.DeleteFile(FullPath);
	}

	public FileStream Open(FileMode mode)
	{
		return Open(mode, (mode == FileMode.Append) ? FileAccess.Write : FileAccess.ReadWrite, FileShare.None);
	}

	public FileStream Open(FileMode mode, FileAccess access)
	{
		return Open(mode, access, FileShare.None);
	}

	public FileStream Open(FileMode mode, FileAccess access, FileShare share)
	{
		return new FileStream(base.NormalizedPath, mode, access, share);
	}

	public FileStream OpenRead()
	{
		return new FileStream(base.NormalizedPath, FileMode.Open, FileAccess.Read, FileShare.Read, 4096, useAsync: false);
	}

	public FileStream OpenWrite()
	{
		return new FileStream(base.NormalizedPath, FileMode.OpenOrCreate, FileAccess.Write, FileShare.None);
	}

	public void MoveTo(string destFileName)
	{
		if (destFileName == null)
		{
			throw new ArgumentNullException("destFileName");
		}
		if (destFileName.Length == 0)
		{
			throw new ArgumentException("Empty file name is not legal.", "destFileName");
		}
		string fullPath = Path.GetFullPath(destFileName);
		if (!new DirectoryInfo(Path.GetDirectoryName(FullName)).Exists)
		{
			throw new DirectoryNotFoundException(SR.Format("Could not find a part of the path '{0}'.", FullName));
		}
		if (!Exists)
		{
			throw new FileNotFoundException(SR.Format("Could not find file '{0}'.", FullName), FullName);
		}
		FileSystem.MoveFile(FullPath, fullPath);
		FullPath = fullPath;
		OriginalPath = destFileName;
		_name = Path.GetFileName(fullPath);
		Invalidate();
	}

	public FileInfo Replace(string destinationFileName, string destinationBackupFileName)
	{
		return Replace(destinationFileName, destinationBackupFileName, ignoreMetadataErrors: false);
	}

	public FileInfo Replace(string destinationFileName, string destinationBackupFileName, bool ignoreMetadataErrors)
	{
		if (destinationFileName == null)
		{
			throw new ArgumentNullException("destinationFileName");
		}
		FileSystem.ReplaceFile(FullPath, Path.GetFullPath(destinationFileName), (destinationBackupFileName != null) ? Path.GetFullPath(destinationBackupFileName) : null, ignoreMetadataErrors);
		return new FileInfo(destinationFileName);
	}

	public void Decrypt()
	{
		File.Decrypt(FullPath);
	}

	public void Encrypt()
	{
		File.Encrypt(FullPath);
	}

	private FileInfo(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	public FileSecurity GetAccessControl()
	{
		return File.GetAccessControl(FullPath, AccessControlSections.Access | AccessControlSections.Owner | AccessControlSections.Group);
	}

	public FileSecurity GetAccessControl(AccessControlSections includeSections)
	{
		return File.GetAccessControl(FullPath, includeSections);
	}

	public void SetAccessControl(FileSecurity fileSecurity)
	{
		File.SetAccessControl(FullPath, fileSecurity);
	}

	internal FileInfo(string fullPath, bool ignoreThis)
	{
		_name = Path.GetFileName(fullPath);
		OriginalPath = _name;
		FullPath = fullPath;
	}
}
