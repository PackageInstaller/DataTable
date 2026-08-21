using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public class KillRewardShowEvent : PopupEvent
{
	public KillRewardShowEvent(Func<UniTask> showEvent)
		: base(showEvent)
	{
	}
}
