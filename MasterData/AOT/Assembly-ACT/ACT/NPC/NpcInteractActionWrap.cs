using System;
using System.Collections.Generic;
using ACT.NPC.Actions;
using UnityEngine;

namespace ACT.NPC;

[Serializable]
public struct NpcInteractActionWrap
{
	[SerializeField]
	private int activeActionIndex;

	public ActionOpenUI openUI;

	public ActionOpenRaidView openRaidView;

	public ActionOpenReadableView openReadableView;

	public ActionOpenPropsItemView openPropsItemView;

	public ActionTeleport teleport;

	public ActionSetNpcAnimator setNpcAnimator;

	public ActionSetNpcAnimatorByName setNpcAnimatorByName;

	public ActionEnterBackRoom enterBackRoom;

	public ActionPlayNpcAvgDialogue playNpcAvgDialogue;

	public ActionChangeStateObject changeStateObject;

	public ActionPlayAvgDialogue playAvgDialogue;

	public ActionReceiveMission receiveMission;

	public ActionPlayTimeline playTimeline;

	public ActionLoadVirtualNpc loadVirtualNpc;

	public ActionSetKeyPoint setKeyPoint;

	public ActionOpenMiniGame openMiniGame;

	public int ActiveActionIndex => activeActionIndex;

	public static bool TryCreate(NpcInteractAction action, out NpcInteractActionWrap actionWrap)
	{
		actionWrap = default;
		return actionWrap.TrySetActiveAction(action);
	}

	public bool TrySetActiveAction(Type actionType, out NpcInteractAction action, out bool created)
	{
		action = GetActionByType(actionType);
		created = action == null;
		if (action == null)
		{
			action = Activator.CreateInstance(actionType) as NpcInteractAction;
			if (action == null)
			{
				return false;
			}
			if (!TrySetActiveAction(action))
			{
				return false;
			}
		}
		else
		{
			activeActionIndex = action.ActionId;
		}
		return true;
	}

	public bool TrySetActiveAction(NpcInteractAction action)
	{
		if (!(action is ActionOpenReadableView actionOpenReadableView))
		{
			if (!(action is ActionOpenRaidView actionOpenRaidView))
			{
				if (!(action is ActionOpenUI actionOpenUI))
				{
					if (!(action is ActionOpenPropsItemView actionOpenPropsItemView))
					{
						if (!(action is ActionTeleport actionTeleport))
						{
							if (!(action is ActionSetNpcAnimator actionSetNpcAnimator))
							{
								if (!(action is ActionSetNpcAnimatorByName actionSetNpcAnimatorByName))
								{
									if (!(action is ActionEnterBackRoom actionEnterBackRoom))
									{
										if (!(action is ActionPlayNpcAvgDialogue actionPlayNpcAvgDialogue))
										{
											if (!(action is ActionChangeStateObject actionChangeStateObject))
											{
												if (!(action is ActionPlayAvgDialogue actionPlayAvgDialogue))
												{
													if (!(action is ActionReceiveMission actionReceiveMission))
													{
														if (!(action is ActionPlayTimeline actionPlayTimeline))
														{
															if (!(action is ActionLoadVirtualNpc actionLoadVirtualNpc))
															{
																if (!(action is ActionSetKeyPoint actionSetKeyPoint))
																{
																	if (!(action is ActionOpenMiniGame actionOpenMiniGame))
																	{
																		return false;
																	}
																	openMiniGame = actionOpenMiniGame;
																}
																else
																{
																	setKeyPoint = actionSetKeyPoint;
																}
															}
															else
															{
																loadVirtualNpc = actionLoadVirtualNpc;
															}
														}
														else
														{
															playTimeline = actionPlayTimeline;
														}
													}
													else
													{
														receiveMission = actionReceiveMission;
													}
												}
												else
												{
													playAvgDialogue = actionPlayAvgDialogue;
												}
											}
											else
											{
												changeStateObject = actionChangeStateObject;
											}
										}
										else
										{
											playNpcAvgDialogue = actionPlayNpcAvgDialogue;
										}
									}
									else
									{
										enterBackRoom = actionEnterBackRoom;
									}
								}
								else
								{
									setNpcAnimatorByName = actionSetNpcAnimatorByName;
								}
							}
							else
							{
								setNpcAnimator = actionSetNpcAnimator;
							}
						}
						else
						{
							teleport = actionTeleport;
						}
					}
					else
					{
						openPropsItemView = actionOpenPropsItemView;
					}
				}
				else
				{
					openUI = actionOpenUI;
				}
			}
			else
			{
				openRaidView = actionOpenRaidView;
			}
		}
		else
		{
			openReadableView = actionOpenReadableView;
		}
		activeActionIndex = action.ActionId;
		return true;
	}

