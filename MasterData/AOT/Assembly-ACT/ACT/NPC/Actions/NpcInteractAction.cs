using System;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.EventTrack;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.NPC.Actions;

[Serializable]
public abstract class NpcInteractAction : IComparable<NpcInteractAction>
{
	public bool useNpcCamera;

	public int characterId;

	protected NpcInteractActionContext Context;

	protected int _npcId;

	public abstract int ActionId { get; }

	public bool IsAsync => GetType().GetCustomAttributes(typeof(AsyncActionAttribute), inherit: false).Length != 0;

	protected internal virtual async UniTask AfterDoAction()
	{
		await UniTask.CompletedTask;
	}

	public async UniTask DoAction(NpcInteractActionContext context)
	{
		Context = context;
		if (!Singleton<RuntimeNpcManager>.HasInstance())
		{
			return;
		}
		Entity npc = Context.Npc;
		if (npc.IsValid)
		{
			CompNpc compNpc = npc.GetCompNpc();
			if (compNpc != null)
			{
				Context.StackDepth++;
				_npcId = compNpc.NpcConfigUid;
				Singleton<RuntimeNpcManager>.instance.PushNpcDialogueState(compNpc, useNpcCamera, characterId);
				await DoAction();
				Singleton<RuntimeNpcManager>.instance.PopNpcDialogueState();
				Context.StackDepth--;
			}
		}
	}

	protected virtual async UniTask DoAction()
	{
		NpcInteractAction npcInteractAction = this;
		int num;
		if (npcInteractAction is ActionChangeStateObject)
		{
			num = 7;
		}
		else if (npcInteractAction is ActionOpenPropsItemView)
		{
			num = 5;
		}
		else
		{
			num = ((npcInteractAction is ActionOpenUI) ? 6 : ((npcInteractAction is ActionPlayNpcAvgDialogue) ? 1 : ((npcInteractAction is ActionPlayAvgDialogue) ? 2 : ((npcInteractAction is ActionPlayTimeline) ? 3 : ((npcInteractAction is ActionReceiveMission) ? 4 : ((npcInteractAction is ActionSetNpcAnimator) ? (-1) : ((!(npcInteractAction is ActionTeleport)) ? (-1) : 8)))))));
		}
		int num2 = num;
		if (num2 < 0)
		{
			return;
		}
		NpcInteractEvent evt = EventTrackSolver.Instance.GetEvt<NpcInteractEvent>();
		evt.type = num2;
		evt.subMissionId = 0;
		evt.dramaId = 0;
		evt.npcId = _npcId;
		npcInteractAction = this;
		if (!(npcInteractAction is ActionReceiveMission actionReceiveMission))
		{
			if (!(npcInteractAction is ActionOpenPropsItemView actionOpenPropsItemView))
			{
				if (!(npcInteractAction is ActionPlayNpcAvgDialogue actionPlayNpcAvgDialogue))
				{
					if (!(npcInteractAction is ActionPlayAvgDialogue actionPlayAvgDialogue))
					{
						if (npcInteractAction is ActionPlayTimeline actionPlayTimeline)
						{
							evt.dramaId = actionPlayTimeline.timelineID;
						}
					}
					else
					{
						evt.dramaId = actionPlayAvgDialogue.avgGroupID;
					}
				}
				else
				{
					evt.dramaId = actionPlayNpcAvgDialogue.avgGroupID;
				}
			}
			else
			{
				evt.subMissionId = actionOpenPropsItemView.missionID;
			}
		}
		else
		{
			evt.subMissionId = actionReceiveMission.missionID;
		}
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public int CompareTo(NpcInteractAction other)
	{
		if (IsAsync)
		{
			if (!other.IsAsync)
			{
				return 1;
			}
		}
		else if (other.IsAsync)
		{
			return -1;
		}
		return 0;
	}
}
