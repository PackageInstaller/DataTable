using System;
using System.Reflection;
using System.Threading;
using UnityEngine.Events;

namespace GameFramework.Runtime;

public abstract class UnityEventProxyBase<T> : EventTargetProxyBase where T : UnityEventBase
{
	private bool disposed = false;

	protected ICommand command;

	protected IInvoker invoker;

	protected Delegate handler;

	protected IProxyPropertyInfo interactable;

	protected SendOrPostCallback updateInteractableAction;

	protected T unityEvent;

	public override BindingMode DefaultMode => BindingMode.OneWay;

	public UnityEventProxyBase(object target, T unityEvent)
		: base(target)
	{
		if (unityEvent == null)
		{
			throw new ArgumentNullException("unityEvent");
		}
		this.unityEvent = unityEvent;
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

	protected abstract void BindEvent();

	protected abstract void UnbindEvent();

	protected abstract bool IsValid(Delegate handler);

	protected abstract bool IsValid(IProxyInvoker invoker);

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
			if (interactable == null)
			{
				PropertyInfo property = obj.GetType().GetProperty("interactable");
				if (property != null)
				{
					interactable = property.AsProxy();
				}
			}
			this.command = command;
			BindCommand(this.command);
			UpdateTargetInteractable();
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
		if (updateInteractableAction == null)
		{
			updateInteractableAction = UpdateTargetInteractable;
		}
		UISynchronizationContext.Post(updateInteractableAction, null);
	}

	protected virtual void UpdateTargetInteractable(object state = null)
	{
		object obj = Target;
		if (interactable != null && obj != null)
		{
			bool flag = command != null && command.CanExecute(null);
			if (interactable is IProxyPropertyInfo<bool>)
			{
				(interactable as IProxyPropertyInfo<bool>).SetValue(obj, flag);
			}
			else
			{
				interactable.SetValue(obj, flag);
			}
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
