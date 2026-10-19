using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.EquipSuit;
using ACT.Model.Jump;
using ACT.UI.DataProxy;
using ACT.UI.ItemDetail.Controller;
using ACT.UI.ItemDetail.Interface;
using ACT.UI.ItemDetail.Styles;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.Chronos;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ItemDetail;

public class CommonItemDetail : SubUIView<ItemDetailSubUIInputController>
{
	private readonly struct ResolvedItemDetailContext(ItemUnifierProxy proxy, bool owned)
	{
		public readonly ItemUnifierProxy Proxy = proxy;

		public readonly bool Owned = owned;
	}

	[SerializeField]
	[Space(10f)]
	public CommonStyle _commonStyle;

	[SerializeField]
	[Space(10f)]
	public ItemStyle _itemStyle;

	[SerializeField]
	[Space(10f)]
	public EquipStyle _equipStyle;

	[SerializeField]
	[Space(10f)]
	public GemStyle _gemStyle;

	[SerializeField]
	[Space(10f)]
	public BloodBottleStyle _bloodBottleStyle;

	[SerializeField]
	[Space(10f)]
	public BloodBottleMaterialStyle _bloodBottleMaterialStyle;

	[SerializeField]
	[Space(10f)]
	public EquipSuitStyle _equipSuitStyle;

	[SerializeField]
	[Space(10f)]
	public GiftPackageStyle _giftPackageStyle;

	[SerializeField]
	[Space(10f)]
	private ItemDetailMode m_Mode;

	public ViewControlRoot viewControlRoot;

	private ItemDetailGamePadInputState _inputState;

	public BetterAnimation betterAnimation;

	private ItemUnifierProxy _itemUnifier;

	private bool _autoRelease;

	private Equip[] _equipSuitEquipTemplateCache;

	private List<RuntimeJumpData> _navigations = ListPool<RuntimeJumpData>.Get();

	private StringBuilder m_StringBuilder;

	private Delayer m_LimitTime;

	public ItemDetailMode Mode
	{
		get
		{
			return m_Mode;
		}
		set
		{
			m_Mode = value;
		}
	}

	public ItemDetailGamePadInputState InputState
	{
		get
		{
			return _inputState;
		}
		set
		{
			if (_inputState != value)
			{
				_inputState = value;
				UpdateGamepadStyle();
				OnInputStateChanged?.Invoke();
			}
		}
	}

	public ItemUnifierProxy ItemUnifierProxy => _itemUnifier;

