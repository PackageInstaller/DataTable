using System;

namespace GameFramework.Runtime;

public interface IBinding : IDisposable
{
	IBindingContext BindingContext { get; set; }

	object Target { get; }

	object DataContext { get; set; }
}
