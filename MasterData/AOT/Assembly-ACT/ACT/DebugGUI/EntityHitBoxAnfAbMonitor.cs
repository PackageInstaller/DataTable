using System.Threading;
using Bamboo.ECS;

namespace ACT.DebugGUI;

public class EntityHitBoxAnfAbMonitor : SingleMonitor
{
	private CancellationTokenSource mTokenSource;

	private void OnAddEntity(Entity eb)
	{
		if (eb.IsBehaveEntity())
		{
			DebugWindowManager.DebugHitBox(eb);
		}
	}

	protected override bool OnInit()
	{
		mTokenSource = new CancellationTokenSource();
		GameManager.entities.OnEntityCreate += OnAddEntity;
		GameManager.entities.ForEachEntities((Entity eb) =>
		{
			DebugWindowManager.DebugHitBox(eb);
		});
		return true;
	}

	protected override void OnRemove()
	{
		mTokenSource.Cancel();
		mTokenSource.Dispose();
		GameManager.entities.OnEntityCreate -= OnAddEntity;
	}
}
