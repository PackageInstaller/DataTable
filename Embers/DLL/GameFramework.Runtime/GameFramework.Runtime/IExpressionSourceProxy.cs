using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public interface IExpressionSourceProxy : ISourceProxy, IBindingProxy, IDisposable, IObtainable, INotifiable
{
}
