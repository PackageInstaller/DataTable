using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Sound;
using Bamboo;
using Bamboo.NumberString;
using Bamboo.Pool;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public abstract class LevelUpPanel<T> : MonoBehaviour where T : LevelUpPanelData, new()
{
	[SerializeField]
	private CoinComponent hasRoleExp;

	[SerializeField]
	private CoinComponent hasCoin;

	[SerializeField]
	protected LevelUpPreview levelUpPreview;

	[SerializeField]
	private List<PropertyCell> propertyCells;

	[SerializeField]
	protected LevelUpScrollView levelUpScrollView;

	[SerializeField]
	protected LevelUpOSA levelUpOSA;

	[SerializeField]
	protected GameObject toMaxRoot;

	[SerializeField]
	protected ActButton toMaxBtn;

	[SerializeField]
	private ParticleSystem effectParticles;

	[SerializeField]
	protected GameObject reachMaxText;

	[SerializeField]
	protected TextMeshProUGUI maxLevelText;

	[SerializeField]
	protected GameObject toMaxLeftArrow;

	[SerializeField]
	protected GameObject toMaxRightArrow;

	[SerializeField]
	protected ActButton upgradeBtn;

	private List<LevelNumData> _data;

	protected T _panelData;

	protected Type _type;

	protected int _selectLevel;

	protected int _normalSelectLevel;

	public bool IsInitialized { get; private set; }

	public int SelectedLevel => _selectLevel;

	public virtual void Init(LevelUpPanelData data)
	{
		gameObject.SetActive(value: true);
		InitPanelData(data);
		levelUpPreview.Init(_panelData.CurLevel, _panelData.MaxLevel, _panelData.AddLevel);
		InitPropertyCells(_panelData.Properties, _panelData.AddLevel, _panelData.ReachMax);
		reachMaxText.SetActive(_panelData.CurLevel == _panelData.FinallyMaxLevel);
		toMaxRoot.SetActive(_panelData.CurLevel + 1 != _panelData.ItemEnoughLevel && _panelData.CurLevel + 1 <= _panelData.MaxLevel && (_panelData.CurLevel < _panelData.ItemEnoughLevel || _panelData.ItemEnoughLevel == 0));
		maxLevelText.text = ((_panelData.ItemEnoughLevel == 0) ? _panelData.MaxLevel.FastToString() : _panelData.ItemEnoughLevel.FastToString());
		if (toMaxRightArrow != null)
		{
			toMaxRightArrow?.SetActive(value: true);
			toMaxLeftArrow?.SetActive(value: false);
		}
		levelUpOSA.PassingAudioEventName = "event:/UI/Interface/Skill/Upgrade_Slide";
		if (!IsInitialized)
		{
			if (hasRoleExp != null)
			{
				hasRoleExp.Initialize();
			}
			if (hasCoin != null)
			{
				hasCoin.Initialize();
			}
			InitLevelScrollView(_panelData);
			upgradeBtn.OnClick.AddListener(Upgrade);
			upgradeBtn.OnLongPressUpdate.AddListener(Upgrade);
			IsInitialized = true;
		}
		else
		{
			levelUpOSA.OnReset(_panelData.MinLevel, _panelData.MaxLevel, _panelData.CurLevel, _panelData.AddLevel, _panelData.FinallyMaxLevel, _panelData.ItemEnoughLevel, _panelData.NormalSelectLevel);
		}
	}

	protected virtual void InitPanelData(LevelUpPanelData data)
	{
		_panelData = data as T;
		_type = TypeCache<T>.TYPE;
		_selectLevel = ((_panelData.NormalSelectLevel > _panelData.CurLevel) ? Mathf.Clamp(_panelData.NormalSelectLevel, _panelData.MinLevel, _panelData.MaxLevel) : (_panelData.CurLevel + _panelData.AddLevel));
	}

	public virtual void UnInit()
	{
		gameObject.SetActive(value: false);
		if (levelUpScrollView != null)
		{
			levelUpScrollView.onComplete.RemoveAllListeners();
		}
		if (levelUpOSA != null)
		{
			levelUpOSA.Unload();
		}
		toMaxBtn.OnClick.RemoveAllListeners();
		upgradeBtn.OnClick.RemoveAllListeners();
		upgradeBtn.OnLongPressUpdate.RemoveAllListeners();
		IsInitialized = false;
		RecyclePool<T>.Default.RecycleObject(_panelData);
	}

	protected virtual void OnUpgradeSuccess(int preLevel, int curLevel, int addLevel = 1)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Upgrade", new AudioPlayOptions
		{
			attachTarget = transform
		});
		_panelData.SetDataByUpgradeSuccess(curLevel, addLevel);
		_selectLevel = curLevel + addLevel;
		levelUpPreview.Init(_panelData.CurLevel, _panelData.MaxLevel, _panelData.AddLevel);
		InitPropertyCells(_panelData.Properties, _panelData.AddLevel, _panelData.ReachMax);
		levelUpOSA.OnReset(_panelData.MinLevel, _panelData.MaxLevel, _panelData.CurLevel, _panelData.AddLevel, _panelData.FinallyMaxLevel, _panelData.ItemEnoughLevel);
		PlayPropertyCellsUpgradeAnim();
		OnAddLevelChange(addLevel);
	}

	private void InitPropertyCells(List<Properties> properties, int addLevel, bool reachMax)
	{
		if (properties.Count > propertyCells.Count)
		{
			int num = properties.Count - propertyCells.Count;
			for (int i = 0; i < num; i++)
			{
				propertyCells.Add(UnityEngine.Object.Instantiate(propertyCells[0], propertyCells[0].transform.parent, worldPositionStays: false).GetComponent<PropertyCell>());
			}
		}
		for (int j = 0; j < propertyCells.Count; j++)
		{
			propertyCells[j].gameObject.SetActive(j < properties.Count);
		}
		for (int k = 0; k < properties.Count; k++)
		{
			Properties properties2 = properties[k];
			PropertyData data = CoreUtils.GetData(properties2.property, RuntimeConfigs.data.propertyDatas);
			float num2 = (data.judge ? (GetCurPropertyVal(properties2) * 10000f) : GetCurPropertyVal(properties2));
			float num3 = (data.judge ? (GetAddPropertyVal(properties2, addLevel) * 10000f) : GetAddPropertyVal(properties2, addLevel));
			if (reachMax)
			{
				propertyCells[k].ShowInitInNumNeedIcon(data, Mathf.Ceil(num2), _panelData._station);
			}
			else
			{
				propertyCells[k].ShowInitInNumNeedIcon(data, Mathf.Ceil(num2), _panelData._station, data, Mathf.Ceil(num2 + num3));
			}
		}
	}

	protected void PlayPropertyCellsUpgradeAnim()
	{
		foreach (PropertyCell propertyCell in propertyCells)
		{
			propertyCell.SetEffectRoot(null);
		}
	}

	private void InitLevelScrollView(T panelData)
	{
		if (levelUpScrollView != null)
		{
			_data = new List<LevelNumData>();
			for (int i = 0; i < panelData.MaxLevel; i++)
			{
				_data.Add(new LevelNumData());
			}
			levelUpScrollView.onComplete.AddListener(OnSelectLevel);
			levelUpScrollView.UpdateData(_data);
			levelUpScrollView.SetMinIndex(panelData.CurLevel);
			levelUpScrollView.SetMaxLevel(panelData.MaxLevel);
			levelUpScrollView.InitSelectedCell(panelData.CurLevel);
		}
		else if (levelUpOSA != null)
		{
			levelUpOSA.Reload(panelData.MinLevel, panelData.MaxLevel, panelData.CurLevel, panelData.AddLevel, OnSelectLevel, panelData.FinallyMaxLevel, panelData.ItemEnoughLevel, panelData.NormalSelectLevel);
		}
		toMaxBtn.OnClick.AddListener(ScrollToMaxLevel);
	}

	protected abstract float GetCurPropertyVal(Properties properties);

	protected abstract float GetAddPropertyVal(Properties properties, int addLevel);

	protected virtual void OnAddLevelChange(int addVal)
	{
		InitPropertyCells(_panelData.Properties, addVal, _panelData.ReachMax);
		levelUpPreview.SetUpLevel((_panelData.MaxLevel > _panelData.CurLevel) ? addVal : 0);
	}

	protected virtual void OnAddLevelChange(int addVal, bool onlyShowCurValue)
	{
		InitPropertyCells(_panelData.Properties, addVal, onlyShowCurValue);
		levelUpPreview.SetUpLevel((_panelData.MaxLevel > _panelData.CurLevel) ? addVal : 0);
	}

	private void OnSelectLevel(int selectLevel)
	{
		_selectLevel = selectLevel;
		OnAddLevelChange(selectLevel - _panelData.CurLevel);
		reachMaxText.SetActive(selectLevel == _panelData.FinallyMaxLevel);
		toMaxRoot.SetActive(selectLevel != _panelData.ItemEnoughLevel && selectLevel <= _panelData.MaxLevel && (_panelData.CurLevel < _panelData.ItemEnoughLevel || _panelData.ItemEnoughLevel == 0));
		if (_panelData.ItemEnoughLevel != 0)
		{
			toMaxLeftArrow?.SetActive(selectLevel > _panelData.ItemEnoughLevel);
			toMaxRightArrow?.SetActive(selectLevel < _panelData.ItemEnoughLevel);
		}
		else if (toMaxRightArrow != null)
		{
			toMaxRightArrow?.SetActive(value: true);
			toMaxLeftArrow?.SetActive(value: false);
		}
	}

	public virtual void ScrollToMaxLevel()
	{
		levelUpOSA.ScrollToMaxLevel();
		if (effectParticles != null)
		{
			effectParticles.Play();
		}
	}

	public void ScrollToNextLevel()
	{
		if (_panelData != null)
		{
			int level = Mathf.Clamp(_selectLevel + 1, _panelData.MinLevel, _panelData.MaxLevel);
			levelUpOSA.ScrollToLevel(level);
		}
	}

	public void ScrollToPrevLevel()
	{
		if (_panelData != null)
		{
			int level = Mathf.Clamp(_selectLevel - 1, _panelData.MinLevel, _panelData.MaxLevel);
			levelUpOSA.ScrollToLevel(level);
		}
	}

	protected abstract void Upgrade();
}
