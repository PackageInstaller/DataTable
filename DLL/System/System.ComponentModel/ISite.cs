namespace System.ComponentModel;

public interface ISite : IServiceProvider
{
	IContainer Container { get; }

	bool DesignMode { get; }

	string Name { get; }
}
