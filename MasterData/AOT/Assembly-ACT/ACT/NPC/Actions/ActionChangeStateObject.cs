using System;
using ACT.Battle;
using Cysharp.Threading.Tasks;

namespace ACT.NPC.Actions;

[Serializable]
public class ActionChangeStateObject : NpcInteractAction
{
	public int swid;

	public int newState;

	public override int ActionId => NpcInteractActionIds.ChangeStateObject;

	protected override UniTask DoAction()
	{
		MonoECS.instance.ruleManager.SharedChangeState(swid, newState);
		return base.DoAction();
	}
}
