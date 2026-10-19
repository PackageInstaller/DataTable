using System;

namespace ACT.Config;

[Serializable]
public class TrainingContents
{
	public readonly int id;

	public readonly int contentLv1name;

	public readonly int IdBelong;

	public readonly int[] teamCharacter = new int[0];

	public readonly int raidID;

	public readonly int worldMonsterPointID;

	public readonly int[] BKID = new int[0];

	public readonly int level;

	public readonly int sort;

	public TrainingContents(int id, int contentLv1name, int IdBelong, int[] teamCharacter, int raidID, int worldMonsterPointID, int[] BKID, int level, int sort)
	{
		this.id = id;
		this.contentLv1name = contentLv1name;
		this.IdBelong = IdBelong;
		this.teamCharacter = teamCharacter;
		this.raidID = raidID;
		this.worldMonsterPointID = worldMonsterPointID;
		this.BKID = BKID;
		this.level = level;
		this.sort = sort;
	}
}
