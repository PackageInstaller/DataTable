using ACT.Battle;
using ACT.EventTrack;
using ACT.Model;
using ACT.World.Actions;
using Bamboo.Chronos;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.StateObject.EntryProcessors;

public abstract class BaseEntryProcessor
{
	public abstract void Init(object entryObj);

	public abstract void Deinit(object entryObj);

	public abstract void Interact(object entryObj, Entity behave, InteractAction.InteractSource interactSource);

	public abstract void Enter(object entryObj);

	public abstract void Leave(object entryObj);

	public abstract void NetInteract(ICommonInteractEntrySetting entry);

	public abstract void AddTimer(object entryObj, float deltaTime);

	public abstract void ExitExpose(object entryObj);
}
public abstract class BaseEntryProcessor<T> : BaseEntryProcessor where T : ICommonInteractEntrySetting
{
	private bool TryGetTypedEntry(object entryObj, out T entry)
	{
		if (!(entryObj is T val))
		{
			entry = default;
			return false;
		}
		entry = val;
		return true;
	}

	public sealed override void Init(object entryObj)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			entry.StateInteractCount = 0;
			if (entryObj is IAttackEntrySetting { ChallengeInteractType: ChallangeType.ComboChallange } attackEntrySetting)
			{
				ResetComboChallenge(attackEntrySetting);
			}
			OnInit(entry);
		}
	}

	private void ResetComboChallenge(IAttackEntrySetting entry)
	{
		if (entry.Timer.IsValid())
		{
			entry.Timer.Cancel();
		}
	}

	protected virtual void OnInit(T entry)
	{
	}

	public sealed override void Deinit(object entryObj)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			OnDeinit(entry);
		}
	}

	protected virtual void OnDeinit(T entry)
	{
	}

	public sealed override async void Interact(object entryObj, Entity behave, InteractAction.InteractSource interactSource)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			StateObjectBase target = entry.EntityReference.GetCompStateObject().StateObjectBase;
			Model<InteractModel>.Interface.AppendInteractTarget(target);
			await OnInteract(entry, behave, interactSource);
			Model<InteractModel>.Interface.RemoveInteractTarget(target);
		}
	}

	public sealed override void AddTimer(object entryObj, float deltaTime)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			OnAddTimer(entry, deltaTime);
		}
	}

	protected virtual void OnAddTimer(T entryObj, float deltaTime)
	{
	}

	public sealed override void ExitExpose(object entryObj)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			OnExitExpose(entry);
		}
	}

	protected virtual void OnExitExpose(T entryObj)
	{
	}

	protected virtual async UniTask OnInteract(T entry, Entity behave, InteractAction.InteractSource interactSource)
	{
		int stateInteractCount = entry.StateInteractCount;
		entry.StateInteractCount = stateInteractCount + 1;
		stateInteractCount = entry.InteractCount;
		entry.InteractCount = stateInteractCount + 1;
		Refresh(entry);
		entry.onInteract?.Invoke(behave);
		StateObjectBase stateObjectBase = entry.EntityReference.GetCompStateObject().StateObjectBase;
		int interactId = stateObjectBase.swid;
		string objectName = stateObjectBase.name;
		int stateCurrent = stateObjectBase.currentStateId;
		int interactType = entry.Data.stateObjectType;
		if (entry.onInteractAsync != null)
		{
			await entry.onInteractAsync(behave);
		}
		await entry.InteractActionList.TryInteract(behave, interactSource);
		stateInteractCount = entry.InteractCount;
		entry.InteractCount = stateInteractCount - 1;
		Refresh(entry);
		TrackOnInteractEntryEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEntryEvt>();
		evt.interactId = interactId;
		evt.objectName = objectName;
		evt.stateCurrent = stateCurrent;
		evt.interactType = interactType;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected virtual void Refresh(T entry)
	{
	}

	public sealed override void Enter(object entryObj)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			entry.EnterState = true;
			OnEnter(entry);
		}
	}

	protected virtual void OnEnter(T entryObj)
	{
	}

	public sealed override void Leave(object entryObj)
	{
		if (TryGetTypedEntry(entryObj, out var entry))
		{
			entry.EnterState = false;
			OnLeave(entry);
		}
	}

	protected virtual void OnLeave(T entry)
	{
	}

	public sealed override void NetInteract(ICommonInteractEntrySetting entry)
	{
		if (entry.EntityReference.TryGetCompStateObject(out CompStateObject component))
		{
			TrackOnInteractEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEvt>();
			evt.interactId = component.StateObjectBase.swid;
			evt.stateCurrent = entry.StateId;
			evt.interactType = entry.Data.stateObjectType;
			evt.objectName = component.StateObjectBase.name;
			EventTrackSolver.Instance.Dispatch(evt);
			switch (entry.Terminal)
			{
			case InteractTerminal.Server:
			case InteractTerminal.Both:
				component.Interact(entry.StateId, entry.EntryIndex, MonoECS.instance.mainEntity);
				break;
			case InteractTerminal.Client:
				Interact(entry, MonoECS.instance.mainEntity, InteractAction.InteractSource.Player);
				break;
			}
		}
		else
		{
			entry.onInteract?.Invoke(MonoECS.instance.mainEntity);
		}
	}
}
