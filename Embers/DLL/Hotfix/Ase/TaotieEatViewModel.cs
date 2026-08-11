using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaotieEatViewModel : OptionBase
{
	private Camera mainCamera;

	private Vector3 bossPos;

	private Vector2 screen2CanvasRatio;

	private List<TaotieEatHeadItemData> headItemDatas;

	private InteractionRequest updateHeroRequest;

	private List<float> rorateAnglesConfig;

	private bool initPos;

	private List<HeroEntity> cacheHeroes;

	public Vector3 BossPos
	{
		get
		{
			return bossPos;
		}
		set
		{
			Set(ref bossPos, value, "BossPos");
		}
	}

	public List<TaotieEatHeadItemData> HeadItemDatas
	{
		get
		{
			return headItemDatas;
		}
		set
		{
			Set(ref headItemDatas, value, "HeadItemDatas");
		}
	}

	public Vector2 Screen2CanvasRatio => screen2CanvasRatio;

	public IInteractionRequest UpdateHeroRequest => updateHeroRequest;

	public TaotieEatViewModel()
	{
	}

	public TaotieEatViewModel(OptionBase parent)
	{
		base.parent = parent;
		headItemDatas = new List<TaotieEatHeadItemData>();
		screen2CanvasRatio = UIUtilly.Screen2CanvasRatioMatchWidth();
		updateHeroRequest = new InteractionRequest(this);
	}

	public void SetEatHeroList(List<HeroEntity> heros)
	{
		if (rorateAnglesConfig == null)
		{
			cacheHeroes = heros;
			return;
		}
		for (int i = 0; i < heros.Count; i++)
		{
			if (i >= headItemDatas.Count)
			{
				headItemDatas.Add(new TaotieEatHeadItemData(this));
				if (i < rorateAnglesConfig.Count)
				{
					headItemDatas[i].ZRootRotateAngle = rorateAnglesConfig[i];
					headItemDatas[i].ZHeadRotateAngle = 0f - rorateAnglesConfig[i];
				}
			}
			headItemDatas[i].HasHero = true;
			headItemDatas[i].IconName = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.BattleAvatar, heros[i].BattleHeroData);
		}
		for (int j = heros.Count; j < 3; j++)
		{
			if (j >= headItemDatas.Count)
			{
				headItemDatas.Add(new TaotieEatHeadItemData(this));
				if (j < rorateAnglesConfig.Count)
				{
					headItemDatas[j].ZRootRotateAngle = rorateAnglesConfig[j];
					headItemDatas[j].ZHeadRotateAngle = 0f - rorateAnglesConfig[j];
				}
			}
			headItemDatas[j].HasHero = false;
		}
		updateHeroRequest.Raise();
	}

	public void SetAngleConfig(List<float> rorateAnglesConfig)
	{
		this.rorateAnglesConfig = ((rorateAnglesConfig == null) ? new List<float>() : rorateAnglesConfig);
		if (cacheHeroes != null)
		{
			SetEatHeroList(cacheHeroes);
			cacheHeroes = null;
		}
	}

	public void UpdateBossPos(Vector3 bossPos)
	{
		BossPos = bossPos;
	}
}
