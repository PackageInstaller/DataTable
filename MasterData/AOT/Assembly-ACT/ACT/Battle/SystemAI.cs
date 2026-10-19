using Bamboo.ECS;

namespace ACT.Battle;

public class SystemAI : EntitySystem
{
	public const int TickDivisor = 2;

	private int _tickRemainder;

	private int _updateIndex;

	private Filter _filter;

	private EntityAction<CompAI> _fixedUpdateEntityAction;

	private EntityAction<CompAI> _broadcastEventAction;

	private EntityAction<CompAI> _toggleAllAction;

	private string _broadcastEventMessage;

	private bool _toggleRun;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompAI>().Build();
		_fixedUpdateEntityAction = FixedUpdateEntity;
		_broadcastEventAction = BroadcastEventEntity;
		_toggleAllAction = ToggleEntity;
	}

	public override void FixedUpdate()
	{
		_updateIndex = 0;
		_filter.ForEach(_fixedUpdateEntityAction);
		_tickRemainder = (_tickRemainder + 1) % 2;
	}

	private void FixedUpdateEntity(Entity entity, CompAI compAI)
	{
		if (entity.TryGetCompBehave(out CompBehave component) && component.IsTickAvailable() && (component.TickLod == EntityTickLod.Quarter || ++_updateIndex % 2 == _tickRemainder) && !entity.IsOnRemove() && !entity.IsToRemove())
		{
			ActBehaviorTree actBehaviorTree = compAI.ActBehaviorTree;
			if ((object)actBehaviorTree != null && actBehaviorTree.running)
			{
				actBehaviorTree.Tick();
			}
		}
	}

	public void BoardCastEvent(string msg)
	{
		_broadcastEventMessage = msg;
		_filter.ForEach(_broadcastEventAction);
		_broadcastEventMessage = null;
	}

	private void BroadcastEventEntity(Entity entity, CompAI compAI)
	{
		entity.WakeTick();
		ActBehaviorTree actBehaviorTree = compAI.ActBehaviorTree;
		if ((object)actBehaviorTree != null && actBehaviorTree.running && entity.IsTickAvailable())
		{
			actBehaviorTree.SendEvent(_broadcastEventMessage);
		}
	}

	public void ToggleAll(bool run)
	{
		_toggleRun = run;
		_filter.ForEach(_toggleAllAction);
	}

	private void ToggleEntity(Entity entity, CompAI compAI)
	{
		if (!(compAI.ActBehaviorTree == null))
		{
			compAI.ActBehaviorTree.running = _toggleRun;
		}
	}
}
