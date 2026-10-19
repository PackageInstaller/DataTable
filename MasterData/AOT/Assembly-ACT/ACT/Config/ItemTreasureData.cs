using System;

namespace ACT.Config;

[Serializable]
public class ItemTreasureData
{
	public readonly int id;

	public readonly int itemId;

	public readonly int type;

	public readonly int ui;

	public readonly int mapArea;

	public readonly int characterId;

	public readonly int[] attrId = new int[0];

	public readonly float[] attrIncreaseNum = new float[0];

	public readonly int functionId;

	public readonly int extraText;

	public readonly int guideId;

	public readonly int tips;

	public ItemTreasureData(int id, int itemId, int type, int ui, int mapArea, int characterId, int[] attrId, float[] attrIncreaseNum, int functionId, int extraText, int guideId, int tips)
	{
		this.id = id;
		this.itemId = itemId;
		this.type = type;
		this.ui = ui;
		this.mapArea = mapArea;
		this.characterId = characterId;
		this.attrId = attrId;
		this.attrIncreaseNum = attrIncreaseNum;
		this.functionId = functionId;
		this.extraText = extraText;
		this.guideId = guideId;
		this.tips = tips;
	}
}
