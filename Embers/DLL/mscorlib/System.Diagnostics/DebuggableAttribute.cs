using System.Runtime.InteropServices;

namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Module, AllowMultiple = false)]
[ComVisible(true)]
public sealed class DebuggableAttribute : Attribute
{
	[Flags]
	[ComVisible(true)]
	public enum DebuggingModes
	{
		None = 0,
		Default = 1,
		DisableOptimizations = 0x100,
		IgnoreSymbolStoreSequencePoints = 2,
		EnableEditAndContinue = 4
	}

	private DebuggingModes m_debuggingModes;

	public bool IsJITTrackingEnabled => (m_debuggingModes & DebuggingModes.Default) != 0;

	public bool IsJITOptimizerDisabled => (m_debuggingModes & DebuggingModes.DisableOptimizations) != 0;

	public DebuggingModes DebuggingFlags => m_debuggingModes;

	public DebuggableAttribute(bool isJITTrackingEnabled, bool isJITOptimizerDisabled)
	{
		m_debuggingModes = DebuggingModes.None;
		if (isJITTrackingEnabled)
		{
			m_debuggingModes |= DebuggingModes.Default;
		}
		if (isJITOptimizerDisabled)
		{
			m_debuggingModes |= DebuggingModes.DisableOptimizations;
		}
	}

	public DebuggableAttribute(DebuggingModes modes)
	{
		m_debuggingModes = modes;
	}
}
