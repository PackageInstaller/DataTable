using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class ActorShield : LogicMonoComponent, ILogicComponentUpdate, ILogicComponent
{
	public delegate void ShieldChangedHandle(long oneValueC, long oneValueM);

	[HideInInspector]
	public AdventureActor damageFrom;

	private long _shieldValue;

	private long _maxShildValue;

	private int normalFxIndex;

	private AdventureBuffFXHandler normalAdventureFx;

	public List<ShieldEntity> shieldList { get; private set; }

	public AdventureActor OwnerActor { get; private set; }

	public long shiledValue => _shieldValue;

	public long maxShieldValue => _maxShildValue;

	public event ShieldChangedHandle shieldChangedEvent;

	protected override void OnInit()
	{
		base.OnInit();
		OwnerActor = Entity as AdventureActor;
	}

	public override void OnActive()
	{
		if ((object)OwnerActor == null)
		{
			AdventureActor adventureActor = (OwnerActor = Entity as AdventureActor);
		}
	}

	public void OnLogicUpdate()
	{
		LogicUpdate(Entity.LogicDeltaTime);
	}

	private void LogicUpdate(FP deltaTime)
	{
		if (shieldList != null && shieldList.Count >= 1)
		{
			for (int i = 0; i < shieldList.Count; i++)
			{
				shieldList.get_Item(i).OnUpdate(deltaTime);
			}
		}
	}

	public long DamageToShield(long damageValue, LogicEntity from = null)
	{
		List<ShieldEntity> list = shieldList;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < shieldList.Count; i++)
			{
				if (damageValue <= 0)
				{
					break;
				}
				shieldList.get_Item(i).CalcShieldValue(ref damageValue, from);
			}
		}
		UpdateShieldValue();
		return damageValue;
	}

	public void UpdateShieldValue(bool iRecycle = false)
	{
		bool lastHaveValue = _shieldValue > 0;
		ResetUIshieldValues();
		List<ShieldEntity> list = shieldList;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < shieldList.Count; i++)
			{
				_shieldValue += shieldList.get_Item(i).value_Current;
				_maxShildValue += shieldList.get_Item(i).value_Max;
			}
		}
		shieldChangedEvent?.Invoke(shiledValue, maxShieldValue);
		ShieldEvent(iRecycle, lastHaveValue);
	}

	private void ResetUIshieldValues()
	{
		_shieldValue = 0L;
		_maxShildValue = 0L;
	}

	protected void ShieldEvent(bool iRecycle = false, bool lastHaveValue = false)
	{
		if (((shiledValue <= 0) & lastHaveValue) && !iRecycle)
		{
			AdventureActorBreakShield adventureActorBreakShield = AdventureActorBreakShield.Generate();
			adventureActorBreakShield.sender = OwnerActor;
			adventureActorBreakShield.to = OwnerActor;
			adventureActorBreakShield.from = damageFrom;
			adventureActorBreakShield.shield = 0;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorBreakShield);
		}
		damageFrom = null;
	}

	public void AddShield(int shieldID, AdventureActor fromActor)
	{
		if (OwnerActor == null)
		{
			OwnerActor = GetComponent<AdventureActor>();
		}
		if (OwnerActor == null)
		{
			return;
		}
		ActorHealthInfo actorHealthInfo = OwnerActor.actorHealthInfo;
		if (actorHealthInfo == null || !actorHealthInfo.isAlive)
		{
			return;
		}
		if (shieldList == null)
		{
			List<ShieldEntity> list = (shieldList = new List<ShieldEntity>(1));
		}
		for (int i = 0; i < shieldList.Count; i++)
		{
			if (shieldList.get_Item(i).shieldConfig.Id == shieldID)
			{
				shieldList.get_Item(i).AddNum(fromActor);
				shieldList.Sort((ShieldEntity x, ShieldEntity y) => (!(x.leftTime < y.leftTime)) ? 1 : (-1));
				UpdateShieldValue();
				return;
			}
		}
		ShieldEntity shieldEntity = new ShieldEntity(shieldID, this, fromActor);
		if (shieldEntity.shieldConfig != null && shieldEntity.shieldValueConfig != null)
		{
			shieldEntity.ShieldEffectStart();
			shieldList.Add(shieldEntity);
			shieldList.Sort((ShieldEntity x, ShieldEntity y) => (!(x.leftTime < y.leftTime)) ? 1 : (-1));
			UpdateShieldValue();
		}
	}

	public void AjustShieldTime_Value(int Id, FP addTime)
	{
		if (Id <= 0)
		{
			return;
		}
		List<ShieldEntity> list = shieldList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < shieldList.Count; i++)
		{
			if (shieldList.get_Item(i).shieldConfig.Id != Id)
			{
				continue;
			}
			shieldList.get_Item(i).AjustShieldTime_Value(addTime);
			if (addTime != 0)
			{
				shieldList.Sort((ShieldEntity x, ShieldEntity y) => (!(x.leftTime < y.leftTime)) ? 1 : (-1));
			}
			break;
		}
	}

	public void ResetShield(int shieldID, FP leftTime, long[] sheildValue, long currentValue, int valueID)
	{
		if (shieldList == null)
		{
			List<ShieldEntity> list = (shieldList = new List<ShieldEntity>(1));
		}
		ShieldEntity shieldEntity = new ShieldEntity(shieldID, this, leftTime, sheildValue, currentValue, valueID);
		if (shieldEntity.shieldConfig != null && shieldEntity.shieldValueConfig != null)
		{
			shieldList.Add(shieldEntity);
			shieldList.Sort((ShieldEntity x, ShieldEntity y) => (!(x.leftTime < y.leftTime)) ? 1 : (-1));
			UpdateShieldValue();
		}
	}

	public void OnNormalFx(bool iAdd, int num = 1)
	{
		if (iAdd)
		{
			normalFxIndex++;
			if (normalFxIndex == 1)
			{
				string normalShieldFxPath = AdventureModuleController.Config.normalShieldFxPath;
				GameObject owner = gameObject;
				AdventureActor ownerActor = OwnerActor;
				normalAdventureFx = AdventureFXManager.PlayBuffFX(normalShieldFxPath, owner, AdventureBuffFXHandler.FXPlayMode.Default, default, default, 1f, ownerActor);
			}
			return;
		}
		normalFxIndex -= num;
		if (normalFxIndex <= 0)
		{
			normalFxIndex = 0;
			if (normalAdventureFx != null)
			{
				normalAdventureFx.StopFX();
				normalAdventureFx = null;
			}
		}
	}

	public bool CheckShieldByID(int id)
	{
		if (shieldList == null)
		{
			return false;
		}
		for (int i = 0; i < shieldList.Count; i++)
		{
			if (shieldList.get_Item(i).shieldConfig.Id == id && !shieldList.get_Item(i).iEnd)
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckShieldByTag(int tag)
	{
		if (shieldList == null)
		{
			return false;
		}
		for (int i = 0; i < shieldList.Count; i++)
		{
			if (shieldList.get_Item(i).CheckTag(tag))
			{
				return true;
			}
		}
		return false;
	}

	public void RemoveShieldByShieldID(int shieldID)
	{
		if (shieldList == null || shieldID <= 0)
		{
			return;
		}
		for (int num = shieldList.Count - 1; num > -1; num--)
		{
			if (shieldList.get_Item(num).shieldConfig.Id == shieldID)
			{
				shieldList.get_Item(num).OnEnd();
				shieldList.RemoveAt(num);
			}
		}
		UpdateShieldValue();
	}

	public void RemoveShieldByTag(int tag)
	{
		if (shieldList == null)
		{
			return;
		}
		for (int num = shieldList.Count - 1; num > -1; num--)
		{
			if (shieldList.get_Item(num).CheckTag(tag))
			{
				shieldList.get_Item(num).OnEnd();
				shieldList.RemoveAt(num);
			}
		}
		UpdateShieldValue();
	}

	public void RemoveShield(ShieldEntity shield)
	{
		if (shieldList != null && shield != null)
		{
			shield.OnEnd();
			shieldList.Remove(shield);
			UpdateShieldValue();
		}
	}

	public void RemoveAllShield(bool iRecycle = false)
	{
		if (shieldList != null)
		{
			for (int i = 0; i < shieldList.Count; i++)
			{
				shieldList.get_Item(i).OnEnd(interrupt: true);
			}
			shieldList.Clear();
			normalFxIndex = 0;
		}
		UpdateShieldValue(iRecycle);
	}

	public void OnClear()
	{
		RemoveAllShield(iRecycle: true);
		shieldList = null;
		OwnerActor = null;
	}

	public override void OnDeactive()
	{
		OnClear();
	}

	public void FireShieldUiEvent(int id, long shieldValue, FP leftTime, string name)
	{
	}
}
