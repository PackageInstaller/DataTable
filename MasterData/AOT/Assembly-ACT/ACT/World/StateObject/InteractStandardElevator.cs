using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.StateObject;

public class InteractStandardElevator : StateObjectBase
{
	public bool obstacle;

	public StandardElevatorBehaveEvents standardElevator;

	private List<InteractEntry> m_LayerEntries = new List<InteractEntry>();

	private StandardElevatorData _data;

	private bool _enter;

	public override bool serviceSave => true;

	public StandardElevatorData Data => _data;

	public bool Enter
	{
		get
		{
			return _enter;
		}
		set
		{
			_enter = value;
			if (standardElevator.Phase == 2)
			{
				Model<InteractModel>.Interface.SetRunningInSide(_enter);
			}
		}
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (!(compStateObject?.StateWorldAssetData is StandardElevatorData data))
		{
			return;
		}
		_data = data;
		int layerIndex = _data.GetLayerIndex(stateId);
		for (int i = 0; i < _data.layers.Count; i++)
		{
			int index = i;
			StandardElevatorLayer standardElevatorLayer = _data.layers[index];
			InteractEntry interactEntry = InteractEntry.CreateButtonEntry(standardElevatorLayer.layerName, standardElevatorLayer.weight, standardElevatorLayer.iconId, -1);
			interactEntry.onInteract = (Entity _) =>
			{
				RunElevator(index);
			};
			int layerLock = MonoECS.instance.ruleManager.SharedGetState(standardElevatorLayer.lockFlag);
			SetLayerObjectsStateAsyncInit(index, index == layerIndex, layerLock).Forget();
			interactEntry.BindInteractObjectBase(this);
			interactEntry.BindData(compStateObject.StateWorldAssetData);
			m_LayerEntries.Add(interactEntry);
		}
		standardElevator.OnInit(layerIndex);
		base.InitStateObject(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
		if (IsStay)
		{
			UpdateLayerEntryInteractStates();
			Model<InteractModel>.Interface.SetElevatorButtonsVisible(_data.ShouldShowLayerButtons(stateId));
		}
	}

	public void RunElevator(int index)
	{
		RunElevatorToState(_data.GetArrivalStateId(index));
	}

	public void RunElevatorToState(int targetStateId)
	{
		if (_data.GetLayerIndex(targetStateId) == _data.GetLayerIndex(currentStateId))
		{
			NetEnterState(targetStateId).Forget();
			return;
		}
		Model<InteractModel>.Interface.OnElevatorHandleMove(isMoving: true);
		UpdateLayerEntryInteractStates();
		Model<InteractModel>.Interface.SetElevatorButtonsVisible(visible: false);
		standardElevator.SetTargetState(targetStateId);
		SetLayerObjectsStateAsync(_data.GetLayerIndex(currentStateId), show: false);
		RunChangeStateObjects(start: true);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		m_LayerEntries[entryIndex].HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	protected override void HandleEnterInteract()
	{
		if (standardElevator.Phase != 2 && !_enter)
		{
			Enter = true;
			UpdateLayerEntryInteractStates();
			FireExitElevatorEnterEvt(_enter);
			Model<InteractModel>.Interface.SetElevatorButtonsVisible(_data.ShouldShowLayerButtons(currentStateId));
		}
	}

	protected override void HandleExitInteract()
	{
		if (_enter && !IsStay)
		{
			Enter = false;
			UpdateLayerEntryInteractStates();
			FireExitElevatorEnterEvt(_enter);
		}
	}

	private void FireExitElevatorEnterEvt(bool enter)
	{
		if (!enter)
		{
			bool isValid = MonoECS.instance.mainEntity.IsValid;
			CompPhysics compPhysics = MonoECS.instance.mainEntity.GetCompPhysics();
			if (isValid && compPhysics != null && compPhysics.characterMovement != null)
			{
				compPhysics.characterMovement.SetPlatform(null);
			}
		}
		Model<InteractModel>.Interface.EnterExitElevator(enter, _data, m_LayerEntries, this);
	}

	public override void ReleaseStateObject()
	{
		if (_enter)
		{
			Enter = false;
			FireExitElevatorEnterEvt(_enter);
		}
		base.ReleaseStateObject();
	}

	private void UpdateLayerEntryInteractStates()
	{
		int layerIndex = _data.GetLayerIndex(currentStateId);
		for (int i = 0; i < _data.layers.Count; i++)
		{
			m_LayerEntries[i].BindInteractState(layerIndex, i);
		}
	}

	protected override void OnCompleteTransition()
	{
		SetLayerObjectsStateAsync(_data.GetLayerIndex(currentStateId), show: true);
	}

	private async UniTask SetLayerObjectsStateAsyncInit(int layer, bool show, int layerLock)
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		List<IncludeObject> ios = ((StandardElevatorData)entity.GetCompStateObject().StateWorldAssetData).layers[layer].includedObjects;
		StateChangeInfo[] infos = new StateChangeInfo[ios.Count];
		for (int i = 0; i < ios.Count; i++)
		{
			IncludeObject obj = ios[i];
			StateWorldUid linkObject = ios[i].linkObject;
			if (!StateWorldAsset.TryGetWorldAssetBySwid(linkObject, out var _))
			{
				int num;
				do
				{
					num = linkObject;
				}
				while (num != await ruleManager.parentSwid.WaitAsync());
				InitLinkObjectState(infos, i, linkObject, layerLock, obj, show);
			}
			else
			{
				InitLinkObjectState(infos, i, linkObject, layerLock, obj, show);
			}
		}
		MonoECS.instance.ruleManager.SharedChangeStates(infos);
	}

	private void InitLinkObjectState(StateChangeInfo[] infos, int i, int uid, int layerLock, IncludeObject obj, bool show)
	{
		infos[i] = new StateChangeInfo
		{
			uid = uid,
			stateId = ((layerLock == -1) ? obj.lockLayerState : (show ? obj.inCurrentLayerState : obj.notInCurrentLayerState))
		};
	}

	public void SetLayerObjectsStateAsync(int layer, bool show)
	{
		List<IncludeObject> includedObjects = _data.layers[layer].includedObjects;
		StateChangeInfo[] array = new StateChangeInfo[includedObjects.Count];
		for (int i = 0; i < includedObjects.Count; i++)
		{
			IncludeObject includeObject = includedObjects[i];
			array[i] = new StateChangeInfo
			{
				uid = includeObject.linkObject,
				stateId = (show ? includeObject.inCurrentLayerState : includeObject.notInCurrentLayerState)
			};
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
	}

	public void RunChangeStateObjects(bool start)
	{
		List<RunChangeStateObject> list = (start ? _data.RunStartChangeStateObjects : _data.RunStopChangeStateObjects);
		StateChangeInfo[] array = new StateChangeInfo[list.Count];
		for (int i = 0; i < list.Count; i++)
		{
			RunChangeStateObject runChangeStateObject = list[i];
			array[i] = new StateChangeInfo
			{
				uid = runChangeStateObject.LinkObject,
				stateId = runChangeStateObject.StateId
			};
		}
		MonoECS.instance.ruleManager.SharedChangeStates(array);
	}

	private InteractSwitchMotionPath GetExitPathForLayer(int layerIndex)
	{
		if (layerIndex < 0 || layerIndex >= _data.layers.Count)
		{
			return null;
		}
		StandardElevatorLayer standardElevatorLayer = _data.layers[layerIndex];
		if (!standardElevatorLayer.hasExitPath)
		{
			return null;
		}
		if (StateWorldAsset.TryGetWorldAssetBySwid(standardElevatorLayer.exitPath, out var stateWorldAsset) && stateWorldAsset.stateObjectBase is InteractSwitchMotionPath result)
		{
			return result;
		}
		return null;
	}

	public bool HasExitPathForCurrentLayer()
	{
		return GetExitPathForLayer(_data.GetLayerIndex(currentStateId)) != null;
	}

	public void InteractExitPath()
	{
		InteractSwitchMotionPath exitPathForLayer = GetExitPathForLayer(_data.GetLayerIndex(currentStateId));
		if (exitPathForLayer != null)
		{
			exitPathForLayer.Interact(0, MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return _data.GetLayerIndex(fromStateId) != _data.GetLayerIndex(toStateId);
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId < m_LayerEntries.Count * 2;
		}
		return false;
	}
}
