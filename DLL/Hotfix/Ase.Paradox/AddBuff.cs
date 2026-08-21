using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("添加BUFF", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于向实体添加BUFF")]
public class AddBuff : ActionTaskBase
{
	[Name("BUFF编号", 0)]
	[RequiredField]
	[Description("要添加的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("添加Buff时判断添加条件", 0)]
	public bool isAddBuffTriggerCondition = true;

	protected override async void OnExecute()
	{
		base.OnExecute();
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(buffId.value);
		if (dataRow == null)
		{
			OnActionFail();
			return;
		}
		if (isAddBuffTriggerCondition)
		{
			ownerEntity.GetSystem<BuffSystem>().CheckAndAcquireBuff(ownerEntity, ownerEntity, dataRow);
		}
		else
		{
			ownerEntity.GetSystem<BuffSystem>().AcquireBuff(ownerEntity, ownerEntity, dataRow);
		}
		OnActionFinish();
	}
}
