using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.World.Actions;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.World.StateObject.EntryProcessors;

public class ButtonEntryProcessor : BaseEntryProcessor<IButtonEntrySetting>
{
	protected override async UniTask OnInteract(IButtonEntrySetting entry, Entity behave, InteractAction.InteractSource interactSource)
	{
		MotionState stateType = behave.GetCompMotion().layer0Peak.state.value.stateType;
		if (entry.OpenBoxAni)
		{
			if (GameUtility.CanInteract())
			{
				OpenBox(entry, behave).Forget();
			}
			else if (stateType != MotionState.OpenBox)
			{
				GameUtility.OpenToolTip(664);
			}
		}
		else if (entry.MotionLimitButtonInteract)
		{
			if (GameUtility.CanInteract())
			{
				base.OnInteract(entry, behave, interactSource);
			}
			else
			{
				GameUtility.OpenToolTip(664);
			}
		}
		else
		{
			base.OnInteract(entry, behave, interactSource);
		}
	}

	protected async UniTaskVoid OpenBox(IButtonEntrySetting entry, Entity behave)
	{
		State state = behave.GetCompMotion().moveController.childrenStateLayers[0].states.Find((State x) => x.value.stateType == MotionState.OpenBox);
		GameManager.behaveSystem.ForcedChangeToMotionState(behave, state);
		behave.SetFaceLeft(behave.GetCompTransform().physicsPosition.x - entry.EntityReference.GetCompStateObject().StateObjectBase.transform.position.x > 0f);
		base.OnInteract(entry, behave, InteractAction.InteractSource.Player);
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtOpenBox evt = systemAbility.GetEvt<EvtOpenBox>(behave, null);
		evt.mainEntity = behave;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}

	protected override void Refresh(IButtonEntrySetting entry)
	{
		if (entry.ButtonShow && entry is InteractEntry entry2)
		{
			Model<InteractModel>.Interface.OnRefreshInteractBtnEntry(entry2);
			InteractEntryAdd evt = Singleton<EventManager>.instance.GetEvt<InteractEntryAdd>();
			evt.Entry = entry2;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.InteractEntry_Refresh, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected override void OnEnter(IButtonEntrySetting entry)
	{
		ShowButton(entry);
	}

	private void ShowButton(IButtonEntrySetting entry)
	{
		if (!entry.ButtonShow && entry is InteractEntry entry2)
		{
			entry.ButtonShow = true;
			Model<InteractModel>.Interface.OnAddInteractBtnEntry(entry2);
			InteractEntryAdd evt = Singleton<EventManager>.instance.GetEvt<InteractEntryAdd>();
			evt.Entry = entry2;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.InteractEntry_Add, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	protected override void OnLeave(IButtonEntrySetting entry)
	{
		HideButton(entry);
	}

	protected override void OnDeinit(IButtonEntrySetting entry)
	{
		HideButton(entry);
	}

	private void HideButton(IButtonEntrySetting entry)
	{
		if (entry.ButtonShow && entry is InteractEntry entry2)
		{
			entry.ButtonShow = false;
			Model<InteractModel>.Interface.OnRemoveInteractBtnEntry(entry2);
			InteractEntryRemove evt = Singleton<EventManager>.instance.GetEvt<InteractEntryRemove>();
			evt.Entry = entry2;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.InteractEntry_Remove, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
