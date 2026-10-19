using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

public class SystemApc : EntitySystem
{
	private const int InitialApcCapacity = 256;

	private readonly HashSet<Entity> _apcEntities = new HashSet<Entity>(256);

	private Filter _filter;

	private EntityAction _collectApcAction;

	public ICollection<Entity> Apcs => _apcEntities;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompAssistNpc>().Build();
		_collectApcAction = CollectApc;
	}

	public override void Update()
	{
		_apcEntities.Clear();
		_filter.ForEach(_collectApcAction);
	}

	private void CollectApc(Entity entity)
	{
		_apcEntities.Add(entity);
	}
}
