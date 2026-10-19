using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class DecorationView : SubUIViewBase<DecorationSubInputController>
{
	public ActButton BtnClose;

	public Transform TfDecorationItem;

	public GameObject DecorationItemPrefab;

	public ActButton BtnEquip;

	public ActButton BtnRemove;

	public GameObject GoActivity;

	public GameObject GoBP;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDescription;

	public List<GameObject> gamepadTips;

	public GamePadTipsComp gamePadTipsComp;

	private CharacterSkinViewData m_data;

	private readonly List<DecorationItem> _items = new List<DecorationItem>();

	private DecorationItem _lastSelectItem;

	private Character _character;

	protected override void OnInit(object param)
	{
		m_data = param as CharacterSkinViewData;
		if (CharacterDataHelper.TryGetBagCharacterById(m_data.RoleId, out var character))
		{
			_character = character;
		}
		BtnClose.SetBtnClick(Close);
		BtnEquip.SetBtnClick(OnEquip);
		BtnRemove.SetBtnClick(OnRemove);
		RegisterEvents();
		InitPanel();
	}

	public void Close()
	{
		if (!(ParentUIView is CharacterSkinView characterSkinView) || !characterSkinView.TryRestoreHideUI())
		{
			UnInit();
			onClose?.Invoke();
		}
	}

	private void RegisterEvents()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AddEffectDress, OnAddEffectDress);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
	}

	private void UnregisterEvents()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AddEffectDress, OnAddEffectDress);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
	}

	private void OnAddEffectDress(BaseEventContent obj)
	{
		if (_lastSelectItem != null)
		{
			RefreshPanel(_lastSelectItem.DressData);
		}
	}

	private void OnSwitchEffectDress(BaseEventContent obj)
	{
		RefreshDecorationItems();
		if (_lastSelectItem != null)
		{
			RefreshPanel(_lastSelectItem.DressData);
		}
	}

	private void InitPanel()
	{
		CreateDecorationItem();
	}

	private void CreateDecorationItem()
	{
		_items.Clear();
		_lastSelectItem = null;
		if (TfDecorationItem.childCount > 0)
		{
			TfDecorationItem.DestroyChildren();
		}
		List<EffectDress> characterEffectDress = GetCharacterEffectDress();
		for (int i = 0; i < characterEffectDress.Count; i++)
		{
			DecorationItem item = UIUtility.AddWidget<DecorationItem>(TfDecorationItem, DecorationItemPrefab);
			item.Init(characterEffectDress[i]);
			item.SetState(_character);
			_items.Add(item);
			item.BtnClick.SetBtnClick(() =>
			{
				OnItemClick(item);
			});
		}
		if (_items.Count > 0)
		{
			OnItemClick(_items[0]);
		}
	}

	private void OnItemClick(DecorationItem item, bool previewModel = true)
	{
		if (!(item == null))
		{
			if (previewModel)
			{
				CharacterSkinViewScene.Default?.PreviewEffectDress(item.DressData.id);
			}
			if (!(_lastSelectItem != null) || _lastSelectItem.DressData.id != item.DressData.id)
			{
				_lastSelectItem?.SetSelect(isSelect: false);
				item.SetSelect(isSelect: true);
				RefreshPanel(item.DressData);
				_lastSelectItem = item;
			}
		}
	}

	private void RefreshPanel(EffectDress data)
	{
		if (data != null)
		{
			TextName.StringReference.TableEntryReference = data.dressName;
			TextDescription.StringReference.TableEntryReference = data.dressDetail;
			bool flag = Model<SkinModel>.Interface.CheckEffectDressIsHave(data.id);
			bool flag2 = _character != null && _character.EffectDressId == data.id;
			bool active = data.skinType == 2 && !flag;
			bool active2 = data.skinType == 4 && !flag2 && !flag;
			BtnEquip.gameObject.SetActive(flag && !flag2);
			BtnRemove.gameObject.SetActive(flag2);
			GoActivity.SetActive(active);
			GoBP.SetActive(active2);
			if (!flag && _character != null)
			{
				Model<SkinModel>.Interface.DecorationClickSkinEvent(_character.Id, data.id, SkinModel.SkinClickStatus.Preview);
			}
		}
	}

	private void OnEquip()
	{
		if (!(_lastSelectItem == null))
		{
			Model<SkinModel>.Interface.SendChangeEffectDress(m_data.RoleId, _lastSelectItem.DressData.id, wear: true);
		}
	}

	private void OnRemove()
	{
		if (!(_lastSelectItem == null))
		{
			Model<SkinModel>.Interface.SendChangeEffectDress(m_data.RoleId, _lastSelectItem.DressData.id, wear: false);
		}
	}

	private void RefreshDecorationItems()
	{
		if (CharacterDataHelper.TryGetBagCharacterById(m_data.RoleId, out var character))
		{
			_character = character;
		}
		for (int i = 0; i < _items.Count; i++)
		{
			_items[i].SetState(_character);
		}
	}

	public void SelectSkinByOffset(int offset)
	{
		if (_items.Count != 0)
		{
			int num = ((_lastSelectItem != null) ? _items.IndexOf(_lastSelectItem) : (-1));
			int num2 = Mathf.Clamp(num + offset, 0, _items.Count - 1);
			if (num2 >= 0 && num2 != num)
			{
				OnItemClick(_items[num2]);
			}
		}
	}

	private List<EffectDress> GetCharacterEffectDress()
	{
		List<EffectDress> list = new List<EffectDress>();
		foreach (KeyValuePair<int, EffectDress> item in RuntimeConfigs.data.effectDresss)
		{
			if (item.Value.roleid == m_data.RoleId)
			{
				list.Add(item.Value);
			}
		}
		return list;
	}

	protected override void OnUnInit()
	{
		CharacterSkinViewScene.Default?.ClearEffectDressPreview();
		UnregisterEvents();
		_items.Clear();
		_lastSelectItem = null;
	}

	public void OnGamepadConfirm()
	{
		if (BtnEquip.gameObject.activeSelf)
		{
			BtnEquip.OnSubmit(null);
		}
		else if (BtnRemove.gameObject.activeSelf)
		{
			BtnRemove.OnSubmit(null);
		}
	}
}
