using System;

namespace ACT.Config;

[Serializable]
public class ItemChipData
{
	public readonly int id;

	public readonly int type;

	public readonly int suitID;

	public readonly int coreSuitID;

	public readonly int space;

	public readonly int storyLocal;

	public readonly int ChipEntry;

	public readonly int site;

	public readonly int siteNameLocal;

	public ItemChipData(int id, int type, int suitID, int coreSuitID, int space, int storyLocal, int ChipEntry, int site, int siteNameLocal)
	{
		this.id = id;
		this.type = type;
		this.suitID = suitID;
		this.coreSuitID = coreSuitID;
		this.space = space;
		this.storyLocal = storyLocal;
		this.ChipEntry = ChipEntry;
		this.site = site;
		this.siteNameLocal = siteNameLocal;
	}
}
