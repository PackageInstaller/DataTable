using System;
using System.Collections.Generic;
using UnityEngine;

public static class CriDisposableObjectManager
{
	public enum ModuleType
	{
		Atom,
		AtomMic,
		Fs,
		FsWeb,
		Mana,
		Lips,
		Vip,
		Rtc
	}

	public struct ObjectRef(Guid _guid, CriDisposable _disposable, ModuleType _type)
	{
		public Guid guid = _guid;

		public ModuleType type = _type;

		public CriDisposable disposable = _disposable;
	}

	private static List<ObjectRef> refList = new List<ObjectRef>();

	private static int SearchForDisposable(CriDisposable disposable)
	{
		lock (refList)
		{
			for (int num = refList.Count - 1; num >= 0; num--)
			{
				if (refList[num].guid == disposable.guid)
				{
					return num;
				}
			}
		}
		return -1;
	}

	public static void Register(CriDisposable disposable, ModuleType type)
	{
		if (SearchForDisposable(disposable) >= 0)
		{
			Debug.LogWarning("[CRIWARE] Internal: Duplicated object GUID");
			return;
		}
		lock (refList)
		{
			refList.Add(new ObjectRef(disposable.guid, disposable, type));
		}
	}

	public static bool Unregister(CriDisposable disposable)
	{
		lock (refList)
		{
			int num = SearchForDisposable(disposable);
			if (num >= 0)
			{
				refList.RemoveAt(num);
				return true;
			}
		}
		return false;
	}

	public static bool IsDisposed(CriDisposable disposable)
	{
		return SearchForDisposable(disposable) < 0;
	}

	public static void CallOnModuleFinalization(ModuleType type)
	{
		DisposeAll(type);
	}

	private static int GetNextWithType(ModuleType type)
	{
		for (int num = refList.Count - 1; num >= 0; num--)
		{
			if (refList[num].type == type)
			{
				return num;
			}
		}
		return -1;
	}

	public static void DisposeAll(ModuleType type)
	{
		lock (refList)
		{
			while (true)
			{
				int nextWithType = GetNextWithType(type);
				if (nextWithType < 0)
				{
					break;
				}
				CriDisposable disposable = refList[nextWithType].disposable;
				if (disposable != null)
				{
					disposable.Dispose();
					continue;
				}
				Debug.LogWarning("[CRIWARE] Internal: Object disposal(Type:" + refList[nextWithType].type.ToString() + ") not handled by CriDisposableObjectManager; memory leak may have occured.");
				refList.RemoveAt(nextWithType);
			}
		}
	}
}
