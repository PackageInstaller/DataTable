using System;
using GameFramework.Runtime.Proxy;
using UnityEngine;
using UnityEngine.EventSystems;

namespace GameFramework.Runtime;

public abstract class TargetProxyBase : BindingProxyBase, ITargetProxy, IBindingProxy, IDisposable
{
	private readonly WeakReference target;

	protected TypeCode typeCode = TypeCode.Empty;

	protected readonly string targetName;

	public abstract Type Type { get; }

	public virtual TypeCode TypeCode
	{
		get
		{
			if (typeCode == TypeCode.Empty)
			{
				typeCode = Type.GetTypeCode(Type);
			}
			return typeCode;
		}
	}

	public virtual object Target
	{
		get
		{
			object obj = ((target != null) ? target.Target : null);
			return IsAlive(obj) ? obj : null;
		}
	}

	public virtual BindingMode DefaultMode => BindingMode.OneWay;

	public TargetProxyBase(object target)
	{
		if (target != null)
		{
			this.target = new WeakReference(target, trackResurrection: false);
			targetName = target.ToString();
		}
	}

	private bool IsAlive(object target)
	{
		try
		{
			if (target is UIBehaviour)
			{
				if (((UIBehaviour)target).IsDestroyed())
				{
					return false;
				}
				return true;
			}
			if (target is UnityEngine.Object)
			{
				string name = ((UnityEngine.Object)target).name;
				return true;
			}
			return target != null;
		}
		catch (Exception)
		{
			return false;
		}
	}
}
