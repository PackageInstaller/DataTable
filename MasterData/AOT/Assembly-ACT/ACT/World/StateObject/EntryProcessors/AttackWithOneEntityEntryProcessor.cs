using System;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject.EntryProcessors;

public class AttackWithOneEntityEntryProcessor : AttackEntryProcessor
{
	protected override void OnInit(IAttackEntrySetting entry)
	{
		CompStateObject compStateObject = entry.EntityReference.GetCompStateObject();
		if (entry.Data.stateId == 0 && !compStateObject.StateObjectBase.isAttackInit)
		{
			CoSpawnAttackInteractObject(entry, MonoECS.instance, entry.Data, entry.Alliance, entry.Size, entry.onSpawnAttackable).Forget();
		}
		if (entry.StateId >= 0 || !compStateObject.StateObjectBase.isAttackInit)
		{
			return;
		}
		compStateObject.StateObjectBase.isAttackInit = false;
		try
		{
			if (compStateObject.StateObjectBase.onlyEntity.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(compStateObject.StateObjectBase.onlyEntity);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"交互物{entry.EntityReference}的AttackWithOneEntity没有被初始化就被删除了？？？");
			}
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}
}
