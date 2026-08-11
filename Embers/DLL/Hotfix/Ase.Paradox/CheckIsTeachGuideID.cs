using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查是否正在触发某个引导", 0)]
[Category("✫ DragonLost/Condition")]
[Description("检查是否正在触发某个引导。")]
public class CheckIsTeachGuideID : ConditionTaskBase
{
	[Name("引导Id", 0)]
	[Description("引导Id。")]
	public int TeachGuideId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (ownerEntity == null)
		{
			return false;
		}
		return ownerEntity.GetSystem<TeachGuideSystem>().GetIsTeachGuideId(TeachGuideId);
	}
}
