using System;

namespace GameFramework.Runtime;

public interface IObservableProperty
{
	Type Type { get; }

	object Value { get; set; }

	event EventHandler ValueChanged;
}
public interface IObservableProperty<T> : IObservableProperty
{
	new T Value { get; set; }
}
