using System.Runtime.InteropServices;

namespace System;

[StructLayout(LayoutKind.Sequential)]
internal class MonoAsyncCall
{
	private object msg;

	private IntPtr cb_method;

	private object cb_target;

	private object state;

	private object res;

	private object out_args;
}
