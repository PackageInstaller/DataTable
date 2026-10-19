using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class OperateBtnComp : MonoBehaviour
{
	[SerializeField]
	private GameObject hookBtnPrefab;

	private HookBtn _hookBtn;

	private Dictionary<EntityId, CharacterOperateBtnUIGroup> _groups;

	public void Init()
	{
		CreateHookBtn();
		AddEventListener();
		_groups = DictionaryPool<EntityId, CharacterOperateBtnUIGroup>.Get();
		CreateOrUpdateOperateBtnGroup();
	}

	public void UnInit()
	{
		RemoveEventListener();
		DestroyAllGroup();
		if (_hookBtn != null)
		{
			Object.Destroy(_hookBtn.gameObject);
			_hookBtn = null;
		}
		DictionaryPool<EntityId, CharacterOperateBtnUIGroup>.Release(_groups);
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_CurTeamOperateBtnGroupDataChanged, OnBattleTeamOperateBtnDataChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateOperateBtnScheme);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OperateBtn_UpdateBtnActive, OnUpdateOperateBtnActive);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OperateBtn_UpdateBtnEffectActive, OnUpdateOperateBtnEffectActive);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OperateBtn_PromptBtn, OnPromptOperateBtn);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OperateBtn_SetConfigDisable, OnSetOperateBtnConfigDisable);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnRuntimeBattleTeamMainCharacterChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ClawStateChange, OnClawStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ClawUnlock, OnClawUnlock);
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_CurTeamOperateBtnGroupDataChanged, OnBattleTeamOperateBtnDataChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateCustomUIScheme, OnUpdateOperateBtnScheme);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OperateBtn_UpdateBtnActive, OnUpdateOperateBtnActive);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OperateBtn_UpdateBtnEffectActive, OnUpdateOperateBtnEffectActive);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OperateBtn_PromptBtn, OnPromptOperateBtn);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OperateBtn_SetConfigDisable, OnSetOperateBtnConfigDisable);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnRuntimeBattleTeamMainCharacterChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ClawStateChange, OnClawStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ClawUnlock, OnClawUnlock);
	}

	private void OnBattleTeamOperateBtnDataChanged(BaseEventContent eventContent)
	{
		CreateOrUpdateOperateBtnGroup();
	}

	public void CreateOrUpdateOperateBtnGroup()
	{
		Dictionary<EntityId, CharacterOperateBtnGroupData> curTeamCharacterOperateBtnGroupData = Model<CustomUIModel>.Interface.CurTeamCharacterOperateBtnGroupData;
		List<EntityId> list = ListPool<EntityId>.Get();
		List<EntityId> list2 = ListPool<EntityId>.Get();
		foreach (EntityId key in _groups.Keys)
		{
			if (!curTeamCharacterOperateBtnGroupData.ContainsKey(key))
			{
				list.Add(key);
			}
		}
		foreach (EntityId key2 in curTeamCharacterOperateBtnGroupData.Keys)
		{
			if (!_groups.ContainsKey(key2))
			{
				list2.Add(key2);
			}
		}
		if (list2.Count != 0 || list.Count != 0)
		{
			foreach (EntityId item in list)
			{
				DestroyGroup(item);
			}
			foreach (EntityId item2 in list2)
			{
				Entity entity = GameManager.entities.GetEntity(item2);
				if (entity != null)
				{
					CreateGroup(curTeamCharacterOperateBtnGroupData[item2], entity);
				}
			}
		}
		UpdateBattleCharacterOperateBtnActive();
		ListPool<EntityId>.Release(list);
		ListPool<EntityId>.Release(list2);
	}

	private void OnUpdateOperateBtnScheme(BaseEventContent eventContent)
	{
		if (!(eventContent is UpdateCustomUISchemeEvt updateCustomUISchemeEvt))
		{
			return;
		}
		foreach (KeyValuePair<EntityId, CharacterOperateBtnUIGroup> group in _groups)
		{
			group.Deconstruct(out var _, out var value);
			value.OnUpdateScheme(updateCustomUISchemeEvt.scheme);
		}
		_hookBtn?.OnUpdateScheme(updateCustomUISchemeEvt.scheme.HookBtnTransform);
	}

	private void OnUpdateOperateBtnActive(BaseEventContent eventContent)
	{
		if (!(eventContent is UpdateOperateBtnActiveEvt updateOperateBtnActiveEvt))
		{
			return;
		}
		foreach (KeyValuePair<EntityId, CharacterOperateBtnUIGroup> group in _groups)
		{
			group.Deconstruct(out var _, out var value);
			value.OnUpdateBtnActive(updateOperateBtnActiveEvt.customUICompType, updateOperateBtnActiveEvt.active);
		}
	}

	private void OnUpdateOperateBtnEffectActive(BaseEventContent eventContent)
	{
		if (!(eventContent is UpdateOperateBtnActiveEvt updateOperateBtnActiveEvt))
		{
			return;
		}
		if (updateOperateBtnActiveEvt.customUICompType == CustomUICompType.HookBtn)
		{
			_hookBtn?.SetGuideEffectActive(updateOperateBtnActiveEvt.active);
			return;
		}
		foreach (KeyValuePair<EntityId, CharacterOperateBtnUIGroup> group in _groups)
		{
			group.Deconstruct(out var _, out var value);
			value.OnUpdateBtnEffectActive(updateOperateBtnActiveEvt.customUICompType, updateOperateBtnActiveEvt.active);
		}
	}

	private void OnPromptOperateBtn(BaseEventContent eventContent)
	{
		if (!(eventContent is PromptOperateBtnEvt promptOperateBtnEvt))
		{
			return;
		}
		foreach (var (entityId2, characterOperateBtnUIGroup2) in _groups)
		{
			if (entityId2 == promptOperateBtnEvt.entityId)
			{
				characterOperateBtnUIGroup2.OnPromptBtn(promptOperateBtnEvt.customUICompType);
			}
		}
	}

	private void OnSetOperateBtnConfigDisable(BaseEventContent eventContent)
	{
		if (eventContent is SetOperateBtnConfigDisableEvt setOperateBtnConfigDisableEvt && _groups.TryGetValue(setOperateBtnConfigDisableEvt.entityId, out var value))
		{
			value.SetConfigDisableState(setOperateBtnConfigDisableEvt.customUICompType, setOperateBtnConfigDisableEvt.enterDisableState);
		}
	}

	private void OnBattleCharacterChange(BaseEventContent eventContent)
	{
		if (eventContent is BattleCharacterChangeEvt battleCharacterChangeEvt)
		{
			UpdateBattleCharacterOperateBtnActive(battleCharacterChangeEvt.newEb);
		}
	}

	private void OnRuntimeBattleTeamMainCharacterChanged(BaseEventContent eventContent)
	{
		if (eventContent is RuntimeBattleTeamMainCharacterChanged runtimeBattleTeamMainCharacterChanged)
		{
			Entity entity = GameManager.entities.GetEntity(runtimeBattleTeamMainCharacterChanged.ecsId);
			UpdateBattleCharacterOperateBtnActive(entity);
		}
	}

	private void UpdateBattleCharacterOperateBtnActive(Entity currentEntity = default(Entity))
	{
		if (!currentEntity.IsValid)
		{
			currentEntity = MonoECS.instance.mainEntity;
		}
		if (!currentEntity.IsValid || currentEntity.GetCompCharacter() == null)
		{
			HideAllGroups();
			return;
		}
		ShowGroup(currentEntity.Id);
		GetGroup(currentEntity.Id)?.RefreshDisPlayOnCharacterChange(currentEntity);
	}

	public void CreateGroup(CharacterOperateBtnGroupData characterOperateBtnGroupData, Entity entity)
	{
		if (characterOperateBtnGroupData == null)
		{
			return;
		}
		CharacterOperateBtnConfig characterOperateBtnConfig = Model<CustomUIModel>.Interface.GetCharacterOperateBtnConfig(entity);
		if (characterOperateBtnConfig == null || _groups == null || _groups.ContainsKey(entity.Id))
		{
			return;
		}
		int num = entity.GetCompCharacter()?.characterSource.Id() ?? 0;
		if (num == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色Entity:{entity.Id}沒有compCharacter");
			}
		}
		else
		{
			CharacterOperateBtnUIGroup characterOperateBtnUIGroup = new GameObject($"Role_{num}_OperateBtnGroup").AddComponent<CharacterOperateBtnUIGroup>();
			characterOperateBtnUIGroup.Init(characterOperateBtnGroupData, characterOperateBtnConfig, transform, entity);
			_groups.Add(entity.Id, characterOperateBtnUIGroup);
		}
	}

	public void ShowGroup(EntityId ebId)
	{
		foreach (var (entityId2, characterOperateBtnUIGroup2) in _groups)
		{
			if (entityId2.Equals(ebId))
			{
				characterOperateBtnUIGroup2.Show();
			}
			else
			{
				characterOperateBtnUIGroup2.Hide();
			}
		}
	}

	private void HideAllGroups()
	{
		foreach (KeyValuePair<EntityId, CharacterOperateBtnUIGroup> group in _groups)
		{
			group.Deconstruct(out var _, out var value);
			value.Hide();
		}
	}

	public void DestroyGroup(EntityId ebId)
	{
		if (_groups.TryGetValue(ebId, out var value))
		{
			value.UnInit();
			_groups.Remove(ebId);
		}
	}

	public void DestroyAllGroup()
	{
		if (_groups == null)
		{
			return;
		}
		foreach (KeyValuePair<EntityId, CharacterOperateBtnUIGroup> group in _groups)
		{
			group.Deconstruct(out var _, out var value);
			value.UnInit();
		}
		_groups.Clear();
	}

	public CharacterOperateBtnUIGroup GetGroup(EntityId entityId)
	{
		return _groups.GetValueOrDefault(entityId);
	}

	private void CreateHookBtn()
	{
		if (!(_hookBtn != null) && !(hookBtnPrefab == null))
		{
			_hookBtn = Object.Instantiate(hookBtnPrefab, transform).GetComponent<HookBtn>();
			_hookBtn.Init(null, Model<CustomUIModel>.Interface.GetCurScheme().HookBtnTransform, null);
			RefreshHookBtnUnlockState();
		}
	}

	private void RefreshHookBtnUnlockState()
	{
		if (!(_hookBtn == null))
		{
			bool clawIsUnlock = ClawManager.ClawIsUnlock;
			_hookBtn.SetActive(clawIsUnlock);
			_hookBtn.ChangeHookBtnSate(isActive: false);
		}
	}

	public OperateBtn GetBattleCharacterOperateBtnUI(CustomUICompType customUICompType)
	{
		if (!_groups.TryGetValue(MonoECS.instance.mainEntity.Id, out var value))
		{
			return null;
		}
		return value.GetBtnByCustomUICompType(customUICompType);
	}

	private void OnClawStateChange(BaseEventContent eventContent)
	{
		if (eventContent is ClawStateEvt clawStateEvt && !(_hookBtn == null))
		{
			if (!ClawManager.ClawIsUnlock)
			{
				_hookBtn.SetActive(active: false);
				return;
			}
			_hookBtn.SetActive(active: true);
			_hookBtn.ChangeHookBtnSate(clawStateEvt.canUse && !Singleton<ProtagonistManager>.instance.IsProtagonist);
		}
	}

	private void OnClawUnlock(BaseEventContent eventContent)
	{
		RefreshHookBtnUnlockState();
	}
}
