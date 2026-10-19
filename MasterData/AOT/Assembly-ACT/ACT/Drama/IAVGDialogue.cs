using Cysharp.Threading.Tasks;

namespace ACT.Drama;

public interface IAVGDialogue
{
	int StoryGroupId { get; }

	DialogueInputHandle RegisterInputHandler(IDialogueInputHandler handler);

	UniTask BeginSkip();
}
