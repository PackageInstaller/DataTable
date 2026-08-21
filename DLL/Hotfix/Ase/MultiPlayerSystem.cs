using System;
using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class MultiPlayerSystem : BaseSystem
{
	private Dictionary<HeroAttributeEnum, Type> MultiAttributeDic;

	private List<MultiAttributeBase> multiAttList;

	private MultiAttributeBuffs multiAttributeBuffs;

	protected override bool IsLogicSystem => true;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		multiAttributeBuffs = new MultiAttributeBuffs();
		multiAttributeBuffs.OnInit(this);
	}

	public override void OnStart(object data = null)
	{
		multiAttributeBuffs.OnStart();
	}

	private void InitAttributeBuffs()
	{
	}

	public void SendCreateEntityMessager(BaseEntity entity)
	{
		foreach (MultiAttributeBase multiAtt in multiAttList)
		{
			multiAtt.CreateEntityMessager(entity);
		}
	}

	public void SendSkillReleaseMessager(BaseEntity entity, HeroSkillTypeEnum skillTypeEnum, int skillId)
	{
		foreach (MultiAttributeBase multiAtt in multiAttList)
		{
			multiAtt.SkillReleaseMessager(entity, skillTypeEnum, skillId);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
	}

	public override void OnDispose()
	{
		base.OnDispose();
		multiAttributeBuffs = null;
	}
}
