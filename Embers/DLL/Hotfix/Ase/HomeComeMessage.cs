using GameFramework.Runtime;

namespace Ase;

public class HomeComeMessage : MessageBase
{
	public HomeComeMessageEnum Type { get; }

	public object Arg { get; }

	public HomeComeMessage(object sender, HomeComeMessageEnum type, object arg = null)
		: base(sender)
	{
		Type = type;
		Arg = arg;
	}
}
