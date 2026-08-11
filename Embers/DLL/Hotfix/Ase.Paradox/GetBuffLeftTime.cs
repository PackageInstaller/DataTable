using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取BUFF剩余时间", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于获取指定实体身上指定BUFF的剩余持续时间")]
public class GetBuffLeftTime : ActionTaskBase
{
	[Name("目标实体id", 0)]
	[Description("要获取BUFF剩余时间的实体的ID")]
	public BBParameter<int> entityId;

	[Name("BuffId", 0)]
	[Description("要获取剩余时间的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("返回剩余时间", 0)]
	[Description("获取到的BUFF剩余时间将会存储在此参数中")]
	public BBParameter<float> returnLeftTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		Buff buff = ownerEntity.GetSystem<BuffSystem>()?.FindEntityBuff(entityId.value, buffId.value);
		if (buff != null)
		{
			returnLeftTime.value = buff.GetRemainingTime();
			OnActionFinish();
		}
		else
		{
			returnLeftTime.value = 0f;
			OnActionFinish();
		}
	}
}
