using System.Collections.Generic;

namespace Ase;

public class StoryDialogueViewModel : OptionBase
{
	private List<StoryDialogue> _storyDialogues = new List<StoryDialogue>();

	public List<StoryDialogue> StoryDialogues => _storyDialogues;

	public StoryDialogueViewModel()
	{
	}

	public StoryDialogueViewModel(List<StoryDialogue> dialogues)
	{
		_storyDialogues = dialogues;
	}

	public void RefreshData(List<StoryDialogue> dialogues)
	{
		_storyDialogues = dialogues;
	}
}
