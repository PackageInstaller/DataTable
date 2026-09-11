using System.Collections;
using System.Threading;

namespace System.Runtime.Remoting.Lifetime;

internal class LeaseManager
{
	private ArrayList _objects = new ArrayList();

	private Timer _timer;

	public void SetPollTime(TimeSpan timeSpan)
	{
		lock (_objects.SyncRoot)
		{
			if (_timer != null)
			{
				_timer.Change(timeSpan, timeSpan);
			}
		}
	}

	public void TrackLifetime(ServerIdentity identity)
	{
		lock (_objects.SyncRoot)
		{
			identity.Lease.Activate();
			_objects.Add(identity);
			if (_timer == null)
			{
				StartManager();
			}
		}
	}

	public void StartManager()
	{
		_timer = new Timer(ManageLeases, null, LifetimeServices.LeaseManagerPollTime, LifetimeServices.LeaseManagerPollTime);
	}

	public void StopManager()
	{
		Timer timer = _timer;
		_timer = null;
		timer?.Dispose();
	}

	public void ManageLeases(object state)
	{
		lock (_objects.SyncRoot)
		{
			int num = 0;
			while (num < _objects.Count)
			{
				ServerIdentity serverIdentity = (ServerIdentity)_objects[num];
				serverIdentity.Lease.UpdateState();
				if (serverIdentity.Lease.CurrentState == LeaseState.Expired)
				{
					_objects.RemoveAt(num);
					serverIdentity.OnLifetimeExpired();
				}
				else
				{
					num++;
				}
			}
			if (_objects.Count == 0)
			{
				StopManager();
			}
		}
	}
}
