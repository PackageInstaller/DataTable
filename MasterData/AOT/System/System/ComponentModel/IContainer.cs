namespace System.ComponentModel;

public interface IContainer : IDisposable
{
	ComponentCollection Components { get; }

	void Remove(IComponent component);
}
