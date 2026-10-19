using System.Collections.Generic;

namespace ACT;

public abstract class BaseConnectionWithOptions<TOption> : BaseConnection<int>, IConnectionWithOptions<TOption>, IConnectionWithOptions, IConnection<int>, IConnection
{
	protected BaseConnectionWithOptions(ConnectionSO<int> connectionSO, ISettingWithValue<int> setting)
		: base(connectionSO, setting)
	{
	}

	public virtual int GetOptionCount()
	{
		return GetOptionLabels().Count;
	}

	public abstract bool HasOptions();

	public abstract List<TOption> GetOptionLabels();

	public abstract void RefreshOptions();
}
