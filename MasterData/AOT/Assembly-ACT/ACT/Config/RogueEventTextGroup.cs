using System;

namespace ACT.Config;

[Serializable]
public class RogueEventTextGroup
{
	public readonly int id;

	public readonly int groupId;

	public readonly int[] textCode = new int[0];

	public readonly float[] nextCode = new float[0];

	public readonly int textId;

	public readonly int[] chooseTextId = new int[0];

	public readonly int[] chooseEffectCodeList = new int[0];

	public readonly float[] effectCodeParmList = new float[0];

	public RogueEventTextGroup(int id, int groupId, int[] textCode, float[] nextCode, int textId, int[] chooseTextId, int[] chooseEffectCodeList, float[] effectCodeParmList)
	{
		this.id = id;
		this.groupId = groupId;
		this.textCode = textCode;
		this.nextCode = nextCode;
		this.textId = textId;
		this.chooseTextId = chooseTextId;
		this.chooseEffectCodeList = chooseEffectCodeList;
		this.effectCodeParmList = effectCodeParmList;
	}
}
