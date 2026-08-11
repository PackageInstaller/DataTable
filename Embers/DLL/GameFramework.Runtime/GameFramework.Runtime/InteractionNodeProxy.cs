#define ENABLE_DEBUG_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Reflection;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class InteractionNodeProxy : SourceProxyBase, IModifiable
{
	private readonly IInteractionRequest request;

	private bool disposed = false;

	protected IProxyInvoker invoker;

	protected Delegate handler;

	protected IScriptInvoker scriptInvoker;

	public override Type Type => typeof(EventHandler<InteractionEventArgs>);

	public InteractionNodeProxy(IInteractionRequest request)
		: this(null, request)
	{
	}

	public InteractionNodeProxy(object source, IInteractionRequest request)
		: base(source)
	{
		this.request = request;
		BindEvent();
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		SetValue((object)value);
	}

	public virtual void SetValue(object value)
	{
		if (value != null && !(value is IProxyInvoker) && !(value is Delegate) && !(value is IScriptInvoker))
		{
			throw new ArgumentException("Binding object to InteractionRequest failed, unsupported object type", "value");
		}
		if (invoker != null)
		{
			invoker = null;
		}
		if ((object)handler != null)
		{
			handler = null;
		}
		if (this.scriptInvoker != null)
		{
			this.scriptInvoker = null;
		}
		if (value == null)
		{
			return;
		}
		if (value is IProxyInvoker proxyInvoker)
		{
			if (!IsValid(proxyInvoker))
			{
				throw new ArgumentException("Binding the IProxyInvoker to InteractionRequest failed, mismatched parameter type.");
			}
			invoker = proxyInvoker;
		}
		else if (value is Delegate obj)
		{
			if (!IsValid(obj))
			{
				throw new ArgumentException("Binding the Delegate to InteractionRequest failed, mismatched parameter type.");
			}
			handler = obj;
		}
		else if (value is IScriptInvoker scriptInvoker)
		{
			this.scriptInvoker = scriptInvoker;
		}
	}

	protected virtual bool IsValid(Delegate handler)
	{
		if (handler is EventHandler<InteractionEventArgs>)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 2)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(typeof(object)) && parameterTypes[1].IsAssignableFrom(typeof(InteractionEventArgs));
	}

	protected virtual bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 2)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(typeof(object)) && parameters[1].ParameterType.IsAssignableFrom(typeof(InteractionEventArgs));
	}

	protected virtual void BindEvent()
	{
		if (request != null)
		{
			request.Raised += OnRaised;
		}
	}

	protected virtual void UnbindEvent()
	{
		if (request != null)
		{
			request.Raised -= OnRaised;
		}
	}

	protected virtual void OnRaised(object sender, InteractionEventArgs args)
	{
		try
		{
			if (invoker != null)
			{
				invoker.Invoke(sender, args);
			}
			else if ((object)handler != null)
			{
				if (handler is EventHandler<InteractionEventArgs>)
				{
					(handler as EventHandler<InteractionEventArgs>)(sender, args);
					return;
				}
				handler.DynamicInvoke(sender, args);
			}
			else if (scriptInvoker != null)
			{
				scriptInvoker.Invoke(sender, args);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			UnbindEvent();
			handler = null;
			scriptInvoker = null;
			invoker = null;
			disposed = true;
			base.Dispose(disposing);
		}
	}
}
