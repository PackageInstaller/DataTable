using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class HpComponent : BaseComponent
{
	private int _recordedDataCooing;

	private float _reduceSpeed;

	private bool _startVirtualHpState;

	private const string FOLLOW_BONE_KEY = "hpRoot";

	private HPBarItem hpBarItem;

	private float hpBarShowTime;

	private float virtualHpTime;

	private bool teachFirstHit;

	private bool teachHalfBlood;

	private PropertyData _hpProp;

	private PropertyData _tenacityProp;

	public override void OnStart(object data = null)
	{
		_reduceSpeed = mBaseEntity.GetProperty("VirtualHpReduceSpeed");
		if (GetData("HpBarType", 0) > 0)
		{
			Transform transform = null;
			EntityBoneComponent component = mBaseEntity.GetComponent<EntityBoneComponent>();
			if (component == null)
			{
				transform = mBaseEntity.GetComponent<EntityViewComponent>().Transform;
			}
			else
			{
				transform = component.GetBoneRoot("hpRoot");
				if (transform == null)
				{
					transform = mBaseEntity.GetComponent<EntityViewComponent>().Transform;
				}
			}
			hpBarItem = mBaseEntity.GetSystem<HealthBarsSystem>().AllocateHpBar(GetData("HpBarType", 0), transform);
			if (hpBarItem != null && mBaseEntity is MonsterEntity monsterEntity)
			{
				hpBarItem.InitData(mBaseEntity);
				if (!monsterEntity.MonsterAttrConfig.HideMonsterLevel)
				{
					hpBarItem.ShowLevel(monsterEntity.MonsterAttrConfig.MonsterLevel);
				}
			}
			_hpProp = mBaseEntity.EntityViewModel.Property["Hp"];
			_tenacityProp = mBaseEntity.EntityViewModel.Property["Tenacity"];
			if (mBaseEntity.IsStandby)
			{
				HideHpBar();
			}
		}
		teachFirstHit = GetData("TEACHOBSERVER", defaultValue: false);
		teachHalfBlood = GetData("TEACHHALFBLOOD", defaultValue: false);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		RecordedData();
		CheckDuration(deltaTime);
		if (!((double)mBaseEntity.GetProperty("VirtualHp") < 0.0010000000474974513))
		{
			virtualHpTime = Mathf.Clamp(virtualHpTime + deltaTime, 0f, mBaseEntity.GetProperty("VirtualHpReduceTime"));
			if (virtualHpTime >= mBaseEntity.GetProperty("VirtualHpReduceTime"))
			{
				mBaseEntity.ChangeProperty("VirtualHp", (0f - _reduceSpeed) * mBaseEntity.GetPropertyMax("Hp"));
			}
		}
	}

	private void CheckDuration(float deltaTime)
	{
		if (hpBarItem != null && hpBarItem.gameObject.activeSelf)
		{
			hpBarItem.UpdateData(_hpProp.CurValue, _hpProp.MaxValue, _tenacityProp.CurValue, _tenacityProp.MaxValue);
			hpBarShowTime -= deltaTime;
			if (hpBarShowTime <= 0f)
			{
				HideHpBar();
			}
		}
	}

	public void ShowHpBar()
	{
		if (hpBarItem != null)
		{
			hpBarItem.ExternalCallRefreshPosition();
			hpBarItem.ShowBar();
		}
		if (teachFirstHit && hpBarItem != null)
		{
			teachFirstHit = false;
			ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
			observerTeachGuideParams.Init(mBaseEntity, hpBarItem.transform);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachHitSpawn, observerTeachGuideParams);
			ReferencePool.Release(observerTeachGuideParams);
		}
		hpBarShowTime = GameEntry.Base.GameConfig?.HpBarShowDura ?? 0f;
	}

	public void HideHpBar()
	{
		if (hpBarItem != null)
		{
			hpBarItem.HideBar();
		}
	}

	public void RemoveHpBar()
	{
		if (hpBarItem != null)
		{
			hpBarItem.Remove();
			hpBarItem = null;
		}
		_hpProp = null;
		_tenacityProp = null;
	}

	public float ReduceHp(int value, bool isDamageProduce = false)
	{
		return ReduceHp(null, value, isDamageProduce);
	}

	public float ReduceHp(BaseEntity attacker, int value, bool isDamageProduce = false)
	{
		int num = Mathf.CeilToInt(mBaseEntity.GetProperty("Hp"));
		int num2 = Mathf.CeilToInt(mBaseEntity.GetPropertyMax("Hp"));
		if (teachHalfBlood && num - value <= num2 / 2)
		{
			teachHalfBlood = false;
			ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
			observerTeachGuideParams.Init(mBaseEntity, null);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachBossHalfBlood, observerTeachGuideParams);
			ReferencePool.Release(observerTeachGuideParams);
		}
		StateComponent component = mBaseEntity.GetComponent<StateComponent>();
		if (num - value <= 0)
		{
			if (component != null && component.LockHp())
			{
				mBaseEntity.SetProperty("Hp", 1f);
				return num - 1;
			}
			mBaseEntity.SetProperty("Hp", 0f);
			EntityExecuteDead(attacker, isKilled: true);
			return num;
		}
		if (_startVirtualHpState)
		{
			int num3 = (int)DamageConvertVirtualHp(value);
			mBaseEntity.ChangeProperty("VirtualHp", num3);
			mBaseEntity.ChangeProperty("Hp", -value);
		}
		else
		{
			mBaseEntity.ChangeProperty("Hp", -value);
		}
		return value;
	}

	public void ForceToDead()
	{
		mBaseEntity.SetProperty("Hp", 0f);
		EntityExecuteDead(null, isKilled: true);
	}

	public bool RecoveryHp(BaseEntity doctorEntity, int value, out float cureHp)
	{
		float property = mBaseEntity.GetProperty("Hp");
		if (property <= 0f)
		{
			cureHp = 0f;
			return false;
		}
		float num = mBaseEntity.ChangeProperty("Hp", value);
		cureHp = num - property;
		doctorEntity.GetSystem<BattleSystem>().Account(AccountType.CurativeDose, cureHp, doctorEntity.Id);
		if (num <= 0f)
		{
			EntityExecuteDead(doctorEntity, isKilled: true);
			return true;
		}
		return false;
	}

	private float DamageConvertVirtualHp(float damage)
	{
		RefreshTime();
		return damage * mBaseEntity.GetProperty("DamageConvertVirtualHpScale");
	}

	public void VirtualHpConvertHp(float scale)
	{
		if (mBaseEntity.GetProperty("Hp") != 0f)
		{
			float num = mBaseEntity.GetPropertyMax("Hp") * scale;
			if (mBaseEntity.GetProperty("VirtualHp") >= num)
			{
				mBaseEntity.ChangeProperty("VirtualHp", 0f - num);
				mBaseEntity.ChangeProperty("Hp", num);
			}
			else
			{
				float property = mBaseEntity.GetProperty("VirtualHp");
				mBaseEntity.SetProperty("VirtualHp", 0f);
				mBaseEntity.ChangeProperty("Hp", property);
			}
		}
	}

	public void SwitchState(bool open)
	{
		_startVirtualHpState = open;
	}

	private void RefreshTime()
	{
		virtualHpTime = 0f;
	}

	private void EntityExecuteDead(BaseEntity killer, bool isKilled)
	{
		if (mBaseEntity.GetEntityType() == EntityType.HERO)
		{
			mBaseEntity.GetComponent<NearDeathRescueComponent>().CheckHeroCanReborn(killer, isKilled);
			return;
		}
		DestroyComponent typeOfComponent = mBaseEntity.GetTypeOfComponent<DestroyComponent>();
		if (typeOfComponent != null)
		{
			typeOfComponent.SetKillerEntity(killer);
			typeOfComponent.DoEntityDead(isKilled);
		}
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		RemoveHpBar();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		RemoveHpBar();
	}

	private void RecordedData()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId(string.Format("HpComponent  Hp ：{0}", mBaseEntity.GetProperty("Hp")), mBaseEntity);
		}
		if (mBaseEntity.GetEntityType() == EntityType.MONSTER)
		{
			_recordedDataCooing++;
			if (_recordedDataCooing == 100)
			{
				_recordedDataCooing = 0;
			}
		}
	}

	public void SetDownState(bool downState, string damageRatio)
	{
		if (hpBarItem != null)
		{
			hpBarItem.SetDownState(downState, damageRatio);
		}
	}
}
