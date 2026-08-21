using GameFramework.Runtime;

namespace Ase;

public class HeroMessage : MessageBase
{
	private HeroMessageEnum type;

	private object arg;

	public HeroMessageEnum Type => type;

	public object Arg => arg;

	public HeroMessage(object sender, HeroMessageEnum type, object arg)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
