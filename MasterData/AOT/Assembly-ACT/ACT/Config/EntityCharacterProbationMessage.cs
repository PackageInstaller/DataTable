using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterProbationMessage
{
	public readonly int id;

	public readonly int characterId;

	public readonly int title1;

	public readonly int[] showIcon1 = new int[0];

	public readonly int showText1;

	public readonly string[] actionPrompt1 = new string[0];

	public readonly int title2;

	public readonly int[] showIcon2 = new int[0];

	public readonly int showText;

	public readonly string[] actionPrompt2 = new string[0];

	public EntityCharacterProbationMessage(int id, int characterId, int title1, int[] showIcon1, int showText1, string[] actionPrompt1, int title2, int[] showIcon2, int showText, string[] actionPrompt2)
	{
		this.id = id;
		this.characterId = characterId;
		this.title1 = title1;
		this.showIcon1 = showIcon1;
		this.showText1 = showText1;
		this.actionPrompt1 = actionPrompt1;
		this.title2 = title2;
		this.showIcon2 = showIcon2;
		this.showText = showText;
		this.actionPrompt2 = actionPrompt2;
	}
}
