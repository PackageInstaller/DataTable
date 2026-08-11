namespace Ase;

public interface IBoardPart : IBoardPartContextSource, IBoardPartActionEntryProvider
{
	bool CheckFrequentlyUsed { get; }

	ISpinePlayCommand PlayCommand { get; }

	void Init();
}
