using Ase.ECS;

namespace Ase;

public class ModVelBuff : BuffOperationBase<BuffDataModifyVelocity>
{
	protected override void OnExecute()
	{
		base.buffOwner.GetComponent<AttractionComponent>()?.ExecuteAttraction(base.buffFrom, dataBase.vel * dataBase.direct);
	}
}
