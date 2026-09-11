using System.Collections.Generic;

public class CustomCameraStack
{
	public LinkedList<QWCustomCamera> cameras;

	public HashSet<QWCustomCamera> cameraSet;

	public int Count => cameras.Count;

	public CustomCameraStack()
	{
		cameras = new LinkedList<QWCustomCamera>();
		cameraSet = new HashSet<QWCustomCamera>();
	}

	public void Push(QWCustomCamera cameraNode)
	{
		cameraSet.Add(cameraNode);
		cameras.AddLast(cameraNode.node);
	}

	public QWCustomCamera Pop()
	{
		if (cameras.Count > 0)
		{
			QWCustomCamera value = cameras.Last.Value;
			cameras.RemoveLast();
			cameraSet.Remove(value);
			return value;
		}
		return null;
	}

	public bool TryPeek(out QWCustomCamera ret)
	{
		if (cameras.Count > 0)
		{
			QWCustomCamera value = cameras.Last.Value;
			ret = value;
			return true;
		}
		ret = null;
		return false;
	}

	public bool RemoveRandom(QWCustomCamera camera, out bool isLast)
	{
		isLast = false;
		if (cameraSet.Contains(camera))
		{
			isLast = camera == cameras.Last.Value;
			cameraSet.Remove(camera);
			cameras.Remove(camera);
			return true;
		}
		return false;
	}

	public void Dispose()
	{
	}
}
