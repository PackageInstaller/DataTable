#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class WeaponMechanismSword : WeaponMechanismBase, IPropertyChanged
{
	private enum ReduceState
	{
		None,
		Auto,
		Min
	}

	private struct KeennessLayerData
	{
		public float min;

		public float max;

		public float protectTime;
	}

	protected WeaponMechanismSwordViewModel swordViewModel;

	private float curLimitTime;

	private float attenuationDuration;

	private int attenuationLayer;

	private ReduceState state;

	private int curLevel;

	private int maxLevel;

	private List<int> curAddBuff = new List<int>();

	private Dictionary<int, List<int>> additionBuffConfig = new Dictionary<int, List<int>>();

	private Dictionary<int, KeennessLayerData> layerLevelConfig = new Dictionary<int, KeennessLayerData>();

	private Dictionary<int, float> attenuationTimeConfig = new Dictionary<int, float>();

	private Dictionary<int, int> attenuationLayerConfig = new Dictionary<int, int>();

	protected Ase.ECS.PropertyData keennessLayerProperty;

	protected float curProtectTime;

	public WeaponMechanismSword(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		swordViewModel = viewModel as WeaponMechanismSwordViewModel;
		ownerEntity = entity;
	}

	public override void OnStart()
	{
		state = ReduceState.Auto;
		try
		{
			maxLevel = heroCfg.KeennessLevel.Count;
			if (heroCfg.KeennessProtectTime.Count != heroCfg.KeennessLevel.Count - 1)
			{
				Log.Error("开刃参数配置异常，请检查配置表");
				return;
			}
			List<float> list = new List<float>(heroCfg.KeennessLevel.Count);
			float maxLayer = 0f;
			int index;
			for (int i = 0; i < heroCfg.KeennessLevel.Count; i++)
			{
				additionBuffConfig.Add(i, heroCfg.KeennessBuff[i]);
				attenuationTimeConfig.Add(i, heroCfg.KeennessReduceTime[i]);
				attenuationLayerConfig.Add(i, heroCfg.KeennessReduceValue[i]);
				KeennessLayerData keennessLayerData = new KeennessLayerData
				{
					min = ((i > 0) ? (heroCfg.KeennessLevel[i - 1] + 1) : 0)
				};
				int num;
				if (i >= heroCfg.KeennessLevel.Count - 1)
				{
					List<int> keennessLevel = heroCfg.KeennessLevel;
					index = keennessLevel.Count - 1;
					num = keennessLevel[index];
				}
				else
				{
					num = heroCfg.KeennessLevel[i];
				}
				keennessLayerData.max = num;
				keennessLayerData.protectTime = ((i == 0) ? 9999f : heroCfg.KeennessProtectTime[i - 1]);
				KeennessLayerData value = keennessLayerData;
				list.Add(value.max);
				maxLayer = value.max;
				layerLevelConfig.Add(i, value);
			}
			curLevel = 0;
			List<int> keennessLevel2 = heroCfg.KeennessLevel;
			index = keennessLevel2.Count - 1;
			int num2 = keennessLevel2[index];
			ownerEntity.SetPropertyMax("KeennessLayer", num2);
			swordViewModel.SetLayerFillAmountData(list, maxLayer);
			if (viewModel.Property.TryGetValue("KeennessLayer", out keennessLayerProperty))
			{
				keennessLayerProperty.RegisterOnChangedCallback(this);
			}
			DoChangeAddition();
			DoChangeAttenuation();
		}
		catch (Exception ex)
		{
			Log.Error("开刃参数配置异常，请检查配置表！" + ex.Message + "/" + ex.StackTrace);
			Toast.ShowError("开刃参数配置异常，请检查配置表！");
		}
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		if (!ownerEntity.IsSurvival || keennessLayerProperty == null || keennessLayerProperty.CurValue <= 0f)
		{
			return;
		}
		switch (state)
		{
		case ReduceState.Auto:
			curLimitTime += timeScaleDeltaTime;
			if (curLimitTime >= attenuationDuration)
			{
				curLimitTime -= attenuationDuration;
				ReduceLayerAuto(attenuationLayer);
			}
			swordViewModel.SetProtectTimeFill(1f);
			break;
		case ReduceState.Min:
			curLimitTime += timeScaleDeltaTime;
			if (curLimitTime >= curProtectTime)
			{
				ReduceLayer(attenuationLayer);
			}
			swordViewModel.SetProtectTimeFill((curProtectTime - curLimitTime) / curProtectTime);
			break;
		}
	}

	private void ChangeReduceState(ReduceState state, bool forceReset = true)
	{
		if (this.state == state)
		{
			if (forceReset)
			{
				curLimitTime = 0f;
			}
		}
		else
		{
			curLimitTime = 0f;
			this.state = state;
		}
	}

	private void DoChangeAttenuation()
	{
		if (curLevel >= maxLevel)
		{
			Log.Error($"长剑武器机制错误，等级超出最大值 : cur ({curLevel}) max ({maxLevel})");
			return;
		}
		attenuationDuration = attenuationTimeConfig[curLevel];
		attenuationLayer = attenuationLayerConfig[curLevel];
		curProtectTime = layerLevelConfig[curLevel].protectTime;
	}

	private void DoChangeAddition()
	{
		BuffSystem system = ownerEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < curAddBuff.Count; i++)
		{
			system.FinishEntityBuff(ownerEntity.Id, curAddBuff[i]);
		}
		curAddBuff.Clear();
		if (curLevel == -1)
		{
			return;
		}
		List<int> list = additionBuffConfig[curLevel];
		for (int j = 0; j < list.Count; j++)
		{
			DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(list[j]);
			if (dataRow != null)
			{
				system.AcquireBuff(ownerEntity, ownerEntity, dataRow);
				curAddBuff.Add(list[j]);
			}
			else
			{
				Log.Error($"开刃Buff加成，BuffId {list[j]} 配置有误，请检查配置表！");
				Toast.ShowError("开刃Buff加成，BuffId配置有误，请检查配置表！");
			}
		}
	}

	public override void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		if (!(property != "KeennessLayer") && (!(swordViewModel.KeennessRatio <= 0f) || !(value > 0f)))
		{
			AddLayer((int)value);
		}
	}

	public override void SetLayer(int layer)
	{
		float curValue = keennessLayerProperty.CurValue;
		float num = (float)layer - curValue;
		float num2 = CheckLayerUnLock((int)num);
		if (num2 != 0f)
		{
			keennessLayerProperty.Set(num2);
			ChangeReduceState(ReduceState.Auto);
		}
	}

	public override void AddLayer(int layer)
	{
		float num = CheckLayerUnLock(layer);
		if (num != 0f)
		{
			keennessLayerProperty.Addition(num, isIgnoreMax: false);
			ChangeReduceState(ReduceState.Auto);
		}
	}

	public void ReduceLayerAuto(int layer)
	{
		layer = Math.Max(0, layer - (int)ownerEntity.GetProperty("KeennessAmpliValue"));
		float addition = CheckLayerUnLock(-layer, isAutoReduce: true);
		addition = keennessLayerProperty.Addition(addition, isIgnoreMax: false);
	}

	public override void ReduceLayer(int layer)
	{
		layer = (int)keennessLayerProperty.Addition(-layer, isIgnoreMax: false);
		ChangeReduceState(ReduceState.Auto);
	}

	protected override void OnLayerChanged(int layer)
	{
		int b = 0;
		if (layer == 0)
		{
			b = 0;
		}
		else
		{
			for (int i = 0; i < layerLevelConfig.Count && (float)layer >= layerLevelConfig[i].min; i++)
			{
				b = i;
			}
		}
		b = Mathf.Min(layerLevelConfig.Count - 1, b);
		if (b != curLevel)
		{
			if (b > curLevel)
			{
				PlayWeaponIndicatorRing();
			}
			curLevel = b;
			DoChangeAttenuation();
			DoChangeAddition();
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "KeennessLayer" && delta != 0f)
		{
			OnLayerChanged((int)keennessLayerProperty.CurValue);
			if (delta > 0f)
			{
				OnWeaponDataChangeStat(WeaponStatEnum.SwordLayer, delta);
			}
		}
	}

	protected float CheckLayerUnLock(int layer, bool isAutoReduce = false)
	{
		if (layer == 0)
		{
			return 0f;
		}
		float curValue = keennessLayerProperty.CurValue;
		float num = Mathf.Clamp(curValue + (float)layer, keennessLayerProperty.MinValue, keennessLayerProperty.MaxValue);
		int b = 0;
		for (int i = 0; i < layerLevelConfig.Count && num >= layerLevelConfig[i].min; i++)
		{
			b = i;
		}
		b = Mathf.Min(layerLevelConfig.Count - 1, b);
		if (b == curLevel)
		{
			return layer;
		}
		_ = curLevel;
		int num2 = (int)ownerEntity.GetProperty("KeennessLayerUnLockLayer");
		if (num2 == 0 && b > curLevel)
		{
			return (int)(layerLevelConfig[curLevel].max - curValue);
		}
		if ((num2 == 0 && b < curLevel) & isAutoReduce)
		{
			ChangeReduceState(ReduceState.Min);
			int key = Mathf.Max(curLevel, 0);
			return (int)(layerLevelConfig[key].min - curValue);
		}
		if (isAutoReduce)
		{
			int key2 = Mathf.Max(curLevel, 0);
			return (int)(layerLevelConfig[key2].min - curValue);
		}
		return layer;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (keennessLayerProperty != null)
		{
			keennessLayerProperty.RemoveOnChangedCallback(this);
		}
	}
}
