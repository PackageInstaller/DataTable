using JetBrains.Annotations;
using UnityEngine.Events;

namespace Runtime.UI.ViewComponent.CharacterView.SkillUI;

public struct SkillLevelCellDataContext
{
	public int baseLevel;

	public int maxLevel;

	[CanBeNull]
	public UnityAction<int> onClickCell;
}
