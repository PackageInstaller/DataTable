using System;
using System.Runtime.InteropServices;

public class CriFsBinder : CriDisposable
{
	public enum Status
	{
		None,
		Analyze,
		Complete,
		Unbind,
		Removed,
		Invalid,
		Error
	}

	public struct ContentsFileInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string directory;

		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string fileName;

		public uint readSize;

		public uint extractSize;

		public ulong offset;

		public int fileId;

		[MarshalAs(UnmanagedType.LPStr)]
		private string userStr;

		public ContentsFileInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				directory = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				fileName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 4)));
				readSize = BitConverter.ToUInt32(data, startIndex + 8);
				extractSize = BitConverter.ToUInt32(data, startIndex + 12);
				offset = BitConverter.ToUInt64(data, startIndex + 16);
				fileId = BitConverter.ToInt32(data, startIndex + 24);
				userStr = null;
			}
			else
			{
				directory = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				fileName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 8)));
				readSize = BitConverter.ToUInt32(data, startIndex + 16);
				extractSize = BitConverter.ToUInt32(data, startIndex + 20);
				offset = BitConverter.ToUInt64(data, startIndex + 24);
				fileId = BitConverter.ToInt32(data, startIndex + 32);
				userStr = null;
			}
		}
	}

	private IntPtr handle;

	public IntPtr nativeHandle => handle;

	public CriFsBinder()
	{
		if (!CriFsPlugin.IsLibraryInitialized())
		{
			throw new Exception("CriFsPlugin is not initialized.");
		}
		handle = IntPtr.Zero;
		criFsBinder_Create(out handle);
		if (handle == IntPtr.Zero)
		{
			throw new Exception("criFsBinder_Create() failed.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	public override void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (handle != IntPtr.Zero)
		{
			criFsBinder_Destroy(handle);
			handle = IntPtr.Zero;
		}
	}

	public uint BindCpk(CriFsBinder srcBinder, string path)
	{
		uint bindId = 0u;
		if (handle != IntPtr.Zero)
		{
			criFsBinder_BindCpk(handle, srcBinder?.nativeHandle ?? IntPtr.Zero, path, IntPtr.Zero, 0, out bindId);
		}
		return bindId;
	}

	public uint BindDirectory(CriFsBinder srcBinder, string path)
	{
		uint bindId = 0u;
		if (handle != IntPtr.Zero)
		{
			criFsBinder_BindDirectory(handle, srcBinder?.nativeHandle ?? IntPtr.Zero, path, IntPtr.Zero, 0, out bindId);
		}
		return bindId;
	}

	public uint BindFile(CriFsBinder srcBinder, string path)
	{
		uint bindId = 0u;
		criFsBinder_BindFile(handle, srcBinder?.nativeHandle ?? IntPtr.Zero, path, IntPtr.Zero, 0, out bindId);
		return bindId;
	}

	public uint BindFileSection(CriFsBinder srcBinder, string path, ulong offset, int size, string sectionName)
	{
		uint bindId = 0u;
		if (handle != IntPtr.Zero)
		{
			criFsBinder_BindFileSection(handle, srcBinder?.nativeHandle ?? IntPtr.Zero, path, offset, size, sectionName, IntPtr.Zero, 0, out bindId);
		}
		return bindId;
	}

	public static void Unbind(uint bindId)
	{
		if (CriFsPlugin.IsLibraryInitialized())
		{
			criFsBinder_Unbind(bindId);
		}
	}

	public static Status GetStatus(uint bindId)
	{
		Status status = Status.Removed;
		if (CriFsPlugin.IsLibraryInitialized())
		{
			criFsBinder_GetStatus(bindId, out status);
		}
		return status;
	}

	public long GetFileSize(string path)
	{
		long size = -1L;
		if (handle != IntPtr.Zero && criFsBinder_GetFileSize(handle, path, out size) != 0)
		{
			return -1L;
		}
		return size;
	}

	public long GetFileSize(int id)
	{
		long size = -1L;
		if (handle != IntPtr.Zero && criFsBinder_GetFileSizeById(handle, id, out size) != 0)
		{
			return -1L;
		}
		return size;
	}

	public bool GetContentsFileInfo(string path, out ContentsFileInfo info)
	{
		using CriStructMemory<ContentsFileInfo> criStructMemory = new CriStructMemory<ContentsFileInfo>();
		int num = criFsBinder_GetContentsFileInfo(handle, path, criStructMemory.ptr);
		info = new ContentsFileInfo(criStructMemory.bytes, 0);
		return num == 0;
	}

	public bool GetContentsFileInfo(int id, out ContentsFileInfo info)
	{
		using CriStructMemory<ContentsFileInfo> criStructMemory = new CriStructMemory<ContentsFileInfo>();
		int num = criFsBinder_GetContentsFileInfoById(handle, id, criStructMemory.ptr);
		info = new ContentsFileInfo(criStructMemory.bytes, 0);
		return num == 0;
	}

	public static bool GetContentsFileInfoByIndex(uint bindId, int index, int numFiles, out ContentsFileInfo[] info)
	{
		if (index < 0 || numFiles <= 0)
		{
			throw new Exception("Invalid parameters.");
		}
		info = new ContentsFileInfo[numFiles];
		using CriStructMemory<ContentsFileInfo> criStructMemory = new CriStructMemory<ContentsFileInfo>(numFiles);
		int num = criFsBinder_GetContentsFileInfoByIndex(bindId, index, criStructMemory.ptr, numFiles);
		for (int i = 0; i < numFiles; i++)
		{
			info[i] = new ContentsFileInfo(criStructMemory.bytes, i * Marshal.SizeOf(typeof(ContentsFileInfo)));
		}
		return num == 0;
	}

	public static int GetNumContentsFiles(uint bindId)
	{
		return CRIWARE7B222EA4(bindId);
	}

	public static void SetPriority(uint bindId, int priority)
	{
		if (CriFsPlugin.IsLibraryInitialized())
		{
			criFsBinder_SetPriority(bindId, priority);
		}
	}

	~CriFsBinder()
	{
		Dispose(disposing: false);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_Create(out IntPtr binder);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_Destroy(IntPtr binder);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_BindCpk(IntPtr binder, IntPtr srcBinder, string path, IntPtr work, int worksize, out uint bindId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_BindDirectory(IntPtr binder, IntPtr srcBinder, string path, IntPtr work, int worksize, out uint bindId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_BindFile(IntPtr binder, IntPtr srcBinder, string path, IntPtr work, int worksize, out uint bindId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criFsBinder_BindFileSection(IntPtr binder, IntPtr srcBinder, string path, ulong offset, int size, string sectionName, IntPtr work, int worksize, out uint bindId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_Unbind(uint bindId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetStatus(uint bindId, out Status status);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetFileSize(IntPtr binder, string path, out long size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetFileSizeById(IntPtr binder, int id, out long size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_SetPriority(uint bindId, int priority);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetContentsFileInfo(IntPtr binder, string path, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetContentsFileInfoById(IntPtr binder, int id, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criFsBinder_GetContentsFileInfoByIndex(uint id, int index, IntPtr info, int num);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int CRIWARE7B222EA4(uint id);
}
