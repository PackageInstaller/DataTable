using System.Collections.Generic;

public class QWAgentManager
{
	public static QWAgentManager Instance;

	private List<QWAgent> _agents = new List<QWAgent>();

	public void Init()
	{
		Instance = this;
	}

	public void Dispose()
	{
		Instance = null;
		_agents.Clear();
	}

	public void Register(QWAgent agent)
	{
		_agents.Add(agent);
	}

	public void UnRegister(QWAgent agent)
	{
		_agents.Remove(agent);
	}

	public void Tick()
	{
		QWorldCameraManager.Instance.RefreshMainCamera();
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			_agents[num].UpdateAgent();
		}
	}

	public void LateTick()
	{
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			_agents[num].LateUpdateAgent();
		}
	}

	public void FixedTick()
	{
		for (int num = _agents.Count - 1; num >= 0; num--)
		{
			_agents[num].FixedUpdateAgent();
		}
	}
}
