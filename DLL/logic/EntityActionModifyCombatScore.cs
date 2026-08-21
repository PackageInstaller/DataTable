using System.Collections.Generic;
using Entitas;

[Sim]
public class EntityActionModifyCombatScore : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public List<ModifyCombatScoreInfo> mModifyInfoList;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		if (mModifyInfoList != null)
		{
			FrameListPool<ModifyCombatScoreInfo>.Release(mModifyInfoList);
			mModifyInfoList = null;
		}
	}
}
