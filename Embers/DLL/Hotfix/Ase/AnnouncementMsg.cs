using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class AnnouncementMsg : MessageBase
{
	public List<long> unReadList;

	public AnnouncementMsg(object sender, List<long> unReadList)
		: base(sender)
	{
		this.unReadList = unReadList;
	}
}
