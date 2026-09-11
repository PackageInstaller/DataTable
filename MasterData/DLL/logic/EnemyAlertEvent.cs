public class EnemyAlertEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public int enemyEntityID;

	public EnemyAlertState state;

	public int playerEntityID;

	public override void OnEnterPool()
	{
		state = EnemyAlertState.None;
		enemyEntityID = 0;
		playerEntityID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EnemyAlertEvent>.Release(this);
	}

	public static EnemyAlertEvent Claim(int enemyEntityID, int playerEntityID, EnemyAlertState state)
	{
		EnemyAlertEvent enemyAlertEvent = FrameObjectPool<EnemyAlertEvent>.Claim();
		enemyAlertEvent.enemyEntityID = enemyEntityID;
		enemyAlertEvent.playerEntityID = playerEntityID;
		enemyAlertEvent.state = state;
		return enemyAlertEvent;
	}
}
