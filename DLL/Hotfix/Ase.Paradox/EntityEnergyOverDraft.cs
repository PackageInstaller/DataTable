#define ENABLE_LOG
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("能量透支（已弃用）", 0)]
[Description("对实体进行能量透支操作，减少其能量值。")]
[Category("✫ DragonLost/Entity")]
public class EntityEnergyOverDraft : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要进行能量透支的实体的实体Id。")]
	public BBParameter<int> EntityId;

	[Name("能量值", 0)]
	[Description("要透支的能量值，即减少的能量值。")]
	public BBParameter<int> Energy;

	[Name("是否可以释放", 0)]
	[Description("是否可以释放能量。")]
	public BBParameter<bool> IsRelease;

	[Name("是否强制释放", 0)]
	[Description("是否强制释放能量。")]
	public bool IsForceRelease;

	protected override void OnExecute()
	{
		base.OnExecute();
		LogActionError("'能量透支'已弃用，请检查");
		EndAction();
	}
}
