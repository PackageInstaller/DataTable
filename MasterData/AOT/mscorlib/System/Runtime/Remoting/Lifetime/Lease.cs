using System.Collections;
using System.Threading;

namespace System.Runtime.Remoting.Lifetime;

internal class Lease : MarshalByRefObject, ILease
{
	private delegate TimeSpan RenewalDelegate(ILease lease);

	private DateTime _leaseExpireTime;

	private LeaseState _currentState;

	private TimeSpan _initialLeaseTime;

	private TimeSpan _renewOnCallTime;

	private TimeSpan _sponsorshipTimeout;

	private ArrayList _sponsors;

	private Queue _renewingSponsors;

	private RenewalDelegate _renewalDelegate;

	public TimeSpan CurrentLeaseTime => _leaseExpireTime - DateTime.UtcNow;

	public LeaseState CurrentState => _currentState;

	public TimeSpan RenewOnCallTime => _renewOnCallTime;

	public Lease()
	{
		_currentState = LeaseState.Initial;
		_initialLeaseTime = LifetimeServices.LeaseTime;
		_renewOnCallTime = LifetimeServices.RenewOnCallTime;
		_sponsorshipTimeout = LifetimeServices.SponsorshipTimeout;
		_leaseExpireTime = DateTime.UtcNow + _initialLeaseTime;
	}

	public void Activate()
	{
		_currentState = LeaseState.Active;
	}

	public TimeSpan Renew(TimeSpan renewalTime)
	{
		DateTime dateTime = DateTime.UtcNow + renewalTime;
		if (dateTime > _leaseExpireTime)
		{
			_leaseExpireTime = dateTime;
		}
		return CurrentLeaseTime;
	}

	public void Unregister(ISponsor obj)
	{
		lock (this)
		{
			if (_sponsors == null)
			{
				return;
			}
			for (int i = 0; i < _sponsors.Count; i++)
			{
				if (_sponsors[i] == obj)
				{
					_sponsors.RemoveAt(i);
					break;
				}
			}
		}
	}

	internal void UpdateState()
	{
		if (_currentState != LeaseState.Active || CurrentLeaseTime > TimeSpan.Zero)
		{
			return;
		}
		if (_sponsors != null)
		{
			_currentState = LeaseState.Renewing;
			lock (this)
			{
				_renewingSponsors = new Queue(_sponsors);
			}
			CheckNextSponsor();
		}
		else
		{
			_currentState = LeaseState.Expired;
		}
	}

	private void CheckNextSponsor()
	{
		if (_renewingSponsors.Count == 0)
		{
			_currentState = LeaseState.Expired;
			_renewingSponsors = null;
			return;
		}
		ISponsor sponsor = (ISponsor)_renewingSponsors.Peek();
		_renewalDelegate = sponsor.Renewal;
		IAsyncResult asyncResult = _renewalDelegate.BeginInvoke(this, null, null);
		ThreadPool.RegisterWaitForSingleObject(asyncResult.AsyncWaitHandle, ProcessSponsorResponse, asyncResult, _sponsorshipTimeout, executeOnlyOnce: true);
	}

	private void ProcessSponsorResponse(object state, bool timedOut)
	{
		if (!timedOut)
		{
			try
			{
				IAsyncResult result = (IAsyncResult)state;
				TimeSpan timeSpan = _renewalDelegate.EndInvoke(result);
				if (timeSpan != TimeSpan.Zero)
				{
					Renew(timeSpan);
					_currentState = LeaseState.Active;
					_renewingSponsors = null;
					return;
				}
			}
			catch
			{
			}
		}
		Unregister((ISponsor)_renewingSponsors.Dequeue());
		CheckNextSponsor();
	}
}
