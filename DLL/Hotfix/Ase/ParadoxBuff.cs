using Ase.ECS;

namespace Ase;

public class ParadoxBuff : BuffOperationBase<BuffDataParadox>
{
	private int treeId = -1;

	protected override void OnExecute()
	{
		treeId = base.buffOwner.GetSystem<ParadoxSystem>().ExecuteTreeOrFsm(base.buffOwner, dataBase.paradoxId);
	}

	public override void OnUpdate(float deltaTime)
	{
	}

	protected override void OnClear()
	{
		if (treeId != -1)
		{
			base.buffOwner.GetSystem<ParadoxSystem>().StopTree(treeId);
			treeId = -1;
		}
	}
}
