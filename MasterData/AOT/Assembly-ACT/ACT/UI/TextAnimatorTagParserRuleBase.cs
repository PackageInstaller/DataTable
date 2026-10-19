using UnityEngine;

namespace ACT.UI;

public abstract class TextAnimatorTagParserRuleBase : ScriptableObject, ITextAnimatorTagParserRule
{
	public abstract ITagParserBase CreateParser();
}
