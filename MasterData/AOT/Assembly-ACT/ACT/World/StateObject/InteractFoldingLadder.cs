using System;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractFoldingLadder : StateObjectBase
{
	private static readonly int FoldedState = Animator.StringToHash("Folded");

	private static readonly int Folding = Animator.StringToHash("Folding");

	private const int Folded = 0;

	private const int UnFolded = 1;

	[SerializeField]
	[Header("交互按钮&交互提示配置")]
	private InteractEntry _interactEntryConfig;

	[SerializeField]
	[Header("动画")]
	private Animator _animator;

	[SerializeField]
	[Header("每个单件的父节点，也是动画要K的东西")]
	private Transform[] _ladderUnitTransParent;

	[SerializeField]
	[Header("LadderScript")]
	private Ladder _ladderScript;

	private AssetLoadHandle[] _ladderUnitHandles;

	private FoldingLadderData _data;

	private InteractEntry _interactEntry;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		_data = (FoldingLadderData)entity.GetCompStateObject().StateWorldAssetData;
		_interactEntry = new InteractEntry();
		_interactEntry.Clone(_interactEntryConfig);
		_interactEntry.BindInteractObjectBase(this);
		_interactEntry.BindData(_data);
		_interactEntry.BindInteractState(0, 0);
		InteractEntry interactEntry = _interactEntry;
		interactEntry.onInteract = (Action<Entity>)Delegate.Combine(interactEntry.onInteract, new Action<Entity>(OnInteractAction));
		_ladderUnitHandles = new AssetLoadHandle[_data.LadderUnitCount];
		for (int i = 0; i < _data.LadderUnitCount; i++)
		{
			_ladderUnitHandles[i] = AssetStationManager.BattleStation.Instantiate(_data.LadderUnitModelAssetID, _ladderUnitTransParent[i]);
		}
		_ladderScript.RuntimeSetCollider((float)_data.LadderUnitCount * _data.LadderUnitLength);
		base.InitStateObject(stateId);
	}

	private void OnInteractAction(Entity entityBehave)
	{
		if (currentStateId == 0)
		{
			NetEnterState(1).Forget();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		_animator.SetBool(FoldedState, stateId == 0);
		_ladderScript.gameObject.SetActive(stateId == 1);
		if (stateId == 0)
		{
			_interactEntry.HandleInit();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (stateId == 0)
		{
			_interactEntry.HandleUninit();
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == 0 && toStateId == 1)
		{
			_animator.SetTrigger(Folding);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == 1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			_interactEntry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			_interactEntry.HandleExit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 && entryIndex == 0)
		{
			_interactEntry.HandleInteract(eb, InteractAction.InteractSource.Player);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		for (int i = 0; i < _ladderUnitHandles.Length; i++)
		{
			AssetLoadHandle handle = _ladderUnitHandles[i];
			if (handle.IsValid)
			{
				AssetStationManager.BattleStation.Release(handle);
			}
		}
		_ladderUnitHandles = null;
		_interactEntry = null;
	}

	public override bool CanInteract()
	{
		if (currentStateId == 0)
		{
			return base.CanInteract();
		}
		return false;
	}

	public override bool ShowInteractTip()
	{
		return currentStateId == 0;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (currentStateId != 0)
		{
			return ShowType.Hide;
		}
		return ShowType.Show;
	}

	protected override bool NeedInteractTip()
	{
		return currentStateId == 0;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _interactEntry;
	}

	public override Transform GetInteractTipTransform()
	{
		return _interactEntryConfig.TipTransform;
	}
}
