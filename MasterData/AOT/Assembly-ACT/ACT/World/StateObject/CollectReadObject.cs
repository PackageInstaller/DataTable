using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/CollectReadObject")]
public class CollectReadObject : StateObjectBase
{
	[SerializeField]
	[FormerlySerializedAs("entry")]
	private InteractEntry _entrySource;

	private InteractEntry _entry;

	private CollectReadObjectData _data;

	private Animator _animator;

	private static readonly int State = Animator.StringToHash("state");

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is CollectReadObjectData collectReadObjectData)
		{
			_data = collectReadObjectData;
			_entry = InteractEntry.CreateButtonEntry(collectReadObjectData.localizedString, 0, collectReadObjectData.iconId, collectReadObjectData.tipIcon, _entrySource);
			InteractEntry entry = _entry;
			entry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(entry.onInteractAsync, new Func<Entity, UniTask>(OnInteract));
			_entry.BindInteractObjectBase(this);
			_entry.BindData(compStateObject.StateWorldAssetData);
			_entry.BindInteractState(stateId, 0);
			_animator = GetComponent<Animator>();
			if (_animator != null)
			{
				_animator.SetInteger(State, currentStateId);
			}
			base.InitStateObject(stateId);
		}
	}

	private async UniTask OnInteract(Entity eb)
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
					isNewReadableItem = false;
					HudPropPickTextLibrary evt = Singleton<EventManager>.instance.GetEvt<HudPropPickTextLibrary>();
					evt.unlockTextId = new List<int> { _data.id };
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PropPickTextLibraryOnHud, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
				if (currentStateId == 0)
				{
					NetEnterState(1);
				}
			}
		};
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_READABLE, uiData).Forget();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 && entryIndex == 0)
		{
			_entry.HandleInteract(eb, InteractAction.InteractSource.Player);
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

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			_entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			_entry.HandleExit();
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

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if ((uint)stateId <= 1u)
		{
			_entry.HandleUninit();
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		switch (toStateId)
		{
		case 0:
			_entry.BindInteractState(toStateId, 0);
			break;
		case 1:
			_entry.BindInteractState(toStateId, 0);
			break;
		}
	}

	protected override InteractEntry GetInteractEntry()
	{
		if (currentStateId != 1)
		{
			return _entry;
		}
		return null;
	}

	protected override bool NeedInteractTip()
	{
		if (!base.NeedInteractTip())
		{
			return currentStateId == 0;
		}
		return true;
	}
}
