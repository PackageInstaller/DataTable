using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取BUFF层数", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于获取指定实体身上指定BUFF的层数")]
public class GetBuffLayer : ActionTaskBase
{
	[Name("目标实体id", 0)]
	[Description("要获取BUFF层数的实体的ID")]
	public BBParameter<int> entityId;

	[Name("BuffId", 0)]
	[Description("要获取层数的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("返回的层数", 0)]
	[Description("获取到的BUFF层数将会存储在此参数中")]
	public BBParameter<int> returnLayer;

	protected override void OnExecute()
	{
		base.OnExecute();
		Buff buff = ownerEntity.GetSystem<BuffSystem>().FindEntityBuff(entityId.value, buffId.value);
		if (buff != null)
		{
			returnLayer.value = buff.GetLayer();
			OnActionFinish();
		}
		else
		{
			returnLayer.value = 0;
			OnActionFinish();
		}
	}
}
