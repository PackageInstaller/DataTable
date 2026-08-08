using System.Collections.Generic;
using Entitas;

[Sim]
public class EntityActionModifyHP : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public List<ModifyHPInfo> mModifyInfoList;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		if (mModifyInfoList != null)
		{
			FrameListPool<ModifyHPInfo>.Release(mModifyInfoList);
			mModifyInfoList = null;
		}
	}
}
