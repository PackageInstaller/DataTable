using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AcquireCharacterShowPurpleView : BaseUIView
{
	private AcquireCharacterShowViewData m_data;

	[SerializeField]
	private LocalizeStringEvent textName;

	[SerializeField]
	private BImage imageName;

	[SerializeField]
	private List<GameObject> _starList;

	[SerializeField]
	private GameObject goNew;

	[SerializeField]
	private CharacterProfessionIcon imageProfession;

	[SerializeField]
	private BImage imageInfluences;

	[SerializeField]
	private BImage characterImage;

	[SerializeField]
	private List<AcquireCharacterShowExtraItem> _extraItems;

	[SerializeField]
	private ActButton BtnNext;

	[SerializeField]
	private BetterAnimation Ani;

	[SerializeField]
	private BImage ImageQuality;

	[SerializeField]
	private GameObject EffectQualityS;

	[SerializeField]
	private GameObject EffectQualityA;

	[SerializeField]
	private BImage characterBgImage;

	private int CurrentIndex;

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
		BtnNext.SetBtnClick(Next);
		m_data = uiViewData as AcquireCharacterShowViewData;
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
	}

	private void InitPanel()
	{
		CurrentIndex = 0;
		BtnNext.gameObject.SetActive(value: false);
		ShowPanel(0);
	}

	private void Next()
	{
		if (CurrentIndex < m_data._listsNeedShow.Count - 1)
		{
			BtnNext.gameObject.SetActive(value: false);
			CurrentIndex++;
			PlayCharacterShowSound();
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
				BtnNext.gameObject.SetActive(value: true);
			}).Play();
			ShowPanel();
			return;
		}
		Close();
		if (m_data.isNeedSettle)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CARDDRAWSETTLE, new CardDrawSettleViewData
			{
				lististResult = m_data._listsCardDrawSettle
			});
		}
		else if (m_data.items != null && m_data.items.Count > 0)
		{
			GameUtility.OpenNormalReward(new NomalRewardOneViewData
			{
				itemList = GameUtility.ToUniversalItems(m_data.items)
			});
		}
	}

	private void ShowPanel(int index)
	{
		if (m_data._listsNeedShow != null && m_data._listsNeedShow.Count != 0)
		{
			AcquireCharacterShowItemData acquireCharacterShowItemData = m_data._listsNeedShow[index];
			goNew.SetActive(acquireCharacterShowItemData.IsNew);
			ItemData data = CoreUtils.GetData(acquireCharacterShowItemData.Id, RuntimeConfigs.data.itemDatas);
			if (data != null)
			{
				int id = data.canBeTransited[0].id;
				EntityCharacterData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
				imageProfession.UpdateDisPlay(id);
				Station.LoadImage(160, data2.characterNameEng, imageName);
				Station.LoadImage(113, data2.characterArt, characterImage);
				textName.StringReference.TableEntryReference = data.nameLocal;
				QualityInit(data.quality);
				SetExtraItems(data);
			}
		}
	}

	private void ShowPanel()
	{
		AcquireCharacterShowItemData acquireCharacterShowItemData = m_data._listsNeedShow[CurrentIndex];
		goNew.SetActive(acquireCharacterShowItemData.IsNew);
		ItemData data = CoreUtils.GetData(acquireCharacterShowItemData.Id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			int id = data.canBeTransited[0].id;
			EntityCharacterData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
			CoreUtils.GetData(id, RuntimeConfigs.data.entityDatas);
			if (data2 != null)
			{
				imageProfession.UpdateDisPlay(id);
				Station.LoadImage(160, data2.characterNameEng, imageName);
				Station.LoadImage(113, data2.characterArt, characterImage);
			}
			textName.StringReference.TableEntryReference = data.nameLocal;
			QualityInit(data.quality);
			SetExtraItems(data);
		}
	}

	private void QualityInit(int Quality)
	{
		Station.LoadImage(176, Quality, ImageQuality);
		EffectQualityS.SetActive(Quality == 5);
		EffectQualityA.SetActive(Quality == 4);
	}

	private void SetExtraItems(ItemData itemData)
	{
		EntityCharacterData data = CoreUtils.GetData(itemData.canBeTransited[0].id, RuntimeConfigs.data.entityCharacterDatas);
		AcquireCharacterShowItemData acquireCharacterShowItemData = m_data._listsNeedShow[CurrentIndex];
		List<Item> list = new List<Item>();
		if (!acquireCharacterShowItemData.IsNew)
		{
			int num = 0;
			int num2 = 0;
			if (acquireCharacterShowItemData.CharacterMaxConstellation)
			{
				num2 = RuntimeConfigs.data.game.gachaDrawRoleToken;
				if (data.stars == 4)
				{
					num = RuntimeConfigs.data.game.gachaDraw4StarDestinedNum;
				}
				else if (data.stars >= 5)
				{
					num = RuntimeConfigs.data.game.gachaDraw5StarDestinedNum;
				}
			}
			else
			{
				num2 = data.ConstellationItem;
				num = 1;
				Item item = new Item();
				item.Id = num2;
				item.Count = num;
				list.Add(item);
			}
		}
		if (acquireCharacterShowItemData.ExtraItem != null)
		{
			for (int i = 0; i < acquireCharacterShowItemData.ExtraItem.Count; i++)
			{
				Item item2 = new Item();
				item2.Id = acquireCharacterShowItemData.ExtraItem[i].Id;
				item2.Count = acquireCharacterShowItemData.ExtraItem[i].Count;
				list.Add(item2);
			}
		}
		for (int j = 0; j < _extraItems.Count; j++)
		{
			if (j <= list.Count - 1)
			{
				_extraItems[j].Init(list[j], Station);
			}
			_extraItems[j].gameObject.SetActive(j <= list.Count - 1);
		}
		RefreshCharacterBg(data.stars);
	}

	private void RefreshCharacterBg(int characterDataStars)
	{
		Station.LoadImage(192, characterDataStars, characterBgImage);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (m_data.isNeedShowOpenAni)
		{
			Ani.gameObject.SetActive(value: true);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role_1");
			Ani.GetSequence("Show").Play().OnComplete((AnimationBuilder builder) =>
			{
				Ani.gameObject.SetActive(value: false);
				PlayCharacterShowSound();
				betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
				{
					OpenEffectFinishNew();
					BtnNext.gameObject.SetActive(value: true);
				}).Play();
			});
		}
		else
		{
			PlayCharacterShowSound();
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
				BtnNext.gameObject.SetActive(value: true);
			}).Play();
		}
	}

	private void PlayCharacterShowSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role_2", new AudioPlayOptions
		{
			attachTarget = transform
		});
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
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
			m_data?.onCloseCallback?.Invoke();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
