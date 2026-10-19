using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CardDrawSettleView : BaseUIView
{
	private CardDrawSettleViewData m_data;

	public Button BtnClose;

	public GameObject GoSingleResult;

	public CardDrawResultCell GoSingleItem;

	public GameObject GoMultipleResult;

	public List<CardDrawResultCell> ListMultipleItem;

	public GameObject GoExtraitem;

	public List<LiteItemUIComponent> _LiteItems;

	public GameObject GoAniMask;

	private bool IsSingle;

	public BetterAnimation Ani;

	public AcquireCharacterShowComponent acquireCharacterShowComponent;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		PreInitPanel();
		BtnClose.gameObject.SetActive(value: false);
	}

	private void PreInitPanel()
	{
		m_data = uiViewData as CardDrawSettleViewData;
		if (m_data != null)
		{
			IsSingle = m_data.lististResult.Count == 1;
		}
	}

	protected override void Init()
	{
		base.Init();
		BtnClose.SetBtnClick(Close);
		CheckIsShowCharacter();
		InitPanel();
	}

	private void CheckIsShowCharacter()
	{
		if (m_data.isShowCharacter)
		{
			AcquireCharacterShowConfig acquireCharacterShowConfig = new AcquireCharacterShowConfig
			{
				_listsNeedShow = m_data.listNeedShow,
				onCloseCallback = ShowCardSettle,
				isNeedShowOpenAni = true,
				_listsCardDrawSettle = m_data.lististResult
			};
			acquireCharacterShowComponent.InitPanel(acquireCharacterShowConfig, Station);
		}
	}

	private void ShowCardSettle()
	{
		FinallyResultShow();
		PlayRewardAnimation();
	}

	public void InitPanel()
	{
		FinallyResultShow();
	}

	private void FinallyResultShow()
	{
		GoSingleResult.SetActive(IsSingle);
		GoMultipleResult.SetActive(!IsSingle);
		for (int i = 0; i < _LiteItems.Count; i++)
		{
			_LiteItems[i].gameObject.SetActive(value: false);
		}
		if (IsSingle)
		{
			ShowSingleItem();
		}
		else
		{
			ShowMultipleItem();
		}
		ShowExtraitem();
	}

	private void PlayRewardAnimation()
	{
		if (IsSingle)
		{
			if (CoreUtils.GetData(m_data.lististResult[0].PoolItem.Id, RuntimeConfigs.data.itemDatas).type == 5)
			{
				betterAnimation.GetSequence("CharacterShowSingle").OnComplete((AnimationBuilder builder) =>
				{
					BtnClose.gameObject.SetActive(value: true);
				}).Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role", new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
			else
			{
				betterAnimation.GetSequence("ItemShowSingle").OnComplete((AnimationBuilder builder) =>
				{
					BtnClose.gameObject.SetActive(value: true);
				}).Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward10_Role", new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
		}
		else
		{
			betterAnimation.GetSequence("Ten").Play().OnComplete((AnimationBuilder builder) =>
			{
				ItemPlayAnimation();
				BtnClose.gameObject.SetActive(value: true);
			});
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Settlement_Gold", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
	}

	private void ItemPlayAnimation()
	{
		for (int i = 0; i < ListMultipleItem.Count; i++)
		{
			ListMultipleItem[i].CheckNeedPlayAni();
		}
	}

	private void ShowSingleItem()
	{
		GoSingleItem.Init(m_data.lististResult[0], Station, m_data.lististResult[0].CharacterMaxConstellation, isSingle: true, m_data.gachaId, m_data.gachaType);
		GoSingleItem.SetCanvaGroupAlpha(0f);
	}

	private void ShowExtraitem()
	{
		Dictionary<int, Item> dictionary = new Dictionary<int, Item>();
		for (int i = 0; i < m_data.lististResult.Count; i++)
		{
			for (int j = 0; j < m_data.lististResult[i].ExtraItem.Count; j++)
			{
				if (!m_data.lististResult[i].CharacterMaxConstellation)
				{
					if (dictionary.TryGetValue(m_data.lististResult[i].ExtraItem[j].Id, out var value))
					{
						value.Count += m_data.lististResult[i].ExtraItem[j].Count;
						continue;
					}
					Item item = new Item();
					item.Id = m_data.lististResult[i].ExtraItem[j].Id;
					item.Count = m_data.lististResult[i].ExtraItem[j].Count;
					dictionary.Add(item.Id, item);
				}
			}
		}
		List<Item> list = dictionary.Values.ToList();
		for (int k = 0; k < list.Count; k++)
		{
			if (k < _LiteItems.Count)
			{
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(list[k].Id, list[k].Count);
				_LiteItems[k].SetData(item2, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				_LiteItems[k].UpdatePerformance();
				_LiteItems[k].gameObject.SetActive(value: true);
			}
		}
	}

	private void ShowMultipleItem()
	{
		for (int i = 0; i < m_data.lististResult.Count; i++)
		{
			ListMultipleItem[i].Init(m_data.lististResult[i], Station, m_data.lististResult[i].CharacterMaxConstellation, isSingle: false, m_data.gachaId, m_data.gachaType);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (m_data.isNeedShowOpenAni)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role_1");
			Ani.gameObject.SetActive(value: true);
			Ani.GetSequence("Show").Play().OnComplete((AnimationBuilder builder) =>
			{
				Ani.gameObject.SetActive(value: false);
				if (!m_data.isShowCharacter)
				{
					PlayRewardAnimation();
				}
			});
		}
		else
		{
			PlayRewardAnimation();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		if (BtnClose.gameObject.activeSelf)
		{
			base.Close();
		}
	}
}
