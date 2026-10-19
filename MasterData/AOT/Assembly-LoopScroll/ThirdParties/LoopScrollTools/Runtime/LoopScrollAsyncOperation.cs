using System;
using System.Collections.Generic;

namespace ThirdParties.LoopScrollTools.Runtime;

public class LoopScrollAsyncOperation
{
	public static class LoopScrollAsyncOperationPool
	{
		private static Stack<LoopScrollAsyncOperation> m_Pool = new Stack<LoopScrollAsyncOperation>();

		public static LoopScrollAsyncOperation Get()
		{
			LoopScrollAsyncOperation loopScrollAsyncOperation = ((m_Pool.Count > 0) ? m_Pool.Pop() : new LoopScrollAsyncOperation());
			loopScrollAsyncOperation.IsValid = true;
			loopScrollAsyncOperation.Complete = null;
			return loopScrollAsyncOperation;
		}

		public static void Release(LoopScrollAsyncOperation toRelease)
		{
			m_Pool.Push(toRelease);
			toRelease.IsValid = false;
		}
	}

	public bool IsValid { get; protected set; }

	public Action<LoopScrollAsyncOperation> Complete { get; set; }

	public LoopScrollAsyncOperation OnComplete()
	{
		Complete?.Invoke(this);
		return this;
	}
}
