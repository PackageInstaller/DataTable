using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public class BattlePropGetShowEvent : PopupEvent
{
	private BattlePropGetViewModel battlePropGetViewModel;

	public BattlePropGetViewModel BattlePropGetViewModel => battlePropGetViewModel;

	public BattlePropGetShowEvent(BattlePropGetViewModel battlePropGetViewModel, Func<UniTask> showEvent)
		: base(showEvent)
	{
		this.battlePropGetViewModel = battlePropGetViewModel;
	}
}
