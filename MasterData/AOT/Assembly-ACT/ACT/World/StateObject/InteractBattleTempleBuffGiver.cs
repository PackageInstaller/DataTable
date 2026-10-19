using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractBattleTempleBuffGiver")]
public class InteractBattleTempleBuffGiver : InteractObject
{
	private const int DisplayState = 0;

	private const int BattleState = -4;

	private const int SelectingBuffState = 1;

	private const int CompletedState = 2;

	private static readonly int State = Animator.StringToHash("state");

	private Animator _animator;

	private BattleTempleBuffGiveData _data;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BattleTempleBuffGiveData data)
		{
			_data = data;
			_animator = GetComponentInChildren<Animator>();
			base.InitStateObject(stateId);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleTempleBuffSelectFinish, OnBuffSelectionClosed);
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (currentStateId == 0 && entryIndex == 0)
		{
			base.Interact(entryIndex, eb, interactSource);
		}
	}

	public override void ReleaseStateObject()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleTempleBuffSelectFinish, OnBuffSelectionClosed);
		base.ReleaseStateObject();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		base.HandleChangeState(fromStateId, toStateId);
		_animator?.SetInteger(State, toStateId);
		if (fromStateId == -4 && toStateId == 1)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEMPLEBUFFSELECT, new TempleBuffSelectViewData
			{
				swid = swid,
				templeRoomIndex = _data.belongRoomIndex,
				templeId = Model<TempleModel>.Interface.CurChallengeTempleId
			});
		}
	}

	private void OnBuffSelectionClosed(BaseEventContent content)
	{
		if (content is BattleTempleBuffSelectFinishEvt { swid: var num } && num == swid && currentStateId == 1)
		{
			NetEnterState(2).Forget();
		}
	}
}
