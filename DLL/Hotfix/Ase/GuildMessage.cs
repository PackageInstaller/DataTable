using GameFramework.Runtime;

namespace Ase;

public class GuildMessage : MessageBase
{
	private GuildMessageEnum type;

	private object arg;

	public GuildMessageEnum Type => type;

	public object Arg => arg;

	public GuildMessage(object sender, GuildMessageEnum type, object arg)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
