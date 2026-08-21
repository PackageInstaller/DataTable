namespace Ase;

public class StoryTipViewModel : OptionBase
{
	private StoryPopTipViewModel storyPopTipViewModel;

	private StoryPopTipViewModel taskPopTipViewModel;

	public StoryPopTipViewModel StoryPopTipViewModel => storyPopTipViewModel;

	public StoryPopTipViewModel TaskPopTipViewModel => taskPopTipViewModel;

	public StoryTipViewModel()
	{
		storyPopTipViewModel = new StoryPopTipViewModel();
		taskPopTipViewModel = new StoryPopTipViewModel();
	}

	public void PlayQueueTip(PopupTipType type, int queueId)
	{
		switch (type)
		{
		case PopupTipType.Story:
			storyPopTipViewModel.StartPopTip(queueId);
			break;
		case PopupTipType.Task:
			taskPopTipViewModel.StartPopTip(queueId);
			break;
		}
	}

	public void PopupUpdate()
	{
		if (storyPopTipViewModel.GetIsPlaying())
		{
			storyPopTipViewModel.PopupUpdate();
		}
		if (taskPopTipViewModel.GetIsPlaying())
		{
			taskPopTipViewModel.PopupUpdate();
		}
	}

	public void StopPopTip()
	{
		if (storyPopTipViewModel != null && storyPopTipViewModel.GetIsPlaying())
		{
			storyPopTipViewModel.StopPopTip();
		}
		if (taskPopTipViewModel != null && taskPopTipViewModel.GetIsPlaying())
		{
			taskPopTipViewModel.StopPopTip();
		}
		Close();
	}
}
