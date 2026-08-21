namespace Ase;

public class EventGroup : BaseMapDataNodeGroup<BaseEventTriggerNode>
{
	public override void OnInited(object data = null)
	{
	}

	public override void OnStarted(object data = null)
	{
	}

	public override void OnDispose()
	{
		for (int i = 0; i < nodeList.Count; i++)
		{
			nodeList[i].OnDispose();
		}
	}
}
