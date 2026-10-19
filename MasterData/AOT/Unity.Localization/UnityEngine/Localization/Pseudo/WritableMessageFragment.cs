using System.Diagnostics;

namespace UnityEngine.Localization.Pseudo;

[DebuggerDisplay("Writable: {Text}")]
public class WritableMessageFragment : MessageFragment
{
	public string Text
	{
		get
		{
			return ToString();
		}
		set
		{
			Initialize(Message, value);
		}
	}
}
