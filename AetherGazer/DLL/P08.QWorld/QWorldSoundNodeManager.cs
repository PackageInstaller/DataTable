using System.Collections.Generic;

public class QWorldSoundNodeManager
{
	private int uid;

	private List<BaseSoundNode> soundBaseList = new List<BaseSoundNode>();

	public void Update()
	{
		lock (soundBaseList)
		{
			for (int i = 0; i < soundBaseList.Count; i++)
			{
				soundBaseList[i].UpdateNode();
			}
		}
	}

	public bool Register(BaseSoundNode soundNode)
	{
		lock (soundBaseList)
		{
			if (GetIndex(soundNode) >= 0)
			{
				return false;
			}
			soundBaseList.Add(soundNode);
		}
		return true;
	}

	public bool UnRegister(BaseSoundNode soundNode)
	{
		lock (soundBaseList)
		{
			int index = GetIndex(soundNode);
			if (index < 0)
			{
				return false;
			}
			soundBaseList.RemoveAt(index);
		}
		return true;
	}

	private int GetIndex(BaseSoundNode soundNode)
	{
		for (int i = 0; i < soundBaseList.Count; i++)
		{
			if (soundBaseList[i].guid == soundNode.guid)
			{
				return i;
			}
		}
		return -1;
	}

	public void Dispose()
	{
	}
}
