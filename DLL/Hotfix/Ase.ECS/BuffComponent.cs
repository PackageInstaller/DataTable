using System.Collections.Generic;

namespace Ase.ECS;

public class BuffComponent : BaseComponent
{
	private List<int> initBuffs;

	public List<int> InitBuffs
	{
		get
		{
			return initBuffs;
		}
		set
		{
			initBuffs = value;
		}
	}

	public void AddInitBuff(List<int> initBuffs)
	{
		this.initBuffs = initBuffs;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		if (initBuffs == null)
		{
			return;
		}
		BuffSystem system = base.Entity.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		foreach (int initBuff in initBuffs)
		{
			system.CheckAndAcquireBuff(base.Entity.EntityId, base.Entity.EntityId, initBuff);
		}
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		mBaseEntity.GetSystem<BuffSystem>()?.FinishEntityBuffByTag(mBaseEntity.Id, "Battle");
	}

	public override void OnDispose()
	{
		mBaseEntity.GetSystem<BuffSystem>()?.FinishEntityAllBuff(mBaseEntity.Id);
		base.OnDispose();
	}
}
