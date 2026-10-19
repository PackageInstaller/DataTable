namespace ACT.NPC.Actions;

public static class NpcInteractActionIds
{
	public static readonly int OpenUI = 1;

	public static readonly int OpenPropsItemView = 2;

	public static readonly int Teleport = 3;

	public static readonly int SetNpcAnimator = 4;

	public static readonly int SetNpcAnimatorByName = 5;

	public static readonly int EnterBackRoom = 6;

	public static readonly int PlayNpcAvgDialogue = 7;

	public static readonly int ChangeStateObject = 8;

	public static readonly int PlayAvgDialogue = 9;

	public static readonly int ReceiveMission = 10;

	public static readonly int PlayTimeline = 11;

	public static readonly int LoadVirtualNpc = 12;

	public static readonly int OpenRaidView = 13;

	public static readonly int OpenReadableView = 14;

	public static readonly int SetKeyPoint = 15;

	public static readonly int OpenMiniGame = 16;

	public static readonly int[] All = new int[16]
	{
		OpenUI, OpenPropsItemView, Teleport, SetNpcAnimator, SetNpcAnimatorByName, EnterBackRoom, PlayNpcAvgDialogue, ChangeStateObject, PlayAvgDialogue, ReceiveMission,
		PlayTimeline, LoadVirtualNpc, OpenRaidView, OpenReadableView, SetKeyPoint, OpenMiniGame
	};
}