	public override object Context
	{
		get
		{
			return _itemUnifier;
		}
		set
		{
			if (value == _itemUnifier)
			{
				return;
			}
			if (_itemUnifier != null)
			{
				ItemUnifierProxy itemUnifier = _itemUnifier;
				itemUnifier.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Remove(itemUnifier.OnValueChanged, new Action<ItemUnifierProxy>(UpdateContent));
			}
			ResolvedItemDetailContext resolvedItemDetailContext = ResolveContextProxy(value);
			_itemUnifier = resolvedItemDetailContext.Proxy;
			_autoRelease = resolvedItemDetailContext.Owned;
			if (_itemUnifier != null)
			{
				ItemUnifierProxy itemUnifier2 = _itemUnifier;
				itemUnifier2.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Combine(itemUnifier2.OnValueChanged, new Action<ItemUnifierProxy>(UpdateContent));
			}
			try
			{
				betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder x) =>
				{
				}).Play();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
			UpdateContent();
		}
	}

	public Action<IStyle> TopStylePostProcess { get; set; }

	public Action<IStyle> MiddleStylePostProcess { get; set; }

	public Action<IStyle> BottomStylePostProcess { get; set; }

	public Action OnContentChanged { get; set; }

	public Action OnInputStateChanged { get; set; }

	public Action OnJumpSuccess { get; set; }

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		InputState = ItemDetailGamePadInputState.Item_NoFocus;
	}

	private ResolvedItemDetailContext ResolveContextProxy(object value)
	{
		if (value is ItemUnifierProxy itemUnifierProxy)
		{
			if (m_Mode == ItemDetailMode.Native)
			{
				return new ResolvedItemDetailContext(itemUnifierProxy, owned: false);
			}
			if (itemUnifierProxy.Source is Item && TryCreateTypedProxy(itemUnifierProxy.Source, itemUnifierProxy.Count, out var proxy))
			{
				proxy.RewardTag = itemUnifierProxy.RewardTag;
				return new ResolvedItemDetailContext(proxy, owned: true);
			}
			return new ResolvedItemDetailContext(itemUnifierProxy, owned: false);
		}
		if (value is IBagItem bagItem)
		{
			if (m_Mode == ItemDetailMode.Auto && bagItem is Item && TryCreateTypedProxy(bagItem, 0L, out var proxy2))
			{
				return new ResolvedItemDetailContext(proxy2, owned: true);
			}
			return new ResolvedItemDetailContext(ItemUnifierProxy.ItemUnifierPool.Get(bagItem), owned: true);
		}
		throw new NotImplementedException("ItemDetail不支持的类型");
	}

	private bool TryCreateTypedProxy(IBagItem source, long count, out ItemUnifierProxy proxy)
	{
		proxy = null;
		if (source == null)
		{
			return false;
		}
		ItemData data = CoreUtils.GetData(source.GetId(), RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		LuminItemType type = (LuminItemType)data.type;
		if (type != LuminItemType.Equip && type != LuminItemType.Gem && type != LuminItemType.LittleItem && type != LuminItemType.Additive)
		{
			return false;
		}
		switch (type)
		{
		case LuminItemType.Equip:
			return false;
		case LuminItemType.Gem:
			proxy = ItemUnifierProxy.ItemUnifierPool.Get<Gem>(source.GetId(), count);
			return true;
		case LuminItemType.LittleItem:
			proxy = ItemUnifierProxy.ItemUnifierPool.Get<BloodBottleData>(source.GetId(), count);
			return proxy != null;
		case LuminItemType.Additive:
			proxy = ItemUnifierProxy.ItemUnifierPool.Get<BloodBottleMaterial>(source.GetId(), count);
			return proxy != null;
		default:
			return false;
		}
	}

	private static bool ShouldShowNumberPart(int itemType)
	{
		return CoreUtils.GetData(itemType, RuntimeConfigs.data.itemTypes)?.IsShowCount ?? false;
	}

	private void UpdateContent(ItemUnifierProxy itemUnifierProxy)
	{
		UpdateContent();
	}

	public void UpdateContent()
	{
		try
		{
			_commonStyle?.Reset();
			_equipStyle?.Reset();
			_gemStyle?.Reset();
			_itemStyle?.Reset();
			_bloodBottleStyle?.Reset();
			_bloodBottleMaterialStyle?.Reset();
			_equipSuitStyle?.Reset();
			_giftPackageStyle?.Reset();
			if (m_StringBuilder == null)
			{
				m_StringBuilder = new StringBuilder();
			}
			UpdateQualityBackGround();
			BindJumpSuccessCallback();
			UpdateTopPart();
			UpdateMiddle();
			UpdateBottom();
			UpdateGamepadStyle();
			GetController()?.RefreshController();
			OnContentChanged?.Invoke();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	private void BindJumpSuccessCallback()
	{
		_itemStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_equipStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_gemStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_bloodBottleStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_bloodBottleMaterialStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_equipSuitStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
		_giftPackageStyle.OnJumpSuccess = OnItemSourceJumpSuccess;
	}

	private void OnItemSourceJumpSuccess()
	{
		OnJumpSuccess?.Invoke();
	}

	private void UpdateQualityBackGround()
	{
		for (int i = 0; i < _commonStyle.qualityStyles.Length; i++)
		{
			_commonStyle.qualityStyles[i].SetActive(i == _itemUnifier.Quality - 1);
			_commonStyle.qualityStylesPart[i].SetActive(i == _itemUnifier.Quality - 1);
		}
		for (int j = 0; j < _commonStyle.levelStyles.Length; j++)
		{
			_commonStyle.levelStyles[j].SetActive(j == _itemUnifier.Quality - 1);
		}
	}

	private void UpdateTopPart()
	{
		if ((bool)_itemStyle.topPartRoot)
		{
			_itemStyle.topPartRoot.SetActive(_itemUnifier.Source is Item || _itemUnifier.Source is GiftPackage);
		}
		if ((bool)_equipStyle.topPartRoot)
		{
			_equipStyle.topPartRoot.SetActive(_itemUnifier.Source is Equip);
		}
		if ((bool)_gemStyle.topPartRoot)
		{
			_gemStyle.topPartRoot.SetActive(_itemUnifier.Source is Gem);
		}
		if ((bool)_bloodBottleStyle.topPartRoot)
		{
			_bloodBottleStyle.topPartRoot.SetActive(_itemUnifier.Source is BloodBottleData);
		}
		if ((bool)_bloodBottleMaterialStyle.topPartRoot)
		{
			_bloodBottleMaterialStyle.topPartRoot.SetActive(_itemUnifier.Source is BloodBottleMaterial);
		}
		if ((bool)_equipSuitStyle.topPartRoot)
		{
			_equipSuitStyle.topPartRoot.SetActive(_itemUnifier.Source is EquipSuit);
		}
		_commonStyle.name.SetTable("shortcommon");
		_commonStyle.name.StringReference.TableEntryReference = _itemUnifier.Name;
		ItemData data = CoreUtils.GetData(_itemUnifier.Id, RuntimeConfigs.data.itemDatas);
		if (data.type == 12)
		{
			Station.LoadImageAsync(241, data.iconAddress, _commonStyle.itemIcon).Forget();
		}
		else
		{
			Station.LoadItemIconAsync(data.iconAddress, _commonStyle.itemIcon).Forget();
		}
		IBagItem source = _itemUnifier.Source;
		if (!(source is GiftPackage) && !(source is Item))
		{
			if (!(source is Equip equip))
			{
				if (!(source is Gem))
				{
					if (!(source is Character))
					{
						if (!(source is BloodBottleData bloodBottleData))
						{
							if (!(source is BloodBottleMaterial bloodBottleMaterial))
							{
								if (source is EquipSuit)
								{
									_commonStyle.typeIconRoot.SetActive(value: false);
									_commonStyle.lockBtn.gameObject.SetActive(value: false);
									_commonStyle.typeText.SetTable("shortcommon");
									_commonStyle.typeText.StringReference.TableEntryReference = data.typeLocal;
								}
							}
							else
							{
								_commonStyle.typeIconRoot.SetActive(value: true);
								Station.LoadImageAsync(157, bloodBottleMaterial.type, _commonStyle.typeIcon).Forget();
								_commonStyle.typeText.SetTable("longcommon");
								PotionType data2 = CoreUtils.GetData(bloodBottleMaterial.type, RuntimeConfigs.data.potionTypes);
								_commonStyle.typeText.StringReference.TableEntryReference = data2.tpyeName;
								TopStylePostProcess?.Invoke(_bloodBottleMaterialStyle);
							}
						}
						else
						{
							_commonStyle.typeIconRoot.SetActive(value: false);
							_commonStyle.typeText.SetTable("Common");
							_commonStyle.typeText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.RecoverItem;
							_commonStyle.levelRoot.SetActive(value: true);
							_commonStyle.lvNumberComponent.UpdateNumber(bloodBottleData.curLevel, bloodBottleData.maxLevel);
							_bloodBottleStyle.useCountRoot.SetActive(value: true);
							m_StringBuilder.Clear();
							_bloodBottleStyle.useCountNumber.SetText(m_StringBuilder.Append(bloodBottleData.maxUseCount - bloodBottleData.alreadyUseCount).Append("/").Append(bloodBottleData.maxUseCount));
							_bloodBottleStyle.slotList.SoltInit(bloodBottleData, Station);
							TopStylePostProcess?.Invoke(_bloodBottleStyle);
						}
					}
				}
				else
				{
					_commonStyle.typeText.SetTable("Common");
					_commonStyle.typeText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Gem;
					_commonStyle.typeIconRoot.SetActive(value: false);
					TopStylePostProcess?.Invoke(_gemStyle);
				}
			}
			else
			{
				_commonStyle.typeIconRoot.SetActive(value: true);
				_commonStyle.lockBtn.gameObject.SetActive(value: true);
				_commonStyle.lockBtn.Init(equip);
				_commonStyle.levelRoot.SetActive(value: true);
				_commonStyle.lvNumberComponent.UpdateNumber(equip.Level, RuntimeConfigs.data.game.equipRareLevel[equip.GetQuality() - 1]);
				_commonStyle.typeText.SetTable("Common");
				LocalizedString stringReference = _commonStyle.typeText.StringReference;
				stringReference.TableEntryReference = equip.TypeIndex switch
				{
					1 => LocalizationCommonData.CommonString.Power, 
					2 => LocalizationCommonData.CommonString.Move, 
					3 => LocalizationCommonData.CommonString.Can, 
					4 => LocalizationCommonData.CommonString.Assist, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				Station.LoadImageAsync(135, equip.TypeIndex, _commonStyle.typeIcon).Forget();
				_equipStyle.gemHoles.Init(_itemUnifier.As<Equip>());
				TopStylePostProcess?.Invoke(_equipStyle);
			}
		}
		else
		{
			bool flag = ShouldShowNumberPart(data.type);
			_commonStyle.numberRoot.SetActive(flag);
			if (flag)
			{
				_commonStyle.numberComponent.gameObject.SetActive(value: true);
				_commonStyle.numberComponent.totalText.gameObject.SetActive(value: false);
				_commonStyle.numberComponent.slashText.gameObject.SetActive(value: false);
				_commonStyle.numberComponent.numberText.gameObject.SetActive(value: true);
				_commonStyle.numberComponent.UpdateNumber(G.localPlayer.Inventory.GetItemCount(_itemUnifier.Id));
			}
			_commonStyle.typeIconRoot.SetActive(value: false);
			_commonStyle.typeText.SetTable("shortcommon");
			_commonStyle.typeText.StringReference.TableEntryReference = data.typeLocal;
			IBagItem source2 = _itemUnifier.Source;
			Item source3 = source2 as Item;
			if (source3 != null && source3.IsLimitTimeItem())
			{
				bool flag2 = source3.IsDisuse();
				_commonStyle.disuseRoot.SetActive(flag2);
				_commonStyle.limitTimeRoot.SetActive(!flag2);
				if (m_LimitTime.IsValid())
				{
					m_LimitTime.Cancel();
				}
				if (!flag2)
				{
					System.DateTime localDateTime = DateTimeOffset.FromUnixTimeMilliseconds(source3.GetExpireTime()).LocalDateTime;
					_commonStyle.limitTimeDes.SetTable("Common");
					_commonStyle.limitTimeDes.StringReference.TableEntryReference = 2682L;
					_commonStyle.limitTimeDes.GetVariable<string>("0").Value = localDateTime.Year.ToString();
					_commonStyle.limitTimeDes.GetVariable<string>("1").Value = localDateTime.Month.ToString();
					_commonStyle.limitTimeDes.GetVariable<string>("2").Value = localDateTime.Day.ToString();
					_commonStyle.limitTimeDes.GetVariable<string>("3").Value = $"{localDateTime.Hour:D2}:{localDateTime.Minute:D2}";
					long num = source3.GetExpireTime() - TimeManager.ServerTime.NowTimestamp;
					num = (int)((num > int.MaxValue) ? int.MaxValue : num);
					m_LimitTime = UpdateTimer.Default.DelayMs((int)num, () =>
					{
						_commonStyle.disuseRoot.SetActive(source3.IsDisuse());
						_commonStyle.limitTimeRoot.SetActive(!source3.IsDisuse());
						if (source3.IsDisuse() && m_LimitTime.IsValid())
						{
							m_LimitTime.Cancel();
						}
					});
				}
			}
			TopStylePostProcess?.Invoke(_itemStyle);
		}
		TopStylePostProcess?.Invoke(_commonStyle);
	}

	private void UpdateMiddle()
	{
		if ((bool)_itemStyle.middlePartRoot)
		{
			_itemStyle.middlePartRoot.SetActive(_itemUnifier.Source is Item);
		}
		if ((bool)_equipStyle.middlePartRoot)
		{
			_equipStyle.middlePartRoot.SetActive(_itemUnifier.Source is Equip);
		}
		if ((bool)_gemStyle.middlePartRoot)
		{
			_gemStyle.middlePartRoot.SetActive(_itemUnifier.Source is Gem);
		}
		if ((bool)_bloodBottleStyle.middlePartRoot)
		{
			_bloodBottleStyle.middlePartRoot.SetActive(_itemUnifier.Source is BloodBottleData);
		}
		if ((bool)_bloodBottleMaterialStyle.middlePartRoot)
		{
			_bloodBottleMaterialStyle.middlePartRoot.SetActive(_itemUnifier.Source is BloodBottleMaterial);
		}
		if ((bool)_equipSuitStyle.middlePartRoot)
		{
			_equipSuitStyle.middlePartRoot.SetActive(_itemUnifier.Source is EquipSuit);
		}
		if ((bool)_giftPackageStyle.middlePartRoot)
		{
			_giftPackageStyle.middlePartRoot.SetActive(_itemUnifier.Source is GiftPackage);
		}
		_navigations.Clear();
		IBagItem source = _itemUnifier.Source;
		if (!(source is Item item))
		{
			if (!(source is Equip equip))
			{
				if (!(source is Gem gem))
				{
					if (source is Character)
					{
						return;
					}
					if (!(source is BloodBottleData bloodBottleData))
					{
						if (!(source is BloodBottleMaterial bloodBottleMaterial))
						{
							if (!(source is EquipSuit equipSuit))
							{
								if (source is GiftPackage { giftItemTableData: var giftItemTableData } giftPackage)
								{
									_giftPackageStyle.giftPackageItemDes.SetTable("longcommon");
									_giftPackageStyle.giftPackageItemDes.StringReference.TableEntryReference = giftPackage.GetLocalizationDes();
									_giftPackageStyle.giftPackageItemDes.gameObject.SetActive(value: true);
									SetupObtainWaySources(giftItemTableData, _giftPackageStyle);
									MiddleStylePostProcess?.Invoke(_giftPackageStyle);
									ResetMiddleScrollToTop(_giftPackageStyle.middlePartRoot);
								}
								return;
							}
							ItemData data = CoreUtils.GetData(equipSuit.GetId(), RuntimeConfigs.data.itemDatas);
							_equipSuitStyle.suitDesc.SetTable("longcommon");
							_equipSuitStyle.suitDesc.StringReference.TableEntryReference = data.descLocal;
							int num = equipSuit.EquipSuitData.equipList.Length;
							if (_equipSuitEquipTemplateCache == null || _equipSuitEquipTemplateCache.Length < num)
							{
								Equip[] equipSuitEquipTemplateCache = _equipSuitEquipTemplateCache;
								_equipSuitEquipTemplateCache = new Equip[num];
								if (equipSuitEquipTemplateCache != null)
								{
									for (int i = 0; i < equipSuitEquipTemplateCache.Length; i++)
									{
										_equipSuitEquipTemplateCache[i] = equipSuitEquipTemplateCache[i];
									}
								}
							}
							for (int j = 0; j < num; j++)
							{
								int id = equipSuit.EquipSuitData.equipList[j];
								LocalizeStringEvent obj = _equipSuitStyle.equipNames[j];
								obj.gameObject.SetActive(value: true);
								obj.SetTable("shortcommon");
								obj.StringReference.TableEntryReference = CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas).nameLocal;
								EquipData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.equipDatas);
								ref Equip reference = ref _equipSuitEquipTemplateCache[j];
								Equip obj2 = reference ?? (reference = new Equip());
								obj2.Id = id;
								int level = RuntimeConfigs.data.game.equipRareLevel[data2.quality - 1];
								obj2.Level = level;
								obj2.Refresh();
							}
							_equipSuitStyle.equipBuffDetail.Init(_equipSuitEquipTemplateCache[0], _equipSuitEquipTemplateCache[1], _equipSuitEquipTemplateCache[2], _equipSuitEquipTemplateCache[3]);
							ResetMiddleScrollToTop(_equipSuitStyle.middlePartRoot);
						}
						else
						{
							_bloodBottleMaterialStyle.skillDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetBottleMatDesc(bloodBottleMaterial, isDetailDesc: true));
							ItemData data3 = CoreUtils.GetData(bloodBottleMaterial.id, RuntimeConfigs.data.itemDatas);
							_bloodBottleMaterialStyle.storyDes.SetTable(LocalizeTable.LongCommon);
							_bloodBottleMaterialStyle.storyDes.StringReference.TableEntryReference = data3.descLocal;
							MiddleStylePostProcess?.Invoke(_bloodBottleMaterialStyle);
							ResetMiddleScrollToTop(_bloodBottleMaterialStyle.middlePartRoot);
						}
					}
					else
					{
						_bloodBottleStyle.bloodBottleDes.SetText(Singleton<BloodBottleBuffHandler>.instance.GetSpecifyLevelBottleSkillDes(bloodBottleData, new StringBuilder(), bloodBottleData.curLevel, detailDesc: true));
						for (int k = 0; k < bloodBottleData.wineMaterialSlots.Count; k++)
						{
							_bloodBottleStyle.bottleMatCells[k].gameObject.SetActive(value: true);
							_bloodBottleStyle.bottleMatCells[k].Refresh(bloodBottleData.wineMaterialSlots[k], bloodBottleData.uid, k, Station);
						}
						MiddleStylePostProcess?.Invoke(_bloodBottleStyle);
						ResetMiddleScrollToTop(_bloodBottleStyle.middlePartRoot);
					}
				}
				else
				{
					ItemData data4 = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.itemDatas);
					_gemStyle.gemBuffDetail.Init(gem);
					_gemStyle.gemDescription.SetTable("longcommon");
					_gemStyle.gemDescription.StringReference.TableEntryReference = data4.descLocal;
					SetupObtainWaySources(data4, _gemStyle);
					MiddleStylePostProcess?.Invoke(_gemStyle);
					ResetMiddleScrollToTop(_gemStyle.middlePartRoot);
				}
			}
			else
			{
				SetProperty(_equipStyle.mainPropertyStyle, 0);
				SetProperty(_equipStyle.randomPropertyStyle1, 1);
				SetProperty(_equipStyle.randomPropertyStyle2, 2);
				_equipStyle.equipBuffDetail.Init(equip);
				ItemData data5 = CoreUtils.GetData(equip.Id, RuntimeConfigs.data.itemDatas);
				_equipStyle.equipDescription.SetTable("longcommon");
				_equipStyle.equipDescription.StringReference.TableEntryReference = data5.descLocal;
				SetupObtainWaySources(data5, _equipStyle);
				MiddleStylePostProcess?.Invoke(_equipStyle);
				ResetMiddleScrollToTop(_equipStyle.middlePartRoot);
			}
		}
		else
		{
			ItemData data6 = CoreUtils.GetData(item.Id, RuntimeConfigs.data.itemDatas);
			_itemStyle.itemFunctionDescription.SetTable("longcommon");
			_itemStyle.itemFunctionDescription.StringReference.TableEntryReference = data6.descLocal;
			_itemStyle.itemFunctionDescription.gameObject.SetActive(value: false);
			_itemStyle.itemDescription.SetTable("longcommon");
			_itemStyle.itemDescription.StringReference.TableEntryReference = data6.descLocal;
			_itemStyle.itemDescription.gameObject.SetActive(value: true);
			SetupObtainWaySources(data6, _itemStyle);
			MiddleStylePostProcess?.Invoke(_itemStyle);
			ResetMiddleScrollToTop(_itemStyle.middlePartRoot);
		}
	}

	private void ResetMiddleScrollToTop(GameObject middlePartRoot)
	{
		if (!(middlePartRoot == null))
		{
			ScrollRect componentInChildren = middlePartRoot.GetComponentInChildren<ScrollRect>(includeInactive: true);
			if (!(componentInChildren == null))
			{
				componentInChildren.StopMovement();
				Canvas.ForceUpdateCanvases();
				componentInChildren.verticalNormalizedPosition = 1f;
			}
		}
	}

	private void SetupObtainWaySources(ItemData itemData, UniqStyleBase style)
	{
		_navigations.Clear();
		if (itemData != null && !(style.obtainWayTipRoot == null))
		{
			int jumpType = itemData.jumpType;
			int num;
			switch (jumpType)
			{
			case -1:
				style.obtainWayTipRoot.SetActive(value: false);
				return;
			default:
				num = ((jumpType == 2) ? 1 : 0);
				break;
			case 1:
				num = 1;
				break;
			}
			bool flag = jumpType != 1;
			bool flag2 = false;
			List<RuntimeJumpData> list = ListPool<RuntimeJumpData>.Get();
			if (num != 0)
			{
				itemData.GetItemNavigation(_navigations);
				flag2 |= AddItemSources(_navigations, style, list, removeDuplicateNavigation: false);
			}
			List<RuntimeJumpData> list2 = ListPool<RuntimeJumpData>.Get();
			if (flag && itemData.ItemHasJumpInfo(list2))
			{
				flag2 |= AddItemSources(list2, style, list, removeDuplicateNavigation: true);
			}
			list2.Clear();
			ListPool<RuntimeJumpData>.Release(list2);
			list.Clear();
			ListPool<RuntimeJumpData>.Release(list);
			if (!flag2)
			{
				style.obtainWayTipRoot.SetActive(value: false);
			}
		}
	}

	private bool AddItemSources(List<RuntimeJumpData> navigations, UniqStyleBase style, List<RuntimeJumpData> addedNavigations, bool removeDuplicateNavigation)
	{
		if (navigations == null || navigations.Count <= 0)
		{
			return false;
		}
		bool result = false;
		bool flag = removeDuplicateNavigation && ContainsModelTypeNavigation(addedNavigations, LuminModelType.BattlePass);
		foreach (RuntimeJumpData navigation in navigations)
		{
			if ((removeDuplicateNavigation && navigation.ModelType == LuminModelType.BattlePass) & flag)
			{
				navigation.Result.Release();
				continue;
			}
			if (removeDuplicateNavigation && navigation.ModelType == LuminModelType.Shops && ContainsSameMainShopNavigation(addedNavigations, navigation))
			{
				navigation.Result.Release();
				continue;
			}
			if (removeDuplicateNavigation && ContainsSameNavigation(addedNavigations, navigation))
			{
				navigation.Result.Release();
				continue;
			}
			style.GetGo().Init(navigation);
			addedNavigations.Add(navigation);
			if (removeDuplicateNavigation && navigation.ModelType == LuminModelType.BattlePass)
			{
				flag = true;
			}
			result = true;
		}
		return result;
	}

	private bool ContainsModelTypeNavigation(List<RuntimeJumpData> navigations, LuminModelType modelType)
	{
		if (navigations == null || navigations.Count <= 0)
		{
			return false;
		}
		foreach (RuntimeJumpData navigation in navigations)
		{
			if (navigation.ModelType == modelType)
			{
				return true;
			}
		}
		return false;
	}

	private bool ContainsSameMainShopNavigation(List<RuntimeJumpData> navigations, RuntimeJumpData navigation)
	{
		if (navigations == null || navigations.Count <= 0)
		{
			return false;
		}
		int jumpMainShopId = GetJumpMainShopId(navigation);
		foreach (RuntimeJumpData navigation2 in navigations)
		{
			if (navigation2.ModelType == LuminModelType.Shops && GetJumpMainShopId(navigation2) == jumpMainShopId)
			{
				return true;
			}
		}
		return false;
	}

	private int GetJumpMainShopId(RuntimeJumpData navigation)
	{
		List<int> list = navigation.Params;
		if (list == null || list.Count <= 1)
		{
			return 0;
		}
		if (navigation.Params.Count > 2)
		{
			return navigation.Params[1];
		}
		int num = navigation.Params[1];
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			ShopData value = shopData.Value;
			if (value != null && ContainsSubShopId(value.subshopIds, num))
			{
				return value.id;
			}
		}
		return num;
	}

	private bool ContainsSubShopId(int[] subShopIds, int subShopId)
	{
		if (subShopIds == null)
		{
			return false;
		}
		for (int i = 0; i < subShopIds.Length; i++)
		{
			if (subShopIds[i] == subShopId)
			{
				return true;
			}
		}
		return false;
	}

	private bool ContainsSameNavigation(List<RuntimeJumpData> navigations, RuntimeJumpData navigation)
	{
		if (navigations == null || navigations.Count <= 0)
		{
			return false;
		}
		foreach (RuntimeJumpData navigation2 in navigations)
		{
			if (navigation2.ModelType == navigation.ModelType && navigation2.JumpType == navigation.JumpType && NavigationParamsEquals(navigation2, navigation))
			{
				return true;
			}
		}
		return false;
	}

	private bool NavigationParamsEquals(RuntimeJumpData left, RuntimeJumpData right)
	{
		if (left.Params == null || right.Params == null)
		{
			if (left.Params == null && right.Params == null && left.NavigationID != 0)
			{
				return left.NavigationID == right.NavigationID;
			}
			return false;
		}
		if (left.Params.Count != right.Params.Count)
		{
			return false;
		}
		for (int i = 0; i < left.Params.Count; i++)
		{
			if (left.Params[i] != right.Params[i])
			{
				return false;
			}
		}
		return true;
	}

	private void UpdateBottom()
	{
		if ((bool)_itemStyle.bottomPartRoot)
		{
			_itemStyle.bottomPartRoot.SetActive(_itemUnifier.Source is Item);
		}
		if ((bool)_equipStyle.bottomPartRoot)
		{
			_equipStyle.bottomPartRoot.SetActive(_itemUnifier.Source is Equip);
		}
		if ((bool)_gemStyle.bottomPartRoot)
		{
			_gemStyle.bottomPartRoot.SetActive(_itemUnifier.Source is Gem);
		}
		if ((bool)_bloodBottleStyle.bottomPartRoot)
		{
			_bloodBottleStyle.bottomPartRoot.SetActive(_itemUnifier.Source is BloodBottleData);
		}
		if ((bool)_bloodBottleMaterialStyle.bottomPartRoot)
		{
			_bloodBottleMaterialStyle.bottomPartRoot.SetActive(_itemUnifier.Source is BloodBottleMaterial);
		}
		if ((bool)_equipSuitStyle.bottomPartRoot)
		{
			_equipSuitStyle.bottomPartRoot.SetActive(_itemUnifier.Source is EquipSuit);
		}
		if ((bool)_giftPackageStyle.bottomPartRoot)
		{
			_giftPackageStyle.bottomPartRoot.SetActive(_itemUnifier.Source is GiftPackage);
		}
		IBagItem source = _itemUnifier.Source;
		if (!(source is Item))
		{
			if (!(source is Equip equip))
			{
				if (!(source is Gem gem))
				{
					if (source is Character)
					{
						return;
					}
					if (!(source is BloodBottleData bloodBottleData))
					{
						if (!(source is BloodBottleMaterial bloodBottleMaterial))
						{
							if (!(source is GiftPackage giftPackage))
							{
								return;
							}
							BottomStylePostProcess?.Invoke(_itemStyle);
							if (!giftPackage.GetOpenPrecondition())
							{
								string conditionDes = giftPackage.GetConditionDes();
								_giftPackageStyle.openConditionRoot.SetActive(value: true);
								if (!string.IsNullOrEmpty(conditionDes))
								{
									_giftPackageStyle.openCondition.SetText(conditionDes);
								}
							}
							else
							{
								_giftPackageStyle.openConditionRoot.SetActive(value: false);
							}
						}
						else
						{
							BottomStylePostProcess?.Invoke(_bloodBottleMaterialStyle);
							if (bloodBottleMaterial.isEquip && _bloodBottleMaterialStyle.extraWayActiveBelongBottleRoot)
							{
								_bloodBottleMaterialStyle.belongBottleRoot.SetActive(value: true);
								ItemData data = CoreUtils.GetData(Model<BloodBottleModel>.Interface.GetBloodBottleById(bloodBottleMaterial.belongBottle).id, RuntimeConfigs.data.itemDatas);
								Station.LoadItemIconAsync(data.iconAddress, _bloodBottleMaterialStyle.belongBottleIcon).Forget();
								_bloodBottleMaterialStyle.belongBottleText.SetTable("Common");
								_bloodBottleMaterialStyle.belongBottleText.StringReference.TableEntryReference = 2340L;
								_bloodBottleMaterialStyle.belongBottleText.GetVariable<string>("0").Value = LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal);
							}
							else
							{
								_bloodBottleMaterialStyle.belongBottleRoot.SetActive(value: false);
							}
						}
					}
					else
					{
						if (bloodBottleData.isEquip)
						{
							_bloodBottleStyle.teamEquipRoot.SetActive(value: true);
							_bloodBottleStyle.teamEquipText.SetTable("Common");
							_bloodBottleStyle.teamEquipText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.HasBlended;
						}
						else
						{
							_bloodBottleStyle.teamEquipRoot.SetActive(value: false);
						}
						BottomStylePostProcess?.Invoke(_bloodBottleStyle);
					}
					return;
				}
				Character character = null;
				if (gem.InlayEquip != 0)
				{
					Equip equip2 = G.localPlayer.Inventory.GetEquip(gem.InlayEquip);
					if (equip2 != null && equip2.WearCharacter != 0)
					{
						character = G.localPlayer.GetCharacter(equip2.WearCharacter);
					}
				}
				_gemStyle.characterEquipComponent.Station = Station;
				_gemStyle.characterEquipComponent.Character = character;
				BottomStylePostProcess?.Invoke(_gemStyle);
			}
			else
			{
				_equipStyle.characterEquipComponent.Station = Station;
				_equipStyle.characterEquipComponent.Character = G.localPlayer.GetCharacter(equip.WearCharacter);
				BottomStylePostProcess?.Invoke(_equipStyle);
			}
		}
		else
		{
			BottomStylePostProcess?.Invoke(_itemStyle);
		}
	}

	public void UpdateGamepadStyle()
	{
		if (InputController != null)
		{
			switch (_inputState)
			{
			case ItemDetailGamePadInputState.Item_NoFocus:
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Back", value: true);
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Navigate", value: true);
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Confirm", value: true);
				break;
			case ItemDetailGamePadInputState.Item_FocusJumpPart:
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Back", value: false);
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Navigate", value: false);
				Singleton<GameInputActionManager>.instance.SetActionBlacklist(InputController, "UI/Confirm", value: false);
				break;
			}
		}
	}

	protected override void OnUnityDestroy()
	{
		try
		{
			_commonStyle?.Release();
			_itemStyle?.Release();
			_equipStyle?.Release();
			_gemStyle?.Release();
			_bloodBottleStyle?.Release();
			_bloodBottleMaterialStyle?.Release();
		}
		catch (Exception e)
		{
			LogDestroyException("样式释放", e);
		}
		TopStylePostProcess = null;
		MiddleStylePostProcess = null;
		BottomStylePostProcess = null;
		try
		{
			if (_itemUnifier != null)
			{
				ItemUnifierProxy itemUnifier = _itemUnifier;
				itemUnifier.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Remove(itemUnifier.OnValueChanged, new Action<ItemUnifierProxy>(UpdateContent));
			}
			if (_autoRelease)
			{
				ItemUnifierProxy.ItemUnifierPool.Release(ref _itemUnifier);
			}
			if (_navigations != null)
			{
				ListPool<RuntimeJumpData>.Release(_navigations);
			}
		}
		catch (Exception e2)
		{
			LogDestroyException("池化数据回收", e2);
		}
		try
		{
			if (m_LimitTime.IsValid())
			{
				m_LimitTime.Cancel();
			}
			if (betterAnimation != null)
			{
				betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder x) =>
				{
				}).Play();
			}
		}
		catch (Exception e3)
		{
			LogDestroyException("计时器/动画收尾", e3);
		}
	}

	private void LogDestroyException(string step, Exception e)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[CommonItemDetail] 销毁阶段 {step} 失败，已跳过：{e}");
		}
	}

	private void SetProperty(PropertyStyle style, int propertyIndex)
	{
		EquipAttr equipAttr = _itemUnifier.As<Equip>().Attributes[propertyIndex];
		EquipAttrData data = CoreUtils.GetData(equipAttr.Id, RuntimeConfigs.data.equipAttrDatas);
		if (data != null)
		{
			PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
			if (data2 != null)
			{
				Station.LoadImageAsync(146, data.attrId, style.icon).Forget();
				style.propertyName.SetTable("shortcommon");
				style.propertyName.StringReference.TableEntryReference = data2.descLocal;
				style.number.SetText(equipAttr.Value.FastToString(data2.judge ? 1 : (-1), data2.judge));
			}
		}
	}
}
