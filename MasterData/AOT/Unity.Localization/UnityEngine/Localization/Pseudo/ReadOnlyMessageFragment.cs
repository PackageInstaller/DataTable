using System.Diagnostics;

namespace UnityEngine.Localization.Pseudo;

[DebuggerDisplay("ReadOnly: {Text}")]
public class ReadOnlyMessageFragment : MessageFragment
{
	public string Text => ToString();
}
