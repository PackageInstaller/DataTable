#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class WeaponMechanismLance : WeaponMechanismBase, IPropertyChanged, IPropertyEstimatedChanged
{
	protected WeaponMechanismLanceViewModel lanceViewModel;

	private Ase.ECS.PropertyData courageProperty;

	private Ase.ECS.PropertyData heroMightProperty;

	private Ase.ECS.PropertyData mightSwitchProperty;

	private Ase.ECS.PropertyData eachHeroCourageProperty;

	private Ase.ECS.PropertyData eachHeroCourageNumProperty;

	private Ase.ECS.PropertyData eachHeroCourageNoMightHideProperty;

	private float courageOverflowingValue;

	public WeaponMechanismLance(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		lanceViewModel = viewModel as WeaponMechanismLanceViewModel;
	}

	public override void OnStart()
	{
		if (heroCfg == null)
		{
			Log.Error("长枪武器机制: Hero配置表为空");
			return;
		}
		if (heroCfg.LanceInit == null || heroCfg.LanceInit.Count != 5)
		{
			Log.Error("长枪武器机制: Hero配置表数据错误");
			return;
		}
		if (!viewModel.Property.TryGetValue("HeroMightSwitch", out mightSwitchProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:HeroMightSwitch");
			return;
		}
		if (!viewModel.Property.TryGetValue("HeroCourage", out courageProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:HeroCourage");
			return;
		}
		if (!viewModel.Property.TryGetValue("EachHeroCourage", out eachHeroCourageProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:EachHeroCourage");
			return;
		}
		if (!viewModel.Property.TryGetValue("EachHeroCourageNum", out eachHeroCourageNumProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:EachHeroCourageNum");
			return;
		}
		if (!viewModel.Property.TryGetValue("HeroMight", out heroMightProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:HeroMight");
			return;
		}
		if (!viewModel.Property.TryGetValue("EachHeroCourageNoMightHide", out eachHeroCourageNoMightHideProperty))
		{
			Log.Error("长枪武器机制: 属性获取错误:EachHeroCourageNoMightHide");
			return;
		}
		courageProperty.ResetMax(heroCfg.LanceInit[0], isExecuteValueChanged: false);
		lanceViewModel.segmentNum = heroCfg.LanceInit[1];
		lanceViewModel.segmentCount = (int)heroCfg.LanceInit[2];
		lanceViewModel.InitFinish = true;
		eachHeroCourageProperty.ResetInit(lanceViewModel.segmentNum);
		eachHeroCourageProperty.Set(lanceViewModel.segmentNum);
		eachHeroCourageNumProperty.ResetInit(lanceViewModel.segmentCount);
		eachHeroCourageNumProperty.Set(lanceViewModel.segmentCount);
		mightSwitchProperty.Set(heroCfg.LanceInit[3], isIgnoreMax: false, isExecuteValueChanged: false);
		eachHeroCourageNoMightHideProperty.Set(heroCfg.LanceInit[4], isIgnoreMax: false, isExecuteValueChanged: false);
		courageProperty.RegisterOnChangedCallback(this);
		heroMightProperty.RegisterOnChangedCallback(this);
		courageProperty.RegisterOnEstimatedChangedCallback(this);
		heroMightProperty.RegisterOnEstimatedChangedCallback(this);
		eachHeroCourageProperty.RegisterOnChangedCallback(this);
		eachHeroCourageNumProperty.RegisterOnChangedCallback(this);
	}

	public void OnPropertyEstimatedChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "HeroCourage" && !(heroMightProperty.CurValue > 0f))
		{
			float num = courageProperty.CurValue + delta;
			if (num > courageProperty.MaxValue)
			{
				courageOverflowingValue = num - courageProperty.MaxValue;
			}
			else
			{
				courageOverflowingValue = 0f;
			}
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		switch (propertyName)
		{
		case "HeroCourage":
		case "HeroMight":
			if (courageProperty.IsMax && mightSwitchProperty.CurValue.FloatEquals(1f) && heroMightProperty.CurValue.FloatEquals(0f))
			{
				courageProperty.Set(courageOverflowingValue);
				heroMightProperty.ResetValue(toMax: true);
				PlayWeaponIndicatorRing();
				courageOverflowingValue = 0f;
			}
			break;
		case "EachHeroCourage":
			OnUpdateEachHeroCourage();
			break;
		case "EachHeroCourageNum":
			OnUpdateEachHeroCourage();
			break;
		}
	}

	private void OnUpdateEachHeroCourage()
	{
		lanceViewModel.segmentNum = eachHeroCourageProperty.CurValue;
		lanceViewModel.segmentCount = (int)eachHeroCourageNumProperty.CurValue;
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
	}

	public override void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		base.AddWeaponValueByDamageProgress(damageProgress, property, value);
	}

	public override void AddLayer(int layer)
	{
	}

	public override void SetLayer(int layer)
	{
	}

	public override void SendReleaseSkill(BaseEntity entity, HeroSkillTypeEnum skillType)
	{
	}

	public override void OnDispose()
	{
		base.OnDispose();
		courageProperty.RemoveOnEstimatedChangedCallback(this);
		courageProperty.RemoveOnChangedCallback(this);
		heroMightProperty.RemoveOnEstimatedChangedCallback(this);
		heroMightProperty.RemoveOnChangedCallback(this);
		eachHeroCourageProperty.RemoveOnChangedCallback(this);
		eachHeroCourageNumProperty.RemoveOnChangedCallback(this);
	}
}
