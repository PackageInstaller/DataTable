using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.Sound;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractScenicSpot : StateObjectBase
{
	public string[] abilities;

	public Transform idleEffectTransform;

	public Transform uncollectedTransform;

	public BoxCollider triggerField;

	public BoxCollider uncollectedField;

	[SerializeField]
	[Header("父节点")]
	private GameObject _root;

	private InteractEntry _mEntry;

	private InteractScenicSpotData m_Data;

	private AssetLoadHandle m_IdleEffectHandle;

	private AssetLoadHandle m_UncolledEffectHandle;

	private uint m_UnCollectedLoopEvent;

	private bool m_Trigger;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is InteractScenicSpotData data)
		{
			m_Data = data;
			_mEntry = InteractEntry.CreateButtonEntry(m_Data.name, m_Data.weight, m_Data.iconId, -1);
			_mEntry.onInteract = (Entity _) =>
			{
				OpenTip(MonoECS.instance.mainEntity);
			};
			_mEntry.BindInteractObjectBase(this);
			_mEntry.BindData(compStateObject.StateWorldAssetData);
			m_IdleEffectHandle = AssetStationManager.BattleStation.InstantiateAsync(m_Data.idleEffectAssetID, idleEffectTransform);
			m_IdleEffectHandle.Completed += IdleEffectHandleCompleted;
			m_UncolledEffectHandle = AssetStationManager.BattleStation.InstantiateAsync(m_Data.uncollectedEffectAssetID, uncollectedTransform);
			m_UncolledEffectHandle.Completed += UncollectedEffectHandleCompleted;
			uncollectedField.size = m_Data.uncollectedBoxColliderParameters.size;
			uncollectedField.center = m_Data.uncollectedBoxColliderParameters.center;
			triggerField.size = m_Data.interactTriggerField.size;
			triggerField.center = m_Data.interactTriggerField.center;
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0)
		{
			_mEntry.BindInteractState(stateId, 0);
		}
		if (stateId == 1)
		{
			_mEntry.HandleExit();
		}
		base.HandleInitState(stateId);
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		switch (toStateId)
		{
		case 0:
			_root.SetActive(value: true);
			break;
		case -1:
		case 1:
			_root.SetActive(value: false);
			_mEntry.HandleExit();
			if (!m_Data.uncollectedSoundEvent.IsNull)
			{
				Singleton<GameManager>.instance.audioManager.Stop(m_UnCollectedLoopEvent);
			}
			break;
		}
		base.HandleChangeState(fromStateId, toStateId);
	}

	private void IdleEffectHandleCompleted(AssetLoadHandle obj)
	{
	}

	private void UncollectedEffectHandleCompleted(AssetLoadHandle obj)
	{
		obj.AsGameObject().SetActive(m_Trigger);
	}

	public void OnEnterUnCollectedTrigger()
	{
		if (currentStateId == 0)
		{
			m_Trigger = true;
			if (AssetLoadHandleExtensions.IsValid(m_UncolledEffectHandle) && m_UncolledEffectHandle.State == Bamboo.AssetField.LoadState.Success)
			{
				m_UncolledEffectHandle.AsGameObject().SetActive(value: true);
			}
			m_UnCollectedLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioUncollectedSoundEvent, new AudioPlayOptions
			{
				IsLoop = true,
				attachTarget = transform
			});
		}
	}

	public void OnExitUnCollectedTrigger()
	{
		if (currentStateId == 0)
		{
			m_Trigger = false;
			if (AssetLoadHandleExtensions.IsValid(m_UncolledEffectHandle) && m_UncolledEffectHandle.State == Bamboo.AssetField.LoadState.Success)
			{
				m_UncolledEffectHandle.AsGameObject().SetActive(value: false);
			}
			Singleton<GameManager>.instance.audioManager.Stop(m_UnCollectedLoopEvent);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 1 && stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			_mEntry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		_mEntry.HandleExit();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (eb.IsAlive())
		{
			_mEntry.HandleExit();
			_mEntry.HandleInteract(eb, interactSource);
		}
	}

	public override void ReleaseStateObject()
	{
		_mEntry.HandleExit();
		if (!m_Data.uncollectedSoundEvent.IsNull)
		{
			Singleton<GameManager>.instance.audioManager.Stop(m_UnCollectedLoopEvent);
		}
		if (AssetLoadHandleExtensions.IsValid(m_UncolledEffectHandle))
		{
			m_UncolledEffectHandle.Completed -= UncollectedEffectHandleCompleted;
			AssetStationManager.BattleStation.ReleaseInstance(m_UncolledEffectHandle);
		}
		if (AssetLoadHandleExtensions.IsValid(m_IdleEffectHandle))
		{
			m_IdleEffectHandle.Completed -= IdleEffectHandleCompleted;
			AssetStationManager.BattleStation.ReleaseInstance(m_IdleEffectHandle);
		}
		base.ReleaseStateObject();
	}

	private void OpenTip(Entity entityBehave)
	{
		OnExitUnCollectedTrigger();
		m_IdleEffectHandle.AsGameObject().SetActive(value: false);
		Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioInteractSoundEvent, new AudioPlayOptions
		{
			attachTarget = transform
		});
		CompAbility compAbility = entityBehave.GetCompAbility();
		compAbility.AddAbilities(abilities, AbilitySource.Ability);
		string[] array = abilities;
		foreach (string text in array)
		{
			compAbility.RemoveAbility(text);
		}
		m_IdleEffectHandle.AsGameObject().SetActive(value: true);
		Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioRecoverSoundEvent, new AudioPlayOptions
		{
			attachTarget = transform
		});
		bool hasNewTextLibraryUnlock = false;
		List<int> unlockTextLibraryIds = new List<int> { m_Data.unLockTextLibraryId };
		if (m_Data.unLockTextLibraryId != 0)
		{
			Model<TextLibraryModel>.Interface.UnlockTextLibraries(unlockTextLibraryIds, unLockFromAvg: false, isSkipAvgTextLibraryData: false, () =>
			{
				hasNewTextLibraryUnlock = true;
			});
		}
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SCENICSPOT, new ScenicSpotViewData
		{
			id = m_Data.unLockTextLibraryId,
			onCloseCallback = () =>
			{
				if (hasNewTextLibraryUnlock)
				{
					hasNewTextLibraryUnlock = false;
					HudPropPickTextLibrary evt = Singleton<EventManager>.instance.GetEvt<HudPropPickTextLibrary>();
					evt.unlockTextId = unlockTextLibraryIds;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PropPickTextLibraryOnHud, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			}
		});
		if (currentStateId == 0)
		{
			NetEnterState(1).Forget();
		}
	}
}
