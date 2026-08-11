using GameFramework.Runtime;

namespace Ase;

public class ShopMessage : MessageBase
{
	private ShopMessageEnum type;

	private object arg;

	public ShopMessageEnum Type => type;

	public object Arg => arg;

	public ShopMessage(object sender, ShopMessageEnum type, object arg)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
