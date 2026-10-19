using System;

namespace ACT.Config;

[Serializable]
public class PuzzleGame
{
	public readonly int id;

	public readonly int[] initposition = new int[0];

	public readonly int puzzleicon;

	public readonly int puzzlegroupid;

	public PuzzleGame(int id, int[] initposition, int puzzleicon, int puzzlegroupid)
	{
		this.id = id;
		this.initposition = initposition;
		this.puzzleicon = puzzleicon;
		this.puzzlegroupid = puzzlegroupid;
	}
}
