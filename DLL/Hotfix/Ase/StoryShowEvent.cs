using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public class StoryShowEvent
{
	private int storyId;

	private Func<UniTask> showEvent;

	private StoryViewModel storyViewModel;

	public StoryViewModel ViewModel => storyViewModel;

	public StoryShowEvent(int storyId)
	{
		this.storyId = storyId;
	}

	public void SetFunc(Func<UniTask> showEvent)
	{
		this.showEvent = showEvent;
	}

	public void SetViewModel(StoryViewModel storyViewModel)
	{
		this.storyViewModel = storyViewModel;
	}

	public async UniTask Execute(Action callback)
	{
		await showEvent();
		callback();
	}

	public void Dispose()
	{
		storyViewModel.Dispose();
		storyViewModel = null;
	}
}
