using System.Collections.Generic;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoAbyssCompleteView : BaseUIView
{
	public class AbyssCompleteData : UIViewData
	{
		public MonoScrollBagComponent.Param scrollBagParam;

		public bool haveNext;

		public AbyssStage abyssStage;

		public int time;
	}

	public CommonScrollBagComponent scrollBag;

	public GameObject nextBtn;

	public TextMeshProUGUI minute;

	public TextMeshProUGUI second;

	public List<GameObject> stars;

	public List<GameObject> lights;

	public List<LocalizeStringEvent> abyssTargetObjs;

	public GameObject rewardTitle;

	public AbyssCompleteData param;

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Hide").Play();
	}

	protected override void Init()
	{
		base.Init();
		if (uiViewData != null)
		{
			param = (AbyssCompleteData)uiViewData;
		}
		List<ItemUnifierProxy> list = ListPool<ItemUnifierProxy>.Get();
		ItemUnifierProxy.ItemUnifierPool.GetList(param.scrollBagParam.allItems.items, list);
		scrollBag.gameObject.SetActive(value: true);
		scrollBag.ItemSource = list;
		scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		rewardTitle.SetActive(param.scrollBagParam.allItems.items.Count != 0);
		nextBtn.SetActive(param.haveNext);
		minute.SetText("{0:00}", param.time / 60);
		second.SetText("{0:00}", param.time % 60);
		_ = param.abyssStage;
		List<int> abyssTarget = Model<AbyssModel>.Interface.AbyssTarget;
		for (int i = 0; i < stars.Count; i++)
		{
			bool flag = i < abyssTarget.Count;
			stars[i].SetActive(flag);
			if (flag)
			{
				int value = abyssTarget[i] / 60;
				int value2 = abyssTarget[i] % 60;
				abyssTargetObjs[i].StringReference.TableEntryReference = 615L;
				abyssTargetObjs[i].StringReference.GetVariable<int>("0").Value = value;
				abyssTargetObjs[i].StringReference.GetVariable<int>("1").Value = value2;
				lights[i].SetActive(param.time <= abyssTarget[i]);
				if (param.time > abyssTarget[i])
				{
					abyssTargetObjs[i].GetComponent<TextMeshProUGUI>().color = new Color(1f, 1f, 1f, 1f);
				}
			}
		}
		Model<AbyssModel>.Interface.RefreshData();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public void LeaveAbyss()
	{
		G.service.LeaveAbyss((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			}
		});
	}

	public async void RechallengeAbyss()
	{
	}

	public void NextAbyss()
	{
		_ = Model<AbyssModel>.Interface.GroupId;
		_ = Model<AbyssModel>.Interface.CurAbyssStageIndex;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST, new MonoAbyssListData
		{
			IsOpenAbyssTeamPanel = true
		});
	}
}
