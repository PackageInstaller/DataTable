using GameFramework.Runtime;

namespace Ase;

public class OpActivityMessage : MessageBase
{
	private OpActivityMessageEnum type;

	private object arg;

	public OpActivityMessageEnum Type => type;

	public object Arg => arg;

	public OpActivityMessage(object sender, OpActivityMessageEnum type, object arg = null)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
