using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.UI;

public class AcquireCharacterShowNewComponent : MonoBehaviour
{
	public CardDrawCharacterDisplayElements purpleElements;

	public ActButton BtnNext;

	[SerializeField]
	private BetterAnimation betterAnimation;

	public GameObject purpleRoot;

	public List<GameObject> qualityBgList;

	[SerializeField]
	private List<CharacterOverTagtem> _listTag;

	public ActButton ShareButton;

	public List<GameObject> ShareHide = new List<GameObject>();

	private CardDrawCharacterDisplayElements currentElements;

	private CardDrawCharacterShowConfig m_config;

	private int CurrentIndex;

	private ImageAssetStation m_station;

	private ItemData m_itemData;

	private bool _isPreparingCurrentItem;

	private bool _isSharing;

	private int _showSessionId;

	private CardDrawView _cardDrawView;

	public void InitPanel(CardDrawCharacterShowConfig cardDrawCharacterShowConfig, ImageAssetStation station, CardDrawView cardDrawView)
	{
		_cardDrawView = cardDrawView;
		m_station = station;
		m_config = cardDrawCharacterShowConfig;
		CurrentIndex = 0;
		_isPreparingCurrentItem = false;
		_showSessionId++;
		BtnNext.gameObject.SetActive(value: false);
		SetShareButtonVisible(visible: false);
		BtnNext.SetBtnClick(Next);
		ShareButton?.SetBtnClick(() =>
		{
			Share().Forget();
		});
		StartPrepareCurrentItem();
	}

	private void Next()
	{
		if (!_isPreparingCurrentItem && m_config != null && m_config.showItems != null)
		{
			ReportCharacterDetailClick();
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().StopCharacterTimeline();
			SetShareButtonVisible(visible: false);
			if (CurrentIndex < m_config.showItems.Count - 1)
			{
				BtnNext.gameObject.SetActive(value: false);
				CurrentIndex++;
				StartPrepareCurrentItem();
			}
			else
			{
				Hide();
				m_config.onAllShowComplete?.Invoke();
			}
		}
	}

