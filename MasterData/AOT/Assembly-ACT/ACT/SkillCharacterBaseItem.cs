using ACT.Game.Data;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT;

public class SkillCharacterBaseItem : LoopScrollBaseItem
{
	public BImage image;

	public PublicToggle Toggle;

	public Character character;

	public UnityEvent<SkillCharacterBaseItem, int> InitIcon;

	public override void ScrollCellIndex(int idx)
	{
		index = idx;
		InitIcon.Invoke(this, idx);
	}
}
