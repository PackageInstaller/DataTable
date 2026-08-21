using GameFramework.Runtime;

namespace Ase;

public class RedPointMessage : MessageBase
{
	private RedPointMessageEnum type;

	private bool state;

	public RedPointMessageEnum Type => type;

	public bool State => state;

	public RedPointMessage(object sender, RedPointMessageEnum type, bool state = false)
		: base(sender)
	{
		this.type = type;
		this.state = state;
	}
}
