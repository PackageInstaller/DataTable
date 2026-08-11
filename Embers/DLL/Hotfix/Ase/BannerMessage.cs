using GameFramework.Runtime;

namespace Ase;

public class BannerMessage : MessageBase
{
	private BannerMessageEnum type;

	private object arg;

	public BannerMessageEnum Type => type;

	public object Arg => arg;

	public BannerMessage(object sender, BannerMessageEnum type, object arg)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
