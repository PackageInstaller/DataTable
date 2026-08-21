namespace Ase;

public class ChapterCopyStarInfo
{
	private int difficulty;

	private int copyId;

	private int star;

	public int Difficulty => difficulty;

	public int CopyId => copyId;

	public int Star => star;

	public ChapterCopyStarInfo(int difficulty, int copyId, int star)
	{
		this.difficulty = difficulty;
		this.copyId = copyId;
		this.star = star;
	}
}
