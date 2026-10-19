namespace System.ComponentModel;

public interface ITypeDescriptorContext : IServiceProvider
{
	IContainer Container { get; }
}
