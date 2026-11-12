using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public abstract class TowerDefenseItemBase
{
	protected FP indicatorRange = 0;

	protected List<LogicEntity> actOnEntities;

	private CoroutineNode coroutine;

	private TowerDefenseItemChargeBase itemChargeTemplete;

	private const string DEFAULT_ITEM_CHARGE_SCIPT_PATH = "AIScript.TowerDefenseItemChargeBase";

	protected ITowerDefenseGameplayHost host;

	public FP IndicatorRng => indicatorRange;

	public int curItemNum
	{
		get
		{
			if (itemChargeTemplete != null)
			{
				return itemChargeTemplete.curItemNum;
			}
			return 0;
		}
	}

	public void InitHost(ITowerDefenseGameplayHost host)
	{
		this.host = host;
	}

	protected virtual void GetTakeEffectGrids()
	{
	}

	public virtual void InitConfig(TowerDefenseItem itemData)
	{
		string text = itemData.ChargeScript;
		if (string.IsNullOrEmpty(text))
		{
			text = "AIScript.TowerDefenseItemChargeBase";
		}
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(text);
		if (localTypeCache != null)
		{
			object obj = Activator.CreateInstance(localTypeCache.type);
			if (obj != null)
			{
				itemChargeTemplete = obj as TowerDefenseItemChargeBase;
				itemChargeTemplete?.InitConfig(itemData.Id, itemData.Amount, itemData.ChargeParam1, itemData.ChargeParam2, itemData.ChargeParam3);
			}
		}
	}

	public virtual void UpdateLogic()
	{
		itemChargeTemplete?.UpdateLogic();
	}

	protected CoroutineNode StartCoroutine(IEnumerator e)
	{
		return SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(e);
	}

	protected void StopCoroutine(CoroutineNode c)
	{
		SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(c);
	}

	public void ActOnEntities(List<LogicEntity> entities)
	{
		actOnEntities = entities;
	}

	public void StartLogic(TSVector2 position)
	{
		StartCoroutine(DoMainLogic(position));
	}

	public void StartChargeLogic()
	{
		itemChargeTemplete?.StartLogic();
	}

	protected abstract IEnumerator DoMainLogic(TSVector2 position);

	protected AdventureFXPlayer PlayEffect(string path, Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, path, typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("塔防特效为空:" + path);
			return null;
		}
		return AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
	}

	protected void PlayAreaEffect(int templeteID, string[] fxAlias, TSVector2 position)
	{
		if (fxAlias == null || fxAlias.Length == 0)
		{
			Debug.LogWarning($"播放区域效果，特效路径为空!{GetType()}");
			return;
		}
		long globAttributeId = GetGlobAttributeId(templeteID);
		FakeAdventureActor fakeActor = ModuleController<AdventureModuleController>.Instance.GetFakeActor(templeteID, globAttributeId, createNew: true, 1);
		if (null == fakeActor)
		{
			Debug.LogError($"创建FakeActor失败:templeteID_{templeteID},attributeID:{globAttributeId}");
			return;
		}
		for (int i = 0; i < fxAlias.Length; i++)
		{
			ILRuntimeAPI.PlayAreaEffect(fakeActor, fxAlias[i], position);
		}
	}

	private long GetGlobAttributeId(int templeteID)
	{
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(templeteID);
		if (monsterValueTempleteAdjust != null)
		{
			int num = 1;
			int num2 = 1;
			return (long)monsterValueTempleteAdjust.TemplateId * 1000L + num2 * 10 + num;
		}
		Debug.LogError($"Task Trigger, MonsterValueTempleteAdjust Config Not Exist, Id:{templeteID}");
		return 0L;
	}

	public void MinusItemNum(int num = 1)
	{
		itemChargeTemplete?.MinusItemCardNum(num);
	}

	public void AddItemNum(int num = 1)
	{
		itemChargeTemplete?.AddItemCardNum(num);
	}

	public virtual bool GridSatisItem_CanUse(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return false;
		}
		if (grid.gridWalkableType != 1)
		{
			return grid.gridDeployType == 2;
		}
		return true;
	}

	public virtual bool GridSatisItem_TakeEffect(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return false;
		}
		if (grid.gridWalkableType != 1)
		{
			return grid.gridDeployType == 2;
		}
		return true;
	}

	public List<int> GetItemTakeEffectGrids(int index)
	{
		int num = IndicatorRng.AsInt();
		if (num <= 0)
		{
			return null;
		}
		List<int> list = new List<int>();
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(index);
		if (grid.IsNull)
		{
			return list;
		}
		TowerDefenseMapData mapData = host.MapData;
		int num2 = num / 2;
		int num3 = 0;
		int sizeX = mapData.sizeX;
		int sizeY = mapData.sizeY;
		for (int i = -num2; i < num - num2; i++)
		{
			for (int j = -num2; j < num - num2; j++)
			{
				if (!(MathF.Abs(i - num3) + MathF.Abs(j - num3) <= (float)num2))
				{
					continue;
				}
				int num4 = grid.x + i;
				int num5 = grid.y + j;
				if (num4 >= 0 && num4 < sizeX && num5 >= 0 && num5 < sizeY)
				{
					TowerDefenseMapData.TowerGrid grid2 = host.GetGrid(num4, num5);
					if (!grid2.IsNull && GridSatisItem_TakeEffect(grid2))
					{
						list.Add(grid2.index);
					}
				}
			}
		}
		return list;
	}
}
