using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;
using World.StateObject.Behave;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractReadObject")]
public class InteractReadObject : StateObjectBase
{
	private static readonly int Break = Animator.StringToHash("break");

	private static readonly int State = Animator.StringToHash("state");

	[SerializeField]
	[FormerlySerializedAs("entry")]
	private InteractEntry _entrySource;

	private InteractEntry _entry;

	private ReadObjectData _data;

	private AssetLoadHandle m_Handle;

	private ReadObjectBehaveEvent m_ReadObjectBehaveEvent;

	private Animator _animator;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is ReadObjectData readObjectData)
		{
			_data = readObjectData;
			_entry = InteractEntry.CreateButtonEntry(readObjectData.localizedString, 0, readObjectData.iconId, readObjectData.tipIcon, _entrySource);
			InteractEntry entry = _entry;
			entry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(entry.onInteractAsync, new Func<Entity, UniTask>(OnInteract));
			_entry.BindInteractObjectBase(this);
			_entry.BindData(compStateObject.StateWorldAssetData);
			_entry.BindInteractState(stateId, 0);
			m_Handle = AssetStationManager.BattleStation.Instantiate(readObjectData.modelAssetID, transform);
			GameObject gameObject = m_Handle.AsGameObject();
			m_ReadObjectBehaveEvent = gameObject.GetComponent<ReadObjectBehaveEvent>();
			_animator = m_Handle.AsGameObject().GetComponent<Animator>();
			if (m_ReadObjectBehaveEvent != null)
			{
				m_ReadObjectBehaveEvent.SetActiveEffect(stateId == 0);
				_entry.ResetTipTransform(m_ReadObjectBehaveEvent.tipTransform);
			}
			if (_animator != null)
			{
				_animator.SetInteger(State, currentStateId);
			}
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}

	private async UniTask OnInteract(Entity eb)
	{
		if (_data.type == ReadObjectData.ReadType.Table)
		{
			bool isNewReadableItem = false;
			if (CoreUtils.GetData(_data.id, RuntimeConfigs.data.textLibraryContents) != null && Model<TextLibraryModel>.HasInstance())
			{
				Model<TextLibraryModel>.Interface.UnlockTextLibraries(new List<int> { _data.id }, unLockFromAvg: false, isSkipAvgTextLibraryData: false, () =>
				{
					isNewReadableItem = true;
				});
			}
			ReadableViewData uiData = new ReadableViewData
			{
				id = _data.id,
				onClose = () =>
				{
					if (isNewReadableItem)
					{
						HudPropPickTextLibrary evt2 = Singleton<EventManager>.instance.GetEvt<HudPropPickTextLibrary>();
						evt2.unlockTextId = new List<int> { _data.id };
						Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PropPickTextLibraryOnHud, evt2);
						Singleton<EventManager>.instance.ReleaseEvt(evt2);
					}
					Activated();
				}
			};
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_READABLE, uiData).Forget();
		}
		TrackReadBook evt = EventTrackSolver.Instance.GetEvt<TrackReadBook>();
		evt.id = _data.id;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void Activated()
	{
		int num = currentStateId;
		if (num == 0 || num == 1)
		{
			if (_animator != null)
			{
				_animator.SetTrigger(Break);
			}
			NetEnterState(1).Forget();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		int num = currentStateId;
		if ((num == 0 || num == 1) && entryIndex == 0)
		{
			_entry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override void HandleEnterInteract()
	{
		int num = currentStateId;
		if ((uint)num <= 1u)
		{
			_entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		int num = currentStateId;
		if ((uint)num <= 1u)
		{
			_entry.HandleExit();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if ((uint)stateId <= 1u)
		{
			_entry.HandleUninit();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if ((uint)stateId <= 1u)
		{
			_entry.HandleInit();
		}
		if (_animator != null)
		{
			_animator.SetInteger(State, stateId);
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		switch (toStateId)
		{
		case 0:
			m_Handle.AsGameObject().SetActive(value: true);
			if (m_ReadObjectBehaveEvent != null)
			{
				m_ReadObjectBehaveEvent.SetActiveEffect(value: true);
			}
			_entry.BindInteractState(toStateId, 0);
			break;
		case 1:
			m_Handle.AsGameObject().SetActive(value: true);
			if (m_ReadObjectBehaveEvent != null)
			{
				m_ReadObjectBehaveEvent.SetActiveEffect(value: false);
			}
			_entry.BindInteractState(toStateId, 0);
			break;
		case -1:
			if (m_ReadObjectBehaveEvent != null)
			{
				m_ReadObjectBehaveEvent.SetActiveEffect(value: false);
			}
			m_Handle.AsGameObject().SetActive(value: false);
			break;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (-4 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _entry;
	}

	protected override bool NeedInteractTip()
	{
		return true;
	}
}
