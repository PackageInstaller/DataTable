using System;

namespace GameFramework.Runtime.Proxy;

public interface INotifiable
{
	event EventHandler ValueChanged;
}
