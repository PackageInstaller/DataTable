#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Reflection;
using System.Threading;
using UnityEngine.UIElements;

namespace GameFramework.Runtime;

public class ClickableEventProxy : EventTargetProxyBase
{
	private bool disposed = false;

	protected ICommand command;

	protected IInvoker invoker;

	protected Delegate handler;

	protected readonly Clickable clickable;

	protected SendOrPostCallback updateTargetEnableAction;

	public override BindingMode DefaultMode => BindingMode.OneWay;

	public override Type Type => typeof(Clickable);

	public ClickableEventProxy(object target, Clickable clickable)
		: base(target)
	{
		this.clickable = clickable;
		BindEvent();
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			UnbindCommand(command);
			UnbindEvent();
			disposed = true;
			base.Dispose(disposing);
		}
	}

	protected virtual void BindEvent()
	{
		clickable.clicked += OnEvent;
	}

	protected virtual void UnbindEvent()
	{
		clickable.clicked -= OnEvent;
	}

	protected virtual bool IsValid(Delegate handler)
	{
		if (handler is Action)
		{
			return true;
		}
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count == 0)
		{
			return true;
		}
		return false;
	}

	protected virtual bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters != null && parameters.Length != 0)
		{
			return false;
		}
		return true;
	}

	protected virtual void OnEvent()
	{
		try
		{
			if (command != null)
			{
				command.Execute(null);
			}
			else if (invoker != null)
			{
				invoker.Invoke();
			}
			else if ((object)handler != null)
			{
				if (handler is Action)
				{
					(handler as Action)();
				}
				else
				{
					handler.DynamicInvoke();
				}
			}
		}
		catch (Exception arg)
		{
			Log.Error("{0}", arg);
		}
	}

	public override void SetValue(object value)
	{
		object obj = Target;
		if (obj == null)
		{
			return;
		}
		if (this.command != null)
		{
			UnbindCommand(this.command);
			this.command = null;
		}
		if (this.invoker != null)
		{
			this.invoker = null;
		}
		if ((object)handler != null)
		{
			handler = null;
		}
		if (value == null)
		{
			return;
		}
		if (value is ICommand command)
		{
			this.command = command;
			BindCommand(this.command);
			UpdateTargetEnable();
		}
		else if (value is IProxyInvoker proxyInvoker)
		{
			if (!IsValid(proxyInvoker))
			{
				throw new ArgumentException("Bind method failed.the parameter types do not match.");
			}
			this.invoker = proxyInvoker;
		}
		else if (value is Delegate obj2)
		{
			if (!IsValid(obj2))
			{
				throw new ArgumentException("Bind method failed.the parameter types do not match.");
			}
			handler = obj2;
		}
		else if (value is IInvoker invoker)
		{
			this.invoker = invoker;
		}
	}

	public override void SetValue<TValue>(TValue value)
	{
		SetValue((object)value);
	}

	protected virtual void OnCanExecuteChanged(object sender, EventArgs e)
	{
		if (updateTargetEnableAction == null)
		{
			updateTargetEnableAction = UpdateTargetEnable;
		}
		UISynchronizationContext.Post(updateTargetEnableAction, null);
	}

	protected virtual void UpdateTargetEnable(object state = null)
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		object obj = Target;
		if (obj != null && obj is VisualElement)
		{
			bool enabled = command != null && command.CanExecute(null);
			((VisualElement)obj).SetEnabled(enabled);
		}
	}

	protected virtual void BindCommand(ICommand command)
	{
		if (command != null)
		{
			command.CanExecuteChanged += OnCanExecuteChanged;
		}
	}

	protected virtual void UnbindCommand(ICommand command)
	{
		if (command != null)
		{
			command.CanExecuteChanged -= OnCanExecuteChanged;
		}
	}
}
