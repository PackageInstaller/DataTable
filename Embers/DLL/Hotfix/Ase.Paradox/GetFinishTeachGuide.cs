using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查是否完成某个新手引导", 0)]
[Description("检查是否完成某个新手引导")]
[Category("✫ DragonLost/Entity")]
public class GetFinishTeachGuide : ConditionTaskBase
{
	[Name("引导Id", 0)]
	[Description("引导Id")]
	public int TeachGuide;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetFinishTeachGuide(TeachGuide);
	}
}