	public IEnumerable<NpcInteractAction> GetActions()
	{
		NpcInteractAction activeAction = GetActiveAction();
		if (activeAction != null)
		{
			yield return activeAction;
		}
	}

	private NpcInteractAction GetActiveAction()
	{
		NpcInteractAction actionByIndex = GetActionByIndex(activeActionIndex);
		if (actionByIndex != null)
		{
			return actionByIndex;
		}
		int[] all = NpcInteractActionIds.All;
		foreach (int actionIndex in all)
		{
			actionByIndex = GetActionByIndex(actionIndex);
			if (actionByIndex != null)
			{
				activeActionIndex = actionIndex;
				return actionByIndex;
			}
		}
		return null;
	}

	private NpcInteractAction GetActionByIndex(int actionIndex)
	{
		if (actionIndex == NpcInteractActionIds.OpenUI)
		{
			return openUI;
		}
		if (actionIndex == NpcInteractActionIds.OpenRaidView)
		{
			return openRaidView;
		}
		if (actionIndex == NpcInteractActionIds.OpenReadableView)
		{
			return openReadableView;
		}
		if (actionIndex == NpcInteractActionIds.OpenPropsItemView)
		{
			return openPropsItemView;
		}
		if (actionIndex == NpcInteractActionIds.Teleport)
		{
			return teleport;
		}
		if (actionIndex == NpcInteractActionIds.SetNpcAnimator)
		{
			return setNpcAnimator;
		}
		if (actionIndex == NpcInteractActionIds.SetNpcAnimatorByName)
		{
			return setNpcAnimatorByName;
		}
		if (actionIndex == NpcInteractActionIds.EnterBackRoom)
		{
			return enterBackRoom;
		}
		if (actionIndex == NpcInteractActionIds.PlayNpcAvgDialogue)
		{
			return playNpcAvgDialogue;
		}
		if (actionIndex == NpcInteractActionIds.ChangeStateObject)
		{
			return changeStateObject;
		}
		if (actionIndex == NpcInteractActionIds.PlayAvgDialogue)
		{
			return playAvgDialogue;
		}
		if (actionIndex == NpcInteractActionIds.ReceiveMission)
		{
			return receiveMission;
		}
		if (actionIndex == NpcInteractActionIds.PlayTimeline)
		{
			return playTimeline;
		}
		if (actionIndex == NpcInteractActionIds.LoadVirtualNpc)
		{
			return loadVirtualNpc;
		}
		if (actionIndex == NpcInteractActionIds.SetKeyPoint)
		{
			return setKeyPoint;
		}
		if (actionIndex == NpcInteractActionIds.OpenMiniGame)
		{
			return openMiniGame;
		}
		return null;
	}

	private NpcInteractAction GetActionByType(Type actionType)
	{
		if (actionType == typeof(ActionOpenReadableView))
		{
			return openReadableView;
		}
		if (actionType == typeof(ActionOpenRaidView))
		{
			return openRaidView;
		}
		if (actionType == typeof(ActionOpenUI))
		{
			return openUI;
		}
		if (actionType == typeof(ActionOpenPropsItemView))
		{
			return openPropsItemView;
		}
		if (actionType == typeof(ActionTeleport))
		{
			return teleport;
		}
		if (actionType == typeof(ActionSetNpcAnimator))
		{
			return setNpcAnimator;
		}
		if (actionType == typeof(ActionSetNpcAnimatorByName))
		{
			return setNpcAnimatorByName;
		}
		if (actionType == typeof(ActionEnterBackRoom))
		{
			return enterBackRoom;
		}
		if (actionType == typeof(ActionPlayNpcAvgDialogue))
		{
			return playNpcAvgDialogue;
		}
		if (actionType == typeof(ActionChangeStateObject))
		{
			return changeStateObject;
		}
		if (actionType == typeof(ActionPlayAvgDialogue))
		{
			return playAvgDialogue;
		}
		if (actionType == typeof(ActionReceiveMission))
		{
			return receiveMission;
		}
		if (actionType == typeof(ActionPlayTimeline))
		{
			return playTimeline;
		}
		if (actionType == typeof(ActionLoadVirtualNpc))
		{
			return loadVirtualNpc;
		}
		if (actionType == typeof(ActionSetKeyPoint))
		{
			return setKeyPoint;
		}
		if (actionType == typeof(ActionOpenMiniGame))
		{
			return openMiniGame;
		}
		return null;
	}
}
