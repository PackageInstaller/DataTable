#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class WeaponMechanismBow : WeaponMechanismBase, IPropertyChanged
{
	public enum BowState
	{
		None,
		Normal,
		Awaken
	}

	protected WeaponMechanismBowViewModel bowViewModel;

	protected bool isStopReduce;

	protected Ase.ECS.PropertyData awakenBaseData;

	protected Ase.ECS.PropertyData awakenSwitch;

	protected Ase.ECS.PropertyData awakenCumulative;

	protected BowState state;

	protected float awakenReduceTime;

	protected float awakenReduceValue;

	protected float awakenCumulativeTime;

	protected float awakenCumulativeValue;

	protected float awakenTimer;

	protected float awakenCumulativeTimer;

	protected bool isAutoAwaken;

	public WeaponMechanismBow(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		bowViewModel = viewModel as WeaponMechanismBowViewModel;
	}

	public override void OnStart()
	{
		if (heroCfg == null)
		{
			Log.Error("Hero弓箭配置表为空");
			return;
		}
		if (heroCfg.AwakenParams == null || heroCfg.AwakenParams.Count != 4)
		{
			Log.Error("Hero弓箭配置表 AwakenParams 参数配置错误");
			return;
		}
		if (viewModel.Property.TryGetValue("AwakenBaseValue", out awakenBaseData))
		{
			awakenBaseData.ResetMax(heroCfg.AwakenParams[0]);
		}
		else
		{
			Log.Error("获取属性错误AwakenBaseValue");
		}
		awakenReduceTime = heroCfg.AwakenParams[1];
		if (awakenReduceTime == 0f)
		{
			awakenReduceTime = 0.033f;
		}
		awakenReduceValue = heroCfg.AwakenParams[2];
		isAutoAwaken = heroCfg.AwakenParams[3] == 1f;
		if (heroCfg.AwakenCumulativeParams == null || heroCfg.AwakenCumulativeParams.Count != 3)
		{
			Log.Error("Hero弓箭配置表 AwakenCumulativeParams 参数配置错误");
			return;
		}
		awakenCumulative = viewModel.Property["AwakenCumulativeValue"];
		awakenCumulative.ResetInit(heroCfg.AwakenCumulativeParams[0]);
		awakenCumulativeTime = heroCfg.AwakenCumulativeParams[1];
		awakenCumulativeValue = heroCfg.AwakenCumulativeParams[2];
		awakenBaseData.RegisterOnChangedCallback(this);
		awakenSwitch = viewModel.Property["AwakenStateSwitch"];
		if (awakenSwitch == null)
		{
			Log.Error("当前属性为空:AwakenStateSwitch");
			return;
		}
		awakenSwitch.RegisterOnChangedCallback(this);
		awakenTimer = 0f;
		ChangeNormalState();
	}

	protected virtual void ResetAwakenInfo()
	{
		awakenBaseData.ResetValue(toMax: false);
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "AwakenStateSwitch")
		{
			AwakenStateSwitchChanged();
		}
		else if (propertyName == "AwakenBaseValue")
		{
			AwakenBaseDataChanged();
			if (delta > 0f)
			{
				OnWeaponDataChangeStat(WeaponStatEnum.Awaken, delta);
			}
		}
	}

	private void AwakenStateSwitchChanged()
	{
		if (awakenSwitch.CurValue > 0f)
		{
			ChangeAwakenState();
		}
		else
		{
			ChangeNormalState();
		}
	}

	protected virtual void AwakenBaseDataChanged()
	{
		bowViewModel.BaseAwakenDataChanged(awakenBaseData);
	}

	public void SetStopReduce(bool stopReduce)
	{
		isStopReduce = stopReduce;
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		if (!isStopReduce && state == BowState.Awaken)
		{
			awakenTimer += timeScaleDeltaTime;
			if (awakenTimer >= awakenReduceTime)
			{
				awakenTimer -= awakenReduceTime;
				ReduceBaseAwakenData();
			}
			OnWeaponDataChangeStat(WeaponStatEnum.AwakenTime, deltaTime);
			awakenCumulativeTimer += timeScaleDeltaTime;
			if (awakenCumulativeTimer >= awakenCumulativeTime)
			{
				awakenCumulativeTimer -= awakenCumulativeTime;
				CumulativeAwakenData();
			}
		}
	}

	protected virtual void ReduceBaseAwakenData()
	{
		float property = ownerEntity.GetProperty("AwakenAutoReduceValueAddition");
		awakenBaseData.Addition(awakenReduceValue * property, isIgnoreMax: false);
		if (awakenBaseData.IsMin)
		{
			ChangeNormalState();
			AutoEnterNormal();
		}
	}

	protected virtual void CumulativeAwakenData()
	{
		awakenCumulative.Addition(awakenCumulativeValue, isIgnoreMax: false);
	}

	public override void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		if (!(property != "AwakenBaseValue"))
		{
			BuffDataDamage buffDataDamage = damageProgress?.GetDataDamage();
			if (buffDataDamage != null && buffDataDamage.bulletAttackData != null && buffDataDamage.bulletAttackData.HitColliderVariableData != null)
			{
				OnDamageCumulativeChanged(damageProgress.GetDefender(), buffDataDamage.bulletAttackData.HitColliderVariableData, value);
			}
		}
	}

	protected virtual void OnDamageCumulativeChanged(BaseEntity hitEntity, HitColliderVariableData hitData, float value)
	{
		if (!awakenBaseData.IsMax)
		{
			float num = value * hitData.DamageCumulativeThreshold * ownerEntity.GetProperty("AwakenBaseRatio");
			num *= 1f + ownerEntity.GetProperty("AwakenExtraRatio");
			if (num != 0f)
			{
				awakenBaseData.Addition(num, isIgnoreMax: false);
				bowViewModel.HitDataChanged(0, awakenBaseData);
			}
		}
		if (awakenBaseData.IsMax && isAutoAwaken)
		{
			AutoEnterAwaken();
		}
	}

	protected virtual void AutoEnterAwaken()
	{
		awakenSwitch.Set(1f);
	}

	protected virtual void AutoEnterNormal()
	{
		awakenSwitch.ResetValue(toMax: false);
	}

	protected virtual void ChangeAwakenState()
	{
		if (state != BowState.Awaken && !awakenBaseData.IsMin)
		{
			state = BowState.Awaken;
			bowViewModel.BowStateChanged(state);
			PlayWeaponIndicatorRing();
		}
	}

	protected virtual void ChangeNormalState()
	{
		if (state != BowState.Normal)
		{
			state = BowState.Normal;
			awakenCumulative?.ResetValue(toMax: false);
			bowViewModel.BowStateChanged(state);
		}
	}

	public void SetAutoReduce(bool autoReduce)
	{
		isStopReduce = autoReduce;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (awakenBaseData != null)
		{
			awakenBaseData.RemoveOnChangedCallback(this);
		}
	}
}
