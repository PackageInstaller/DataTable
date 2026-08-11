using GameFramework.Runtime;

namespace Ase;

public class SocialMessage : MessageBase
{
	private SocialMessageEnum type;

	private object arg;

	public SocialMessageEnum Type => type;

	public object Arg => arg;

	public SocialMessage(object sender, SocialMessageEnum type, object arg)
		: base(sender)
	{
		this.type = type;
		this.arg = arg;
	}
}
