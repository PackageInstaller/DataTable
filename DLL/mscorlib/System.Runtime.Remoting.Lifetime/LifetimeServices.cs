using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Lifetime;

[ComVisible(true)]
public sealed class LifetimeServices
{
	private static TimeSpan _leaseManagerPollTime;

	private static TimeSpan _leaseTime;

	private static TimeSpan _renewOnCallTime;

	private static TimeSpan _sponsorshipTimeout;

	private static LeaseManager _leaseManager;

	public static TimeSpan LeaseManagerPollTime
	{
		get
		{
			return _leaseManagerPollTime;
		}
		set
		{
			_leaseManagerPollTime = value;
			_leaseManager.SetPollTime(value);
		}
	}

	public static TimeSpan LeaseTime
	{
		get
		{
			return _leaseTime;
		}
		set
		{
			_leaseTime = value;
		}
	}

	public static TimeSpan RenewOnCallTime
	{
		get
		{
			return _renewOnCallTime;
		}
		set
		{
			_renewOnCallTime = value;
		}
	}

	public static TimeSpan SponsorshipTimeout
	{
		get
		{
			return _sponsorshipTimeout;
		}
		set
		{
			_sponsorshipTimeout = value;
		}
	}

	static LifetimeServices()
	{
		_leaseManager = new LeaseManager();
		_leaseManagerPollTime = TimeSpan.FromSeconds(10.0);
		_leaseTime = TimeSpan.FromMinutes(5.0);
		_renewOnCallTime = TimeSpan.FromMinutes(2.0);
		_sponsorshipTimeout = TimeSpan.FromMinutes(2.0);
	}

	internal static void TrackLifetime(ServerIdentity identity)
	{
		_leaseManager.TrackLifetime(identity);
	}
}
