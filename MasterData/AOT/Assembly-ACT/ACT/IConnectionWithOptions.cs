using System.Collections.Generic;

namespace ACT;

public interface IConnectionWithOptions : IConnection<int>, IConnection
{
	bool HasOptions();

	int GetOptionCount();

	void RefreshOptions();
}
public interface IConnectionWithOptions<TOption> : IConnectionWithOptions, IConnection<int>, IConnection
{
	List<TOption> GetOptionLabels();
}
