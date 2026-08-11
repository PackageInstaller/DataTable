using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class BulletParentPropertyData : IReference, IObserverHandler
{
	public DRBullet Config;

	public BaseEntity Attacker;

	public Vector3 AttackerPos;

	public float BaseDamage;

	public EntityType AttackEntityType;

	public int CreateId;

	public ObservableDictionary<string, PropertyData> AttackerProperty { get; private set; }

	public ObservableDictionary<string, float> AttackerPropertyLight { get; private set; }

	private bool AttackerIsDead { get; set; }

	public float SkillSpecialDamage { get; private set; }

	public float SkillSpecialTenacity { get; private set; }

	public float SkillSpecialCure { get; private set; }

	public static BulletParentPropertyData Create(BaseEntity parent, DRBullet config)
	{
		BulletParentPropertyData bulletParentPropertyData = ReferencePool.Acquire<BulletParentPropertyData>();
		bulletParentPropertyData.Config = config;
		bulletParentPropertyData.Attacker = parent;
		bulletParentPropertyData.AttackerPos = parent.transform.position;
		bulletParentPropertyData.AttackEntityType = parent.GetEntityType();
		bulletParentPropertyData.CreateId = parent.Id;
		bulletParentPropertyData.OnInit();
		return bulletParentPropertyData;
	}

	private void OnInit()
	{
		AttackerIsDead = false;
		Attacker.GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.EntityRelease, this);
		if (Attacker.GetEntityType() == EntityType.INTERACTIVE)
		{
			return;
		}
		if (Attacker.EntityViewModel != null)
		{
			AttackerProperty = Attacker.EntityViewModel.Property;
			AttackerPropertyLight = Attacker.EntityViewModel.PropertyLight;
		}
		if (Attacker.GetEntityType() == EntityType.SummonedEntity && Attacker.Parent != null)
		{
			SkillAdditionData skillAdditionData = Attacker.Parent.GetComponent<SkillComponent>()?.GetSkillAddition(Config.SkillId);
			if (skillAdditionData != null)
			{
				SkillSpecialDamage = skillAdditionData.SkillSpecialDamage;
				SkillSpecialTenacity = skillAdditionData.SkillSpecialTenacity;
				SkillSpecialCure = skillAdditionData.SkillSpecialCure;
			}
		}
	}

	public void ComputeBaseDamage()
	{
		if (Attacker is WorldEntity worldEntity)
		{
			BaseDamage = worldEntity.GetDamage();
		}
	}

	public void Clear()
	{
		if (AttackerIsDead)
		{
			AttackerProperty.Clear();
			AttackerPropertyLight.Clear();
		}
		Attacker.GetSystem<BattleObserverSystem>().Detach(BattleObserverEventEnum.EntityRelease, this);
		AttackerPos = Vector3.zero;
		Attacker = null;
		AttackerProperty = null;
		AttackerPropertyLight = null;
		SkillSpecialDamage = 0f;
		SkillSpecialTenacity = 0f;
		SkillSpecialCure = 0f;
	}

	public void OnNotify(IObserverParams param)
	{
		if (!AttackerIsDead && Attacker != null && Attacker.EntityViewModel != null && param.Trigger != null && Attacker.Id == param.Trigger.Id)
		{
			_ = Attacker;
			if (param is ObserverEntityReleaseParams)
			{
				AttackerProperty = new ObservableDictionary<string, PropertyData>(Attacker.EntityViewModel.Property);
				AttackerPropertyLight = new ObservableDictionary<string, float>(Attacker.EntityViewModel.PropertyLight);
				AttackerIsDead = true;
			}
		}
	}
}
