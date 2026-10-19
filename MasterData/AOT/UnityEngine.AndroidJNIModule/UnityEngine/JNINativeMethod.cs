using System;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeType(CodegenOptions.Custom, "ScriptingJNINativeMethod")]
public struct JNINativeMethod
{
	public string name;

	public string signature;

	public IntPtr fnPtr;
}
