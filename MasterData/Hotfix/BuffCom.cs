using System;
using System.Collections.Generic;
using Cinemachine;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class BuffCom : LogicMonoComponent
{
	public delegate void BuffUIHandle(int uid, int buffID, int count, FP cd);

	private class BuffHeadSlot
	{
		public Transform slot;

		public int buffID;

		public int buffNum;

		public string buffPath;

		public AdventureMarkFXHandler fxPLayer;

		public bool token => buffID > 0;
	}

	public delegate void ReduceTimeHandle(bool active);

	protected Dictionary<int, int> firstIdBuffs;

	private AdventureActor _owner;

	private const int BUFF_HEAD_SLOTS_COUNT = 3;

	private List<BuffHeadSlot> buffHeadSlots;

	private Transform buffSlotRoot;

	private int tokenIndex;

	private AnimationSlotConfigComponent _syncSlotConfigComponent;

	public Dictionary<int, int> immunityIds;

	private Dictionary<int, int> immunityGroupIds;

	private Dictionary<int, int> immunityTags;

	private int _reduceCountA;

	private int _reduceTimeCount;

	public List<BuffEntity> BuffList { get; private set; }

	public AdventureActor OwnerActor => _owner;

	private bool topoSlotIsValid
	{
		get
		{
			if (buffHeadSlots != null)
			{
				return buffHeadSlots.Count == 3;
			}
			return false;
		}
	}

	private AnimationSlotConfigComponent syncSlotComponent
	{
		get
		{
			return _syncSlotConfigComponent;
		}
		set
		{
			if (_syncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent syncSlotConfigComponent = _syncSlotConfigComponent;
				syncSlotConfigComponent.onSlotGroupChange = (Action)Delegate.Remove(syncSlotConfigComponent.onSlotGroupChange, new Action(OnSlotGroupChange));
			}
			_syncSlotConfigComponent = value;
			if (_syncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent syncSlotConfigComponent2 = _syncSlotConfigComponent;
				syncSlotConfigComponent2.onSlotGroupChange = (Action)Delegate.Combine(syncSlotConfigComponent2.onSlotGroupChange, new Action(OnSlotGroupChange));
			}
		}
	}

	public bool CanReduceBuffTime => _reduceTimeCount > 0;

	public List<int> GetBuffIds
	{
		get
		{
			if (BuffList == null)
			{
				return null;
			}
			List<int> list = new List<int>();
			for (int i = 0; i < BuffList.Count; i++)
			{
				Buff buffConfig = BuffList.get_Item(i).buffConfig;
				if (buffConfig != null && !BuffList.get_Item(i).Removed)
				{
					list.Add(buffConfig.Id);
				}
			}
			return list;
		}
	}

	public event BuffUIHandle BuffUIEvent;

	public event ReduceTimeHandle JsReduceTimeEvent;

	public override void OnActive()
	{
	}

	public override void OnDeactive()
	{
		OnClear();
		ClearBuffTopoHeadEffectSlots();
	}

	public void InitBuff(AdventureActor _ad)
	{
		_owner = _ad;
		InitBuffTopoHeadEffectSlots();
	}

	public void LogicUpdate(FP deltaTime)
	{
		if (BuffList == null || BuffList.Count < 1)
		{
			return;
		}
		int num = BuffList.Count - 1;
		while (num > -1 && num < BuffList.Count)
		{
			BuffEntity buffEntity = BuffList.get_Item(num);
			if (buffEntity.Removed)
			{
				BuffList.RemoveAt(num);
				Singleton<BuffManager>.Instance.EnterBuffPool(buffEntity);
			}
			else
			{
				buffEntity.OnUpdate(deltaTime);
			}
			num--;
		}
		UpdateBuffHeadEffectShow();
	}

	public void OnClear()
	{
		if (BuffList != null)
		{
			int num = BuffList.Count - 1;
			while (num > -1 && num < BuffList.Count)
			{
				BuffEntity buffEntity = BuffList.get_Item(num);
				BuffList.RemoveAt(num);
				RemoveBuff(buffEntity, BuffManager.BuffRemoveType.ReycleClear);
				Singleton<BuffManager>.Instance.EnterBuffPool(buffEntity);
				num--;
			}
			BuffList.Clear();
		}
		firstIdBuffs?.Clear();
		immunityIds?.Clear();
		immunityGroupIds?.Clear();
		immunityTags?.Clear();
		_owner = null;
	}

	public void FireBuffUiEvent(int uid, int id, int valueId, int count, FP leftTime, string name, bool showTime = false)
	{
		if (!showTime)
		{
			BuffUIEvent?.Invoke(uid, id, count, leftTime);
		}
	}

	public void ResetFirstSameBuffId(BuffEntity _buff)
	{
		if (_buff.GetUid() == GetFirstSameBuffId(_buff.buffConfig.Id, iremove: true))
		{
			firstIdBuffs.Remove(_buff.buffConfig.Id);
		}
	}

	public int GetFirstSameBuffId(int buffID, bool iremove = false)
	{
		if (firstIdBuffs == null)
		{
			firstIdBuffs = new Dictionary<int, int>();
		}
		if (firstIdBuffs.TryGetValue(buffID, out var value))
		{
			return value;
		}
		if (!iremove)
		{
			for (int i = 0; i < BuffList.Count; i++)
			{
				if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.Id == buffID)
				{
					value = BuffList.get_Item(i).GetUid();
					if (value != 0)
					{
						firstIdBuffs.Add(buffID, value);
					}
					return value;
				}
			}
		}
		return value;
	}

	public void InitBuffTopoHeadEffectSlots()
	{
		syncSlotComponent = OwnerActor?.GetComponent<AnimationSlotConfigComponent>();
		if (null == syncSlotComponent)
		{
			Debug.Log("没有找到角色挂点组件:[" + name + "]");
			return;
		}
		buffSlotRoot = syncSlotComponent.GetMarkSlotRoot();
		if (null == buffSlotRoot)
		{
			Debug.Log("角色[" + OwnerActor.name + "]没有配置BUFF槽位");
			return;
		}
		if (buffHeadSlots == null)
		{
			buffHeadSlots = new List<BuffHeadSlot>(3);
		}
		buffHeadSlots.Clear();
		for (int i = 0; i < 3; i++)
		{
			Transform markSlot = syncSlotComponent.GetMarkSlot(i);
			if (null == markSlot)
			{
				Debug.LogError("角色[" + OwnerActor.name + "]的BUFF槽位出错!");
				break;
			}
			BuffHeadSlot item = new BuffHeadSlot
			{
				slot = markSlot,
				buffID = 0,
				buffNum = 0
			};
			buffHeadSlots.Add(item);
		}
	}

	public void ClearBuffTopoHeadEffectSlots()
	{
		syncSlotComponent = null;
	}

	private void OnSlotGroupChange()
	{
		if (!topoSlotIsValid)
		{
			return;
		}
		buffSlotRoot = syncSlotComponent.GetMarkSlotRoot();
		if (null == buffSlotRoot)
		{
			Debug.LogError("角色[" + OwnerActor.name + "]的BUFF槽位出错!");
			return;
		}
		for (int i = 0; i < 3; i++)
		{
			Transform markSlot = syncSlotComponent.GetMarkSlot(i);
			if (null == markSlot)
			{
				Debug.Log("角色[" + OwnerActor.name + "]的BUFF槽位出错!");
				break;
			}
			BuffHeadSlot buffHeadSlot = buffHeadSlots.get_Item(i);
			buffHeadSlot.slot = markSlot;
			if (null != buffHeadSlot.fxPLayer)
			{
				buffHeadSlot.fxPLayer.syncNode = markSlot;
			}
		}
	}

	public void AddBufftTopoHeadEffect(Buff buffConfig, int buffNum)
	{
		if (!topoSlotIsValid || buffConfig == null)
		{
			return;
		}
		string topofHeadEffect = buffConfig.TopofHeadEffect;
		if (string.IsNullOrEmpty(topofHeadEffect))
		{
			return;
		}
		RepeatedField<int> buffNumEffects = buffConfig.BuffNumEffectLevel;
		for (int i = 0; i < 3; i++)
		{
			BuffHeadSlot buffHeadSlot = buffHeadSlots.get_Item(i);
			if (buffConfig.Id == buffHeadSlot.buffID)
			{
				buffHeadSlot.buffNum = GetBuffEffectNum(buffNum);
				RefreshBuffSlot(buffHeadSlot);
				Token(i + 1);
				return;
			}
		}
		for (int j = 0; j < 3; j++)
		{
			BuffHeadSlot buffHeadSlot2 = buffHeadSlots.get_Item(j);
			if (!buffHeadSlot2.token)
			{
				buffHeadSlot2.buffID = buffConfig.Id;
				buffHeadSlot2.buffNum = GetBuffEffectNum(buffNum);
				buffHeadSlot2.buffPath = topofHeadEffect;
				RefreshBuffSlot(buffHeadSlot2);
				return;
			}
		}
		BuffHeadSlot buffHeadSlot3 = buffHeadSlots.get_Item(tokenIndex);
		buffHeadSlot3.buffID = buffConfig.Id;
		buffHeadSlot3.buffNum = GetBuffEffectNum(buffNum);
		buffHeadSlot3.buffPath = topofHeadEffect;
		Token(tokenIndex + 1);
		RefreshBuffSlot(buffHeadSlot3);
		int GetBuffEffectNum(int num2)
		{
			if (buffNumEffects == null || buffNumEffects.Count == 0)
			{
				return 1;
			}
			int num = num2 - 1;
			if (num >= buffNumEffects.Count)
			{
				Debug.LogError("buff特效级别数组错误!");
				return 0;
			}
			return buffNumEffects.get_Item(num);
		}
		void Token(int token)
		{
			tokenIndex = token;
			if (tokenIndex == 3)
			{
				tokenIndex = 0;
			}
		}
	}

	private void RefreshBuffSlot(BuffHeadSlot slot)
	{
		if (!topoSlotIsValid)
		{
			return;
		}
		int buffNum = slot.buffNum;
		switch (buffNum)
		{
		case 0:
		{
			Debug.LogError($"未知错误,BUFF层数为0:{slot.buffID}");
			slot.buffID = 0;
			AdventureMarkFXHandler fxPLayer2 = slot.fxPLayer;
			if (null != slot.fxPLayer)
			{
				fxPLayer2.StopFX();
				slot.fxPLayer = null;
			}
			break;
		}
		case 1:
		{
			AdventureMarkFXHandler fxPLayer3 = slot.fxPLayer;
			if (null != slot.fxPLayer)
			{
				fxPLayer3.StopFX();
				slot.fxPLayer = null;
			}
			string text = "Assets/AssetBundles/" + slot.buffPath + ".prefab";
			if (string.IsNullOrEmpty(text))
			{
				Debug.LogError($"BUFF头顶效果为空:[{slot.buffID}]");
				break;
			}
			UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.FX, text, typeof(GameObject));
			if (null == obj)
			{
				Debug.LogError("Buff头顶特效资源为空:" + text);
				break;
			}
			fxPLayer3 = AdventureMarkFXHandler.PlayFX(obj as GameObject, OwnerActor, slot.slot);
			if (null == fxPLayer3)
			{
				Debug.LogError("Buff头顶特效资源为空:" + text);
			}
			else
			{
				slot.fxPLayer = fxPLayer3;
			}
			break;
		}
		default:
		{
			AdventureMarkFXHandler fxPLayer = slot.fxPLayer;
			if (null != fxPLayer)
			{
				fxPLayer.UpdateMark(buffNum);
			}
			break;
		}
		}
	}

	public void RemoveBuffTopoHeadEffect(Buff buffData)
	{
		if (!topoSlotIsValid || buffData == null)
		{
			return;
		}
		for (int i = 0; i < 3; i++)
		{
			BuffHeadSlot buffHeadSlot = buffHeadSlots.get_Item(i);
			if (buffData.Id == buffHeadSlot.buffID)
			{
				buffHeadSlot.buffID = 0;
				buffHeadSlot.buffNum = 0;
				AdventureMarkFXHandler fxPLayer = buffHeadSlot.fxPLayer;
				if (null != fxPLayer)
				{
					fxPLayer.StopFX();
					buffHeadSlot.fxPLayer = null;
				}
				break;
			}
		}
	}

	private void UpdateBuffHeadEffectShow()
	{
		if (topoSlotIsValid && !(null == buffSlotRoot))
		{
			CinemachineVirtualCamera cinemachineVirtualCamera = SceneSingleton<AdventurePlayerController>.Instance?.playerMainVCam;
			if (!(null == cinemachineVirtualCamera))
			{
				buffSlotRoot.LookAt(cinemachineVirtualCamera.transform);
			}
		}
	}

	public void AddBuffImmunityTag(int buffID, int buffGroupId, int buffTag)
	{
		int value;
		if (buffID > 0)
		{
			if (immunityIds == null)
			{
				immunityIds = new Dictionary<int, int>();
			}
			if (immunityIds.TryGetValue(buffID, out value))
			{
				immunityIds.set_Item(buffID, ++value);
			}
			else
			{
				immunityIds.Add(buffID, 1);
			}
		}
		if (buffGroupId > 0)
		{
			if (immunityGroupIds == null)
			{
				immunityGroupIds = new Dictionary<int, int>();
			}
			if (immunityGroupIds.TryGetValue(buffGroupId, out value))
			{
				immunityGroupIds.set_Item(buffGroupId, ++value);
			}
			else
			{
				immunityGroupIds.Add(buffGroupId, 1);
			}
		}
		if (buffTag != 0)
		{
			if (immunityTags == null)
			{
				immunityTags = new Dictionary<int, int>();
			}
			if (immunityTags.TryGetValue(buffTag, out value))
			{
				immunityTags.set_Item(buffTag, ++value);
			}
			else
			{
				immunityTags.Add(buffTag, 1);
			}
		}
	}

	public void RemoveBuffImmunityTag(int buffID, int buffGroupId, int buffTag)
	{
		if (buffID > 0 && immunityIds != null && immunityIds.TryGetValue(buffID, out var value))
		{
			value--;
			if (value < 1)
			{
				immunityIds.Remove(buffID);
			}
			else
			{
				immunityIds.set_Item(buffID, value);
			}
		}
		if (buffGroupId > 0 && immunityGroupIds != null && immunityGroupIds.TryGetValue(buffGroupId, out value))
		{
			value--;
			if (value < 1)
			{
				immunityGroupIds.Remove(buffGroupId);
			}
			else
			{
				immunityGroupIds.set_Item(buffGroupId, value);
			}
		}
		if (buffTag != 0 && immunityTags != null && immunityTags.TryGetValue(buffTag, out value))
		{
			value--;
			if (value < 1)
			{
				immunityTags.Remove(buffTag);
			}
			else
			{
				immunityTags.set_Item(buffTag, value);
			}
		}
	}

	private bool CheckBuffImmunity(Buff buffConfig)
	{
		if (immunityIds != null && immunityIds.ContainsKey(buffConfig.Id))
		{
			return true;
		}
		if (immunityGroupIds != null && immunityGroupIds.ContainsKey(buffConfig.GroupId))
		{
			return true;
		}
		if (immunityTags != null)
		{
			if (immunityTags.ContainsKey(buffConfig.BuffTag1))
			{
				return true;
			}
			if (immunityTags.ContainsKey(buffConfig.BuffTag2))
			{
				return true;
			}
			if (immunityTags.ContainsKey(buffConfig.BuffTag3))
			{
				return true;
			}
			if (immunityTags.ContainsKey(buffConfig.BuffTag4))
			{
				return true;
			}
			if (immunityTags.ContainsKey(buffConfig.BuffTag5))
			{
				return true;
			}
		}
		return false;
	}

	public void AddBuffReduceTime()
	{
		_reduceTimeCount++;
		if (_reduceTimeCount == 1)
		{
			Singleton<BuffManager>.Instance.AddBuffReduceTime(this);
			JsReduceTimeEvent?.Invoke(active: true);
		}
	}

	public void RemoveBuffReduceTime()
	{
		_reduceTimeCount--;
		_reduceTimeCount = ((_reduceTimeCount >= 0) ? _reduceTimeCount : 0);
		if (_reduceTimeCount == 0)
		{
			Singleton<BuffManager>.Instance.RemoveBuffReduceTime(this);
			JsReduceTimeEvent?.Invoke(active: false);
		}
	}

	public void ReduceBuffTime(BuffEntity buffEntity)
	{
		if (buffEntity.buffConfig.ReduceTime > 0 && (bool)OwnerActor && OwnerActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor)
		{
			if (Singleton<BuffManager>.Instance._reduceCount > 1)
			{
				_reduceCountA++;
				buffEntity.UpdateLeftTime(buffEntity.inputReduceTime);
			}
			if (_reduceCountA >= _reduceTimeCount)
			{
				_reduceCountA = 0;
				Singleton<BuffManager>.Instance._reduceCount = 0;
			}
		}
	}

	private bool CheckBuffTag(int _tag, Buff buffConfig)
	{
		if (_tag != 0)
		{
			if (buffConfig.BuffTag1 == _tag)
			{
				return true;
			}
			if (buffConfig.BuffTag2 == _tag)
			{
				return true;
			}
			if (buffConfig.BuffTag3 == _tag)
			{
				return true;
			}
			if (buffConfig.BuffTag4 == _tag)
			{
				return true;
			}
			if (buffConfig.BuffTag5 == _tag)
			{
				return true;
			}
		}
		return false;
	}

	private void AddBuffTag(BuffEntity buffEn)
	{
		if (buffEn != null)
		{
			if (buffEn.buffConfig.BuffTag1 != 0)
			{
				addTags(buffEn.buffConfig.BuffTag1, buffEn);
			}
			if (buffEn.buffConfig.BuffTag2 != 0)
			{
				addTags(buffEn.buffConfig.BuffTag2, buffEn);
			}
			if (buffEn.buffConfig.BuffTag3 != 0)
			{
				addTags(buffEn.buffConfig.BuffTag3, buffEn);
			}
			if (buffEn.buffConfig.BuffTag4 != 0)
			{
				addTags(buffEn.buffConfig.BuffTag4, buffEn);
			}
			if (buffEn.buffConfig.BuffTag5 != 0)
			{
				addTags(buffEn.buffConfig.BuffTag5, buffEn);
			}
		}
	}

	private void RemoveBuffTag(BuffEntity buffEn)
	{
	}

	private void addTags(int tag1, BuffEntity buffEn)
	{
	}

	public void OnActorActive()
	{
		Singleton<BuffManager>.Instance.InhertBuff(this);
	}

	public void OnActorLeave(bool iM = false)
	{
		if (BuffList == null || BuffList.Count < 1)
		{
			return;
		}
		if (iM)
		{
			for (int num = BuffList.Count - 1; num > -1; num--)
			{
				if (!BuffList.get_Item(num).Removed && BuffList.get_Item(num).buffValueConfig.IsExitDelete)
				{
					RemoveBuff(BuffList.get_Item(num));
				}
			}
			return;
		}
		for (int num2 = BuffList.Count - 1; num2 > -1; num2--)
		{
			if (!BuffList.get_Item(num2).Removed && BuffList.get_Item(num2).buffValueConfig.IsInherit)
			{
				Singleton<BuffManager>.Instance.SetInhertBuff(BuffList.get_Item(num2));
				RemoveBuff(BuffList.get_Item(num2));
			}
		}
		if (OwnerActor.Id != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id)
		{
			Singleton<BuffManager>.Instance.InhertBuff(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent);
		}
	}

	public void AddBuffNum(int buffID, int num, AdventureActor fromActor)
	{
		if (num < 1)
		{
			return;
		}
		BuffEntity buffEntity = AddBuff(buffID, fromActor);
		if (buffEntity == null || num <= 1)
		{
			return;
		}
		for (int i = 0; i < num - 1; i++)
		{
			if (!buffEntity.AddBuffNum(fromActor))
			{
				break;
			}
		}
	}

	private Buff GetBuffConfig(int buffID)
	{
		Buff buff = Singleton<HotfixDataController>.Instance.GetBuff(buffID);
		if (buff == null)
		{
			Debug.LogError("buffConfig not Contains Id:" + buffID);
			return null;
		}
		return buff;
	}

	private BuffValue GetBuffValueConfig(Buff buffConfig, AdventureActor fromActor)
	{
		if (buffConfig == null)
		{
			return null;
		}
		int valueConfigIdByLevelType = CommonHelper.GetValueConfigIdByLevelType((fromActor == null) ? _owner : fromActor, buffConfig.Id, (HotfixEnum.levelTypeData)buffConfig.LevelTypeData, buffConfig.LevelData);
		BuffValue buffValue = Singleton<HotfixDataController>.Instance.GetBuffValue(valueConfigIdByLevelType);
		if (buffValue == null)
		{
			Debug.LogError("buff value Config not Contains Id:" + valueConfigIdByLevelType);
			return null;
		}
		return buffValue;
	}

	private bool CheckBuff(Buff buffConfig, AdventureActor fromActor)
	{
		bool flag = _owner.CheckCost_AddDeBuff();
		if (flag || _owner.IsCanNotAddDeBuff)
		{
			if (_owner.isInvincible && (CheckBuffTag(CommonHelper.StringToHash(AdventureModuleController.Config.BuffTag_ReduceAttr), buffConfig) || CheckBuffTag(CommonHelper.StringToHash(AdventureModuleController.Config.BuffTag_Weaken), buffConfig)))
			{
				AddBuffFailEvent(buffConfig.Id, fromActor, BuffManager.BuffAddFailType.PrimeState);
				return false;
			}
			if (CheckBuffTag(CommonHelper.StringToHash(AdventureModuleController.Config.BuffTag_Weaken), buffConfig))
			{
				AddBuffFailEvent(buffConfig.Id, fromActor, BuffManager.BuffAddFailType.PrimeState);
				return false;
			}
		}
		if ((flag || _owner.IsCanNotAddBuff) && CheckBuffTag(CommonHelper.StringToHash(AdventureModuleController.Config.BuffTag_Enhance), buffConfig))
		{
			AddBuffFailEvent(buffConfig.Id, fromActor, BuffManager.BuffAddFailType.PrimeState);
			return false;
		}
		if (CheckBuffImmunity(buffConfig))
		{
			AddBuffFailEvent(buffConfig.Id, fromActor, BuffManager.BuffAddFailType.PrimeState);
			return false;
		}
		return true;
	}

	private void AddBuffFailEvent(int buffID, AdventureActor fromActor, BuffManager.BuffAddFailType eventType)
	{
		AdventureActorAddBuffFail adventureActorAddBuffFail = AdventureActorAddBuffFail.Generate();
		adventureActorAddBuffFail.sender = OwnerActor;
		adventureActorAddBuffFail.actor = fromActor;
		adventureActorAddBuffFail.buffId = buffID;
		adventureActorAddBuffFail.failType = eventType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAddBuffFail);
	}

	public BuffEntity AddBuff(int buffID, AdventureActor fromActor)
	{
		if (buffID == 0)
		{
			Debug.LogWarning("AddBuff error buffId======" + buffID);
			return null;
		}
		if (_owner == null)
		{
			_owner = GetComponent<AdventureActor>();
		}
		if (_owner == null)
		{
			return null;
		}
		if (_owner.actorHealthInfo == null || !_owner.actorHealthInfo.isAlive)
		{
			return null;
		}
		Buff buffConfig = GetBuffConfig(buffID);
		BuffValue buffValueConfig = GetBuffValueConfig(buffConfig, fromActor);
		if (buffConfig == null || buffValueConfig == null)
		{
			return null;
		}
		if (!CheckBuff(buffConfig, fromActor))
		{
			return null;
		}
		if (BuffList == null)
		{
			List<BuffEntity> list = (BuffList = new List<BuffEntity>());
		}
		BuffEntity buffEntity = null;
		BuffEntity buffEntity2 = null;
		int num = 0;
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (BuffList.get_Item(i).Removed)
			{
				continue;
			}
			if (BuffList.get_Item(i).buffConfig.Id == buffID)
			{
				num++;
				if (buffEntity == null)
				{
					buffEntity = BuffList.get_Item(i);
				}
				else if (buffEntity.buffValueConfig.ReplaceMode)
				{
					buffEntity = BuffList.get_Item(i);
				}
				if (BuffList.get_Item(i).AddBuffNum(fromActor))
				{
					return buffEntity;
				}
			}
			else if (BuffList.get_Item(i).buffConfig.GroupId == buffConfig.GroupId)
			{
				if (buffValueConfig.Sort >= BuffList.get_Item(i).buffValueConfig.Sort)
				{
					buffEntity2 = BuffList.get_Item(i);
					break;
				}
				AddBuffFailEvent(buffID, fromActor, BuffManager.BuffAddFailType.GroupIdBySort);
				return null;
			}
		}
		if (buffEntity != null && num >= buffEntity.buffValueConfig.Num)
		{
			if (buffEntity.buffValueConfig.ReplaceType)
			{
				if (buffEntity.buffValueConfig.ReplaceMode)
				{
					buffEntity.InitTime(addNum: true, iRefresh: true, (fromActor == null) ? _owner : fromActor);
					if (buffEntity.Removed)
					{
						return buffEntity;
					}
					AddBufftTopoHeadEffect(buffEntity.buffConfig, buffEntity.GetBuffNum());
					FireBuffUiEvent(buffEntity.GetUid(), buffEntity.buffConfig.Id, buffEntity.buffValueConfig.Id, buffEntity.GetBuffNum(), buffEntity.GetBuffLeftTime(), buffEntity.buffConfig.Name);
					Singleton<BuffEffectManager>.Instance.RefreshOnceDot(buffEntity, iRestart: true);
					return buffEntity;
				}
				RemoveBuff(buffEntity, BuffManager.BuffRemoveType.BuffInstanceLimit);
				BuffEntity buffEntity3 = Singleton<BuffManager>.Instance.GetBuffEntity(buffConfig, buffValueConfig, this, fromActor);
				BuffList.Add(buffEntity3);
				buffEntity3.BuffExcute(BuffManager.BuffAddType.BuffInstanceLimit, fromActor);
				return buffEntity3;
			}
			AddBuffFailEvent(buffID, fromActor, BuffManager.BuffAddFailType.BuffInstanceLimit);
			return buffEntity;
		}
		BuffManager.BuffAddType addType = BuffManager.BuffAddType.Normal;
		if (buffEntity2 != null)
		{
			addType = BuffManager.BuffAddType.GroupIdBySort;
			RemoveBuffByBuffId(buffEntity2.buffConfig.Id, 0, BuffManager.BuffRemoveType.GroupIdBySort);
		}
		BuffEntity buffEntity4 = Singleton<BuffManager>.Instance.GetBuffEntity(buffConfig, buffValueConfig, this, fromActor);
		BuffList.Add(buffEntity4);
		buffEntity4.BuffExcute(addType, fromActor);
		return buffEntity4;
	}

	public void ResetBuff(int id, int num, FP leftTime)
	{
		if (num > 0)
		{
			if (BuffList == null)
			{
				List<BuffEntity> list = (BuffList = new List<BuffEntity>());
			}
			int count = BuffList.Count;
			for (int i = 0; i < num; i++)
			{
				AddBuff(id, OwnerActor);
			}
			if (BuffList.Count > count)
			{
				BuffList.get_Item(count).SetTime(leftTime);
			}
		}
	}

	public bool CheckBuff(int buffTag = 0, int buffID = 0, int buffGroupID = 0, AdventureActor from = null)
	{
		if (BuffList == null)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed)
			{
				bool num = buffID == 0 || BuffList.get_Item(i).buffConfig.Id == buffID;
				bool flag = buffGroupID == 0 || BuffList.get_Item(i).buffConfig.GroupId == buffGroupID;
				bool flag2 = buffTag == 0 || BuffList.get_Item(i).CheckBuffTag(buffTag);
				bool flag3 = from == null || BuffList.get_Item(i).CheckBuffFrom(from);
				if (num & flag & flag2 & flag3)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool CheckBuffByBuffTag(int buffTag)
	{
		if (BuffList == null)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).CheckBuffTag(buffTag))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBuffByBuffID(int buffID)
	{
		if (BuffList == null)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.Id == buffID)
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckBuffByBuffGroupID(int buffGroupID)
	{
		if (BuffList == null)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.GroupId == buffGroupID)
			{
				return true;
			}
		}
		return false;
	}

	public int GetBuffNumByID(int buffID)
	{
		return GetBuffNum(buffID, 0);
	}

	public int GetBuffNum(int buffID, int groupID, int buffTag = 0)
	{
		int num = 0;
		if (BuffList == null)
		{
			return num;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed)
			{
				bool num2 = buffID == 0 || BuffList.get_Item(i).buffConfig.Id == buffID;
				bool flag = groupID == 0 || BuffList.get_Item(i).buffConfig.GroupId == groupID;
				bool flag2 = buffTag == 0 || BuffList.get_Item(i).CheckBuffTag(buffTag);
				if (num2 & flag & flag2)
				{
					num += BuffList.get_Item(i).GetBuffNum();
				}
			}
		}
		return num;
	}

	public bool HaveBuffNumMax(int buffID, int groupID = 0, int buffTag = 0)
	{
		if (BuffList == null)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed)
			{
				bool num = buffID == 0 || BuffList.get_Item(i).buffConfig.Id == buffID;
				bool flag = groupID == 0 || BuffList.get_Item(i).buffConfig.GroupId == groupID;
				bool flag2 = buffTag == 0 || BuffList.get_Item(i).CheckBuffTag(buffTag);
				if ((num & flag & flag2) && BuffList.get_Item(i).GetBuffNum() >= BuffList.get_Item(i).GetMaxNum())
				{
					return true;
				}
			}
		}
		return false;
	}

	public List<BuffEntity> GetBuff(int buffID, int groupID, int buffTag)
	{
		List<BuffEntity> list = new List<BuffEntity>();
		if (BuffList == null)
		{
			return null;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed)
			{
				bool num = buffID == 0 || BuffList.get_Item(i).buffConfig.Id == buffID;
				bool flag = groupID == 0 || BuffList.get_Item(i).buffConfig.GroupId == groupID;
				bool flag2 = buffTag == 0 || BuffList.get_Item(i).CheckBuffTag(buffTag);
				if (num & flag & flag2)
				{
					list.Add(BuffList.get_Item(i));
				}
			}
		}
		return list;
	}

	public bool RemoveBuffByBuffId(int buffID, int reduceNum = 0, BuffManager.BuffRemoveType removeType = BuffManager.BuffRemoveType.Normal)
	{
		if (BuffList == null)
		{
			return false;
		}
		if (buffID <= 0)
		{
			return false;
		}
		bool result = false;
		for (int num = BuffList.Count - 1; num > -1; num--)
		{
			if (!BuffList.get_Item(num).Removed && BuffList.get_Item(num).buffConfig.Id == buffID)
			{
				if (reduceNum > 0)
				{
					BuffList.get_Item(num).ReduceNum(reduceNum);
				}
				else
				{
					RemoveBuff(BuffList.get_Item(num), removeType);
				}
				result = true;
			}
		}
		return result;
	}

	public void RemoveBuffByGroupId(int groupId)
	{
		if (BuffList == null || groupId <= 0)
		{
			return;
		}
		for (int num = BuffList.Count - 1; num > -1; num--)
		{
			if (!BuffList.get_Item(num).Removed && BuffList.get_Item(num).buffConfig.GroupId == groupId)
			{
				RemoveBuff(BuffList.get_Item(num));
			}
		}
	}

	public void AddBuffExceptTimeByBuffID(int buffID, int time)
	{
		if (BuffList == null)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.Id == buffID)
			{
				BuffList.get_Item(i).AddExceptLeftTime(time);
				break;
			}
		}
	}

	public void AddBuffDurationByBuffID(int buffID, FP time)
	{
		if (BuffList == null)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.Id == buffID)
			{
				BuffList.get_Item(i).AddLeftTime(time);
				break;
			}
		}
	}

	public void AddBuffDurationByBuffGroupID(int buffGroupID, int time)
	{
		if (BuffList == null)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).buffConfig.GroupId == buffGroupID)
			{
				BuffList.get_Item(i).AddLeftTime(time);
			}
		}
	}

	public FP GetBuffLeftTimeByBuffTag(int buffTag)
	{
		FP fP = 0;
		if (BuffList == null)
		{
			return fP;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).CheckBuffTag(buffTag))
			{
				fP = ((fP > BuffList.get_Item(i).GetBuffLeftTime()) ? fP : BuffList.get_Item(i).GetBuffLeftTime());
			}
		}
		return fP;
	}

	public void AddBuffDurationByBuffTag(int buffTag, FP time)
	{
		if (BuffList == null)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed && BuffList.get_Item(i).CheckBuffTag(buffTag))
			{
				BuffList.get_Item(i).AddLeftTime(time);
			}
		}
	}

	public void SetBuffTime(FP value, int percent, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		if (BuffList == null || BuffList.Count < 1)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (!BuffList.get_Item(i).Removed)
			{
				if (BuffList.get_Item(i).buffConfig.Id == buffID)
				{
					BuffList.get_Item(i).AjustTime(value, percent);
				}
				else if (BuffList.get_Item(i).buffConfig.GroupId == buffGroupID || BuffList.get_Item(i).CheckBuffTag(buffTag))
				{
					BuffList.get_Item(i).AjustTime(value, percent);
				}
			}
		}
	}

	public void AdjustBuffNum(int num, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		if (BuffList == null || BuffList.Count < 1)
		{
			return;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			if (BuffList.get_Item(i).buffConfig.Id == buffID)
			{
				BuffList.get_Item(i).AdjustNum(num);
			}
			else if (BuffList.get_Item(i).buffConfig.GroupId == buffGroupID || BuffList.get_Item(i).CheckBuffTag(buffTag))
			{
				BuffList.get_Item(i).AdjustNum(num);
			}
		}
	}

	public void RemoveBuffByTag(int buffTag)
	{
		if (BuffList == null || buffTag == 0)
		{
			return;
		}
		for (int num = BuffList.Count - 1; num > -1; num--)
		{
			if (BuffList.get_Item(num).CheckBuffTag(buffTag))
			{
				RemoveBuff(BuffList.get_Item(num));
			}
		}
	}

	public void RemoveBuff(BuffEntity _buff, BuffManager.BuffRemoveType removeType = BuffManager.BuffRemoveType.Normal)
	{
		if (BuffList != null)
		{
			_buff?.BuffEnd(removeType);
		}
	}

	public void AddBuffs(List<int> buffs, AdventureActor fromActor)
	{
		for (int i = 0; i < buffs.Count; i++)
		{
			AddBuff(buffs.get_Item(i), fromActor);
		}
	}

	public void RemoveBuffs(List<int> buffs)
	{
		for (int i = 0; i < buffs.Count; i++)
		{
			RemoveBuffByBuffId(buffs.get_Item(i));
		}
	}
}
