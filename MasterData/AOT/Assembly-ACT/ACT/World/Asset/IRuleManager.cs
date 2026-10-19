using System;
using ACT.Event;
using ACT.Game;

namespace ACT.World.Asset;

public interface IRuleManager
{
	void AddEventListener(ClientEvent eventId, int swid, StateWorldHandler handle);

	void RemoveEventListener(ClientEvent eventId, int swid, StateWorldHandler handle);

	InteractRuleResult LocalEventDispatch(ClientEvent eventId, LocalStateWorldEvent o);

	int SharedGetState(int stateWorldUid);

	void SharedChangeState(int stateWorldUid, int stateId);

	void SharedChangeStates(StateChangeInfo[] stateChangeInfos, Action<bool> callback);

	bool TryGetWorldStateAsset(int stateWorldUid, out StateWorldAsset asset);
}
