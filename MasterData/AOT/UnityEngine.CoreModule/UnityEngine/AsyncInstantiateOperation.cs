using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/GameCode/AsyncInstantiate/AsyncInstantiateOperation.h")]
[RequiredByNativeCode]
public class AsyncInstantiateOperation : AsyncOperation
{
	internal Object[] m_Result;
}
[ExcludeFromDocs]
public class AsyncInstantiateOperation<T> : CustomYieldInstruction where T : Object
{
	internal AsyncInstantiateOperation m_op;

	public override bool keepWaiting => !m_op.isDone;

	internal AsyncInstantiateOperation(AsyncInstantiateOperation op)
	{
		m_op = op;
	}
}
