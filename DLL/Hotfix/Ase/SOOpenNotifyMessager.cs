using GameFramework.Runtime;

namespace Ase;

public class SOOpenNotifyMessager : MessageBase
{
	public int serviceId;

	public bool state;

	public SOOpenNotifyMessager(object sender)
		: base(sender)
	{
	}
}
