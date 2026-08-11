namespace Ase;

public class TriggerAreaGroup : BaseMapDataNodeGroup<TriggerAreaNode>
{
	public override void OnInited(object data = null)
	{
	}

	public override void OnStarted(object data = null)
	{
	}

	public override void OnDispose()
	{
		foreach (TriggerAreaNode node in nodeList)
		{
			node.OnDispose();
		}
	}
}