	private void ReportCharacterDetailClick()
	{
		if (m_config.showItems[CurrentIndex].isCharacter)
		{
			GachaClickEvent evt = EventTrackSolver.Instance.GetEvt<GachaClickEvent>();
			evt.gachaId = m_config.gachaId;
			evt.gachaType = m_config.gachaType;
			evt.type = 3;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	private void StartPrepareCurrentItem()
	{
		int showSessionId = _showSessionId;
		PrepareCurrentItemAsync(showSessionId).Forget();
	}

	private async UniTask PrepareCurrentItemAsync(int sessionId)
	{
		if (_isPreparingCurrentItem || m_config == null || m_config.showItems == null || m_config.showItems.Count == 0 || CurrentIndex < 0 || CurrentIndex >= m_config.showItems.Count)
		{
			return;
		}
		_isPreparingCurrentItem = true;
		BtnNext.gameObject.SetActive(value: false);
		SetShareButtonVisible(visible: false);
		purpleRoot.SetActive(value: false);
		try
		{
			CardDrawCharacterShowData cardDrawCharacterShowData = m_config.showItems[CurrentIndex];
			if (cardDrawCharacterShowData.isCharacter)
			{
				gameObject.SetActive(value: false);
			}
			else
			{
				ShowPanel();
			}
			if (m_config.onBeforeShowItemAsync != null)
			{
				await m_config.onBeforeShowItemAsync(cardDrawCharacterShowData);
			}
			if (sessionId == _showSessionId && (m_config.shouldAbortCurrentShow == null || !m_config.shouldAbortCurrentShow()) && !(this == null) && (bool)gameObject && m_itemData != null)
			{
			}
		}
		finally
		{
			_isPreparingCurrentItem = false;
		}
	}

	public void ShowPanel()
	{
		_isPreparingCurrentItem = false;
		if (m_config == null)
		{
			return;
		}
		CardDrawCharacterShowData cardDrawCharacterShowData = m_config.showItems[CurrentIndex];
		SetShareButtonVisible(visible: false);
		m_itemData = CoreUtils.GetData(cardDrawCharacterShowData.Id, RuntimeConfigs.data.itemDatas);
		if (m_itemData == null)
		{
			return;
		}
		currentElements = purpleElements;
		currentElements.goNew.SetActive(cardDrawCharacterShowData.IsNew);
		currentElements.CharacterRoot.SetActive(cardDrawCharacterShowData.isCharacter);
		currentElements.ItemRoot.SetActive(!cardDrawCharacterShowData.isCharacter);
		if (cardDrawCharacterShowData.isCharacter)
		{
			RefreshCharacterPanel(cardDrawCharacterShowData);
		}
		else
		{
			RefreshNormalItemPanel(cardDrawCharacterShowData);
		}
		RefreshCharacterBg(m_itemData.quality);
		PlayCurrentItemAnimation();
		if (cardDrawCharacterShowData.isCharacter)
		{
			if (m_itemData.quality == 5)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Gold", new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
			else
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Character_Gold", new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Prop", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
	}

	private void ItemQualityInit(int quality)
	{
		if (currentElements.QualityList == null || currentElements.QualityList.Count == 0)
		{
			return;
		}
		int num = ((quality > 3) ? ((quality == 4) ? 1 : 2) : 0);
		for (int i = 0; i < currentElements.QualityList.Count; i++)
		{
			if (currentElements.QualityList[i] != null)
			{
				currentElements.QualityList[i].SetActive(i == num);
			}
		}
	}

	private void CharacterQualityInit(int quality)
	{
		if (currentElements.CharacterQualityList == null || currentElements.CharacterQualityList.Count == 0)
		{
			return;
		}
		int num = ((quality > 3) ? ((quality == 4) ? 1 : 2) : 0);
		for (int i = 0; i < currentElements.CharacterQualityList.Count; i++)
		{
			if (currentElements.CharacterQualityList[i] != null)
			{
				currentElements.CharacterQualityList[i].SetActive(i == num);
			}
		}
	}

	private void RefreshCharacterPanel(CardDrawCharacterShowData item)
	{
		SetCharacterInfoVisible(visible: true);
		_cardDrawView.BtnSkip.gameObject.SetActive(!item.IsNew);
		currentElements.textName.StringReference.TableEntryReference = m_itemData.nameLocal;
		if (m_itemData.canBeTransited == null || m_itemData.canBeTransited.Count == 0)
		{
			SetExtraItems(new List<Item>());
			return;
		}
		int id = m_itemData.canBeTransited[0].id;
		EntityCharacterData data = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterDatas);
		if (data != null)
		{
			currentElements.imageProfession.UpdateDisPlay(id);
			currentElements.MannerItem?.Init(m_station, data.mannerType);
			m_station.LoadImage(160, data.characterNameEng, currentElements.imageName);
			m_station.LoadImage(113, data.characterArt, currentElements.characterImage);
		}
		int[] characterTagGroup = data.characterTagGroup;
		for (int i = 0; i < _listTag.Count; i++)
		{
			_listTag[i].gameObject.SetActive(characterTagGroup.Length > i);
			if (characterTagGroup.Length > i)
			{
				_listTag[i].Init(characterTagGroup[i]);
			}
		}
		CharacterQualityInit(m_itemData.quality);
		SetExtraItems(BuildCharacterExtraItems(item, data));
	}

	private void RefreshNormalItemPanel(CardDrawCharacterShowData item)
	{
		_cardDrawView.BtnSkip.gameObject.SetActive(value: true);
		SetCharacterInfoVisible(visible: false);
		m_station.LoadItemIcon(m_itemData.iconAddress, currentElements.ItemImage);
		currentElements.TextItemName.StringReference.TableEntryReference = m_itemData.nameLocal;
		currentElements.TextItemNum.text = "x" + item.Count;
		ItemQualityInit(m_itemData.quality);
		SetExtraItems(BuildCommonExtraItems(item));
	}

	private void SetCharacterInfoVisible(bool visible)
	{
		if (currentElements.imageName != null)
		{
			currentElements.imageName.icon.gameObject.SetActive(visible);
		}
		if (currentElements.imageProfession != null)
		{
			currentElements.imageProfession.gameObject.SetActive(visible);
		}
		if (currentElements.characterImage != null)
		{
			currentElements.characterImage.rawIcon.gameObject.SetActive(value: false);
		}
		if (currentElements.ItemImage != null)
		{
			currentElements.ItemImage.icon.gameObject.SetActive(!visible);
		}
		if (currentElements.GoBgRoot != null)
		{
			currentElements.GoBgRoot.gameObject.SetActive(!visible);
		}
	}

	private List<Item> BuildCharacterExtraItems(CardDrawCharacterShowData item, EntityCharacterData characterData)
	{
		List<Item> list = new List<Item>();
		if (!item.IsNew && characterData != null)
		{
			int num = 0;
			int num2 = 0;
			if (item.CharacterMaxConstellation)
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
				list.Add(new Item
				{
					Id = num2,
					Count = num
				});
			}
		}
		AppendCommonExtraItems(item, list);
		return list;
	}

	private List<Item> BuildCommonExtraItems(CardDrawCharacterShowData item)
	{
		List<Item> list = new List<Item>();
		AppendCommonExtraItems(item, list);
		return list;
	}

	private void AppendCommonExtraItems(CardDrawCharacterShowData item, List<Item> list)
	{
		if (item.ExtraItem != null)
		{
			for (int i = 0; i < item.ExtraItem.Count; i++)
			{
				list.Add(new Item
				{
					Id = item.ExtraItem[i].Id,
					Count = item.ExtraItem[i].Count
				});
			}
		}
	}

	private void SetExtraItems(List<Item> extraItems)
	{
		for (int i = 0; i < currentElements.extraItems.Count; i++)
		{
			if (i < extraItems.Count)
			{
				currentElements.extraItems[i].Init(extraItems[i], m_station);
			}
			currentElements.extraItems[i].gameObject.SetActive(i < extraItems.Count);
		}
	}

	private void RefreshCharacterBg(int characterDataStars)
	{
		if (qualityBgList == null || qualityBgList.Count == 0)
		{
			return;
		}
		int num = ((characterDataStars > 3) ? ((characterDataStars == 4) ? 1 : 2) : 0);
		for (int i = 0; i < qualityBgList.Count; i++)
		{
			if (qualityBgList[i] != null)
			{
				qualityBgList[i].SetActive(i == num);
			}
		}
	}

	private void PlayCharacterShowSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Prop", new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void PlayCurrentItemAnimation()
	{
		gameObject.SetActive(value: true);
		PlayerBetterAnimation();
	}

	private void PlayerBetterAnimation()
	{
		purpleRoot.SetActive(value: true);
		if (m_config.showItems[CurrentIndex].isCharacter)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				BtnNext.gameObject.SetActive(value: true);
				SetShareButtonVisible(visible: true);
			}).Play();
		}
		else
		{
			BtnNext.gameObject.SetActive(value: true);
			betterAnimation.GetSequence("ItemShow").Play();
		}
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
		SetShareButtonVisible(visible: false);
		PlayCloseAnimation();
	}

	private void SetShareButtonVisible(bool visible)
	{
		if (ShareButton != null && !Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.Share))
		{
			ShareButton.gameObject.SetActive(visible);
		}
	}

	public async UniTask Share()
	{
		if (_isSharing || m_config?.showItems == null || CurrentIndex < 0 || CurrentIndex >= m_config.showItems.Count || !m_config.showItems[CurrentIndex].isCharacter)
		{
			return;
		}
		_isSharing = true;
		Dictionary<GameObject, bool> hiddenStates = new Dictionary<GameObject, bool>();
		ShareScreenshotResult screenshot = null;
		CancellationToken cancellationToken = this.GetCancellationTokenOnDestroy();
		try
		{
			CardDrawCharacterShowData cardDrawCharacterShowData = m_config.showItems[CurrentIndex];
			List<ShareViewViewData.LootItemData> lootItems = new List<ShareViewViewData.LootItemData>
			{
				new ShareViewViewData.LootItemData
				{
					Id = cardDrawCharacterShowData.Id,
					Num = (cardDrawCharacterShowData.isCharacter ? 1 : cardDrawCharacterShowData.Count)
				}
			};
			try
			{
				HideForScreenshot(ShareButton ? ShareButton.gameObject : null, hiddenStates);
				if (ShareHide != null)
				{
					foreach (GameObject item in ShareHide)
					{
						HideForScreenshot(item, hiddenStates);
					}
				}
				screenshot = await ShareScreenshotUtilities.CaptureFullScreenAsync(this);
			}
			finally
			{
				foreach (KeyValuePair<GameObject, bool> item2 in hiddenStates)
				{
					if ((bool)item2.Key)
					{
						item2.Key.SetActive(item2.Value);
					}
				}
			}
			cancellationToken.ThrowIfCancellationRequested();
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SHARE, new ShareViewViewData
			{
				Screenshot = screenshot,
				LootItems = lootItems
			});
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			Debug.LogError($"AcquireCharacterShowNewComponent: failed to prepare share screenshot.\n{arg}");
		}
		finally
		{
			if (screenshot != null && !screenshot.IsOwnedByView)
			{
				screenshot.Dispose();
			}
			_isSharing = false;
		}
	}

	private static void HideForScreenshot(GameObject target, Dictionary<GameObject, bool> hiddenStates)
	{
		if (!(target == null) && !hiddenStates.ContainsKey(target))
		{
			hiddenStates.Add(target, target.activeSelf);
			target.SetActive(value: false);
		}
	}
}
