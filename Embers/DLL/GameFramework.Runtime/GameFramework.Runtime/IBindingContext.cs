using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public interface IBindingContext : IDisposable
{
	object Owner { get; }

	object DataContext { get; set; }

	event EventHandler DataContextChanged;

	void Add(IBinding binding, object key = null);

	void Add(IEnumerable<IBinding> bindings, object key = null);

	void Add(object target, BindingDescription description, object key = null);

	void Add(object target, IEnumerable<BindingDescription> descriptions, object key = null);

	void Clear(object key);

	void Clear();
}
