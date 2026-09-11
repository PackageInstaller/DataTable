using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
internal class AsyncInstantiateOperationHelper
{
	[RequiredByNativeCode]
	public static void SetAsyncInstantiateOperationResult(AsyncInstantiateOperation op, Object[] result)
	{
		op.m_Result = result;
	}
}
