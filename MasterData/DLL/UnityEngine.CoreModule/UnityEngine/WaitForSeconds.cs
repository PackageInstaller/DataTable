using System.Runtime.InteropServices;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
public sealed class WaitForSeconds : YieldInstruction
{
	internal float m_Seconds;

	public WaitForSeconds(float seconds)
	{
		m_Seconds = seconds;
	}
}
