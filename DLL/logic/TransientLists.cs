using System;
using System.Collections.Generic;

internal static class TransientLists
{
	private static class ListPool<T>
	{
		private static object sLock;

		private static Stack<List<T>> sPool;

		static ListPool()
		{
			sLock = new object();
			sPool = null;
		}

		public static List<T> GetList()
		{
			lock (sLock)
			{
				XLogger.Assert(sPool != null, "[RZ] Trying to access from a list pool that was not initialized!");
				XLogger.Assert(sPool == null || sPool.Count > 0, "[RZ] Using more pools than available!");
				if (sPool.Count <= 0)
				{
					throw new InvalidOperationException("Not enough lists for this type are available!");
				}
				return sPool.Pop();
			}
		}

		public static void Initialize(int listCount, int listCapacity)
		{
			lock (sLock)
			{
				if (sPool == null)
				{
					sPool = new Stack<List<T>>(listCount);
					for (int i = 0; i < listCount; i++)
					{
						sPool.Push(new List<T>(listCapacity));
					}
				}
				else
				{
					XLogger.Assert(condition: false, "[RZ] Trying to initialize a list pool that was already initialized!");
				}
			}
		}

		public static void ReturnList(List<T> listToReturn)
		{
			lock (sLock)
			{
				XLogger.Assert(sPool != null, "[RZ] Trying to access a list pool that is not initialized!");
				XLogger.Assert(listToReturn != null, "[RZ] Trying to return a null list to the pool!");
				XLogger.Assert(!sPool.Contains(listToReturn), "[RZ] Returning a list to the pool more than once!");
				if (listToReturn != null)
				{
					listToReturn.Clear();
					sPool.Push(listToReturn);
				}
			}
		}

		public static void Shutdown()
		{
			lock (sLock)
			{
				XLogger.Assert(sPool != null, "[RZ] Trying to release a list pool that was not initialized!");
				if (sPool != null)
				{
					while (sPool.Count > 0)
					{
						sPool.Pop().Clear();
					}
					sPool = null;
				}
			}
		}
	}

	public static List<T> GetList<T>()
	{
		return ListPool<T>.GetList();
	}

	public static void Initialize()
	{
		ListPool<int>.Initialize(6, 300);
		ListPool<CommanderID>.Initialize(1, 200);
	}

	public static void Release()
	{
		ListPool<int>.Shutdown();
		ListPool<CommanderID>.Shutdown();
	}

	public static void ReturnList<T>(List<T> list)
	{
		ListPool<T>.ReturnList(list);
	}
}
