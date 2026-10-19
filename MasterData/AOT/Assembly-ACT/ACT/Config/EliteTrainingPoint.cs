using System;

namespace ACT.Config;

[Serializable]
public class EliteTrainingPoint
{
	public readonly int id;

	public readonly int[] attrId = new int[0];

	public readonly float[] attrIncreaseNum = new float[0];

	public readonly int UIName;

	public EliteTrainingPoint(int id, int[] attrId, float[] attrIncreaseNum, int UIName)
	{
		this.id = id;
		this.attrId = attrId;
		this.attrIncreaseNum = attrIncreaseNum;
		this.UIName = UIName;
	}
}
