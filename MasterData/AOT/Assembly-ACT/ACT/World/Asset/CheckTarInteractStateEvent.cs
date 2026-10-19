using ACT.Battle;
using ACT.World.Behave;
using ACT.World.StateObject;

namespace ACT.World.Asset;

public class CheckTarInteractStateEvent : EventActionBase
{
	public StateWorldUid tarSwid = int.MinValue;

	public int conditionState;

	private StateObjectBase m_TarInteract;

	public override void Enter(BehaveControlBaseBehaveEvent behave)
	{
		base.Enter(behave);
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(tarSwid, out var asset);
		if (asset != null)
		{
			m_TarInteract = asset.stateObjectBase;
		}
	}

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		if (m_TarInteract == null)
		{
			return true;
		}
		if (m_TarInteract.currentStateId == conditionState)
		{
			return true;
		}
		behave.StopMove();
		return false;
	}
}
