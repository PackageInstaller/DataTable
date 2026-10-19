using System;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.StateObject;

public class InteractWildBossCollection : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	private const int Show = 0;

	private const int ShowInteracted = 1;

	private const int Hide = -1;

	[SerializeField]
	private Animator _animator;

	[SerializeField]
	private InteractEntry _interactEntryConfig;

	[SerializeField]
	private LocalizedString _showLocalizedString;

	[SerializeField]
	private LocalizedString _showInteractedLocalizedString;

	private InteractEntry _interactEntry;

	private WildBossCollectionData _data;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		_data = (WildBossCollectionData)entity.GetCompStateObject().StateWorldAssetData;
		_interactEntry = new InteractEntry();
		_interactEntry.Clone(_interactEntryConfig);
		_interactEntry.BindInteractObjectBase(this);
		_interactEntry.BindData(_data);
		if (stateId == 0 || stateId == 1)
		{
			_interactEntry.BindInteractState(stateId, 0);
		}
		InteractEntry interactEntry = _interactEntry;
		interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteractAction));
		base.InitStateObject(stateId);
	}

	private void OnInteractAction(Entity eb)
	{
		switch (currentStateId)
		{
		case 0:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSGETREWARD, new PopUpWildBossGetRewardViewData
			{
				wildBossCollectionUid = swid,
				TakeRewardSuccessAction = GetRewardSuccessAction
			});
			break;
		case 1:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSCOUNTDOWN, new PopUpWildBossCountdownViewData
			{
				monsterPointUid = _data.WildBossUid
			});
			break;
		}
	}

	private void GetRewardSuccessAction()
	{
		NetEnterState(1).Forget();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		int num = currentStateId;
		if (num == 0 || num == 1)
		{
			_interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleInitState(int stateId)
	{
		if (_animator != null)
		{
			_animator.SetInteger(State, stateId);
		}
		if (stateId == 0 || stateId == 1)
		{
			LocalizedString localizedString = ((stateId == 0) ? _showLocalizedString : _showInteractedLocalizedString);
			_interactEntry.ResetLocalizedString(localizedString);
			_interactEntry.HandleInit();
			_interactEntry.BindInteractState(stateId, 0);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (stateId == 0 || stateId == 1)
		{
			_interactEntry.HandleUninit();
		}
	}

	protected override void HandleEnterInteract()
	{
		int num = currentStateId;
		if (num == 0 || num == 1)
		{
			_interactEntry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		int num = currentStateId;
		if (num == 0 || num == 1)
		{
			_interactEntry.HandleExit();
		}
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (currentStateId == -1)
		{
			return ShowType.Hide;
		}
		return ShowType.Show;
	}

	public override bool ShowInteractTip()
	{
		return currentStateId != -1;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _interactEntry;
	}
}
