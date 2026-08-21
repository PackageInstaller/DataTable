using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public abstract class PopupEvent
{
	protected Func<UniTask> showEvent;

	public PopupEvent(Func<UniTask> showEvent)
	{
		this.showEvent = showEvent;
	}

	public async UniTask Execute(Action callback)
	{
		await showEvent();
		callback();
	}
}
