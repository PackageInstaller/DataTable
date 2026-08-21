using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查Buff层数", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于检查实体身上指定BUFF的层数是否满足条件")]
public class CheckBuffLayer : ConditionTaskBase
{
	[Name("BuffID", 0)]
	[RequiredField]
	[Description("要检查的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("层数", 0)]
	[RequiredField]
	[Description("要比较的层数")]
	public BBParameter<int> checkLayer;

	[Name("比较类型", 0)]
	[RequiredField]
	[Description("用于比较层数的方法")]
	public BBParameter<CompareMethodType> methodType;

	[Name("目标ID", 0)]
	[RequiredField]
	[Description("要检查BUFF的实体的ID")]
	public BBParameter<int> targetId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (!EntityAndTreeConsistency(targetId.value, out var baseEntity))
		{
			return false;
		}
		Buff buff = baseEntity.GetSystem<BuffSystem>()?.FindEntityBuff(baseEntity.Id, buffId.value);
		int num = 0;
		if (buff != null)
		{
			num = buff.GetLayer();
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"buffId :{buffId.value}  检查Buff层数  {num}  checkLayer  {checkLayer}", ownerEntity);
		}
		return ConditionExtensions.CompareValueMethod(methodType.value, num, checkLayer.value);
	}
}
