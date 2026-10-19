using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class AcquireCharacterShowComponent : MonoBehaviour
{
	public CharacterDisplayElements goldElements;

	public CharacterDisplayElements purpleElements;

	[SerializeField]
	private ActButton BtnNext;

	[SerializeField]
	private BetterAnimation Ani;

	[SerializeField]
	private BetterAnimation betterAnimation;

	public GameObject goldRoot;

	public GameObject purpleRoot;

	private CharacterDisplayElements currentElements;

	private AcquireCharacterShowConfig m_config;

	private int CurrentIndex;

	private ImageAssetStation m_station;

	private ItemData m_itemData;

	public void InitPanel(AcquireCharacterShowConfig acquireCharacterShowConfig, ImageAssetStation station)
	{
		m_station = station;
		m_config = acquireCharacterShowConfig;
		CurrentIndex = 0;
		BtnNext.gameObject.SetActive(value: false);
		ShowPanel();
		PlayOpenAnimation();
		BtnNext.SetBtnClick(Next);
	}

	private void Next()
	{
		if (CurrentIndex < m_config._listsNeedShow.Count - 1)
		{
			BtnNext.gameObject.SetActive(value: false);
			CurrentIndex++;
			PlayCharacterShowSound();
			ShowPanel();
			PlayerBetterAnimation();
		}
		else
		{
			Hide();
			if (m_config.onAllShowComplete != null)
			{
				m_config.onAllShowComplete();
			}
		}
	}

	private void ShowPanel()
	{
		AcquireCharacterShowData acquireCharacterShowData = m_config._listsNeedShow[CurrentIndex];
		m_itemData = CoreUtils.GetData(acquireCharacterShowData.Id, RuntimeConfigs.data.itemDatas);
		if (m_itemData != null)
		{
			goldRoot.SetActive(value: false);
			purpleRoot.SetActive(value: false);
			if (m_itemData.quality >= 5)
			{
				currentElements = goldElements;
			}
			else
			{
				currentElements = purpleElements;
			}
			int id = m_itemData.canBeTransited[0].id;
			EntityCharacterData data = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
			if (data != null)
			{
				currentElements.goNew.SetActive(acquireCharacterShowData.IsNew);
				currentElements.imageProfession.UpdateDisPlay(id);
				m_station.LoadImage(160, data.characterNameEng, currentElements.imageName);
				m_station.LoadImage(113, data.characterArt, currentElements.characterImage);
			}
			currentElements.textName.StringReference.TableEntryReference = m_itemData.nameLocal;
			if (data != null)
			{
				QualityInit(m_itemData.quality);
				SetExtraItems(m_itemData, data);
				RefreshCharacterBg(data.stars);
			}
		}
	}

	private void QualityInit(int quality)
	{
		m_station.LoadImage(176, quality, currentElements.ImageQuality);
		currentElements.EffectQualityS.SetActive(quality == 5);
		currentElements.EffectQualityA.SetActive(quality == 4);
	}

	private void SetExtraItems(ItemData itemData, EntityCharacterData characterData)
	{
		AcquireCharacterShowData acquireCharacterShowData = m_config._listsNeedShow[CurrentIndex];
		List<Item> list = new List<Item>();
		if (!acquireCharacterShowData.IsNew)
		{
			int num = 0;
			int num2 = 0;
			if (acquireCharacterShowData.CharacterMaxConstellation)
			{
				num2 = RuntimeConfigs.data.game.gachaDrawRoleToken;
				if (characterData.stars == 4)
				{
					num = RuntimeConfigs.data.game.gachaDraw4StarDestinedNum;
				}
				else if (characterData.stars >= 5)
				{
					num = RuntimeConfigs.data.game.gachaDraw5StarDestinedNum;
				}
			}
			else
			{
				num2 = characterData.ConstellationItem;
				num = 1;
				Item item = new Item();
				item.Id = num2;
				item.Count = num;
				list.Add(item);
			}
		}
		if (acquireCharacterShowData.ExtraItem != null)
		{
			for (int i = 0; i < acquireCharacterShowData.ExtraItem.Count; i++)
			{
				Item item2 = new Item();
				item2.Id = acquireCharacterShowData.ExtraItem[i].Id;
				item2.Count = acquireCharacterShowData.ExtraItem[i].Count;
				list.Add(item2);
			}
		}
		for (int j = 0; j < currentElements.extraItems.Count; j++)
		{
			if (j < list.Count)
			{
				currentElements.extraItems[j].Init(list[j], m_station);
			}
			currentElements.extraItems[j].gameObject.SetActive(j < list.Count);
		}
	}

	private void RefreshCharacterBg(int characterDataStars)
	{
		m_station.LoadImage(192, characterDataStars, currentElements.characterBgImage);
	}

	private void PlayCharacterShowSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role_2", new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void PlayOpenAnimation()
	{
		if (m_config.isNeedShowOpenAni)
		{
			gameObject.SetActive(value: true);
			Ani.gameObject.SetActive(value: true);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward_Role_1");
			AnimationBuilder sequence = Ani.GetSequence("AcquireCharacterShow");
			sequence?.Goto(0f);
			sequence?.Play().OnComplete((AnimationBuilder builder) =>
			{
				Ani.gameObject.SetActive(value: false);
				PlayCharacterShowSound();
				if (m_itemData.quality >= 5)
				{
					goldRoot.SetActive(value: true);
				}
				else
				{
					purpleRoot.SetActive(value: true);
				}
				PlayerBetterAnimation();
			});
		}
		else
		{
			PlayCharacterShowSound();
			gameObject.SetActive(value: true);
			PlayerBetterAnimation();
		}
	}

	private void PlayerBetterAnimation()
	{
		AnimationBuilder sequence = betterAnimation.GetSequence("AcquireCharacterShow");
		sequence?.Goto(0f);
		if (m_itemData.quality >= 5)
		{
			goldRoot.SetActive(value: true);
		}
		else
		{
			purpleRoot.SetActive(value: true);
		}
		sequence?.OnComplete((AnimationBuilder _) =>
		{
			BtnNext.gameObject.SetActive(value: true);
		}).Play();
	}

	private void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			m_config?.onCloseCallback?.Invoke();
			gameObject.SetActive(value: false);
		}).Play();
	}

	private void Hide()
	{
		PlayCloseAnimation();
	}
}
