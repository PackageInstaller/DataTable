using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class ActorGrid
{
	public Cellinfo currCell;

	private FP curTime;

	public void Enter(Cellinfo cell, AdventureActor actor)
	{
		bool flag = false;
		if (currCell == null)
		{
			flag = true;
			currCell = cell;
			currCell.OnEnter(actor, flag);
		}
		else if (currCell.cellIndex != cell.cellIndex)
		{
			flag = currCell.gridColor != cell.gridColor;
			currCell.OnExit(actor, flag);
			currCell = cell;
			currCell.OnEnter(actor, flag);
		}
		PlayerAdventureActor playerAdventureActor = actor as PlayerAdventureActor;
		if (playerAdventureActor != null && !playerAdventureActor.isResident)
		{
			return;
		}
		bool flag2 = playerAdventureActor != null && !playerAdventureActor.isAssist;
		if (currCell.gridColor != 0L)
		{
			if (flag)
			{
				curTime = actor.LogicTime;
				int buffID = ((currCell.gridColor == 1) ? ConfigProvide.Inst.buffId_red : ConfigProvide.Inst.buffId_green);
				int buffID2 = ((currCell.gridColor == 1) ? Config.buffId_red_icon : Config.buffId_green_icon);
				int num = (flag2 ? 1 : ConfigProvide.Inst.buffMaxCount);
				actor.buffComponent.AddBuffNum(buffID, num, actor);
				actor.buffComponent.AddBuffNum(buffID2, 1, actor);
			}
			else if (actor.LogicTime - curTime >= ConfigProvide.Inst.interval)
			{
				curTime = actor.LogicTime;
				int buffID3 = ((currCell.gridColor == 1) ? ConfigProvide.Inst.buffId_red : ConfigProvide.Inst.buffId_green);
				int buffID4 = ((currCell.gridColor == 1) ? Config.buffId_red_icon : Config.buffId_green_icon);
				int num2 = (flag2 ? 1 : ConfigProvide.Inst.buffMaxCount);
				actor.buffComponent.AddBuffNum(buffID3, num2, actor);
				actor.buffComponent.AddBuffNum(buffID4, 1, actor);
			}
		}
	}
}
