namespace ACT.Event;

public class SnapshotTeamCharacterChange : BaseEventContent
{
	public int[] beforeCharactersId;

	public int[] afterCharactersId;
}
