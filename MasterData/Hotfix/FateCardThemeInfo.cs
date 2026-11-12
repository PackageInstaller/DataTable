using System;
using System.Collections.Generic;

[Serializable]
public class FateCardThemeInfo
{
	public HotfixEnum.fateCardTheme theme;

	public HotfixEnum.fateCardThemeRank rank = HotfixEnum.fateCardThemeRank.Base;

	public List<HotfixEnum.fateCardThemeTriggerType> types = new List<HotfixEnum.fateCardThemeTriggerType> { HotfixEnum.fateCardThemeTriggerType.NormalAttack };

	public void LoadFrom(FateCardThemeInfo other)
	{
		theme = other.theme;
		rank = other.rank;
		types.Clear();
		types.AddRange(other.types);
	}
}
