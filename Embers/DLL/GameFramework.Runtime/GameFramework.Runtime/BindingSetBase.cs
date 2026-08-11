#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public abstract class BindingSetBase : IBindingBuilder
{
	protected IBindingContext context;

	protected readonly List<IBindingBuilder> builders = new List<IBindingBuilder>();

	public BindingSetBase(IBindingContext context)
	{
		this.context = context;
	}

	public virtual void Build()
	{
		foreach (IBindingBuilder builder in builders)
		{
			try
			{
				builder.Build();
			}
			catch (Exception arg)
			{
				Log.Error("{0}", arg);
			}
		}
		builders.Clear();
	}
}
