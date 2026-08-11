namespace GameFramework.Runtime;

public class BindingSet<TTarget, TSource> : BindingSetBase where TTarget : class
{
	private TTarget target;

	public BindingSet(IBindingContext context, TTarget target)
		: base(context)
	{
		this.target = target;
	}

	public virtual BindingBuilder<TTarget, TSource> Bind()
	{
		BindingBuilder<TTarget, TSource> bindingBuilder = new BindingBuilder<TTarget, TSource>(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}

	public virtual BindingBuilder<TChildTarget, TSource> Bind<TChildTarget>(TChildTarget target) where TChildTarget : class
	{
		BindingBuilder<TChildTarget, TSource> bindingBuilder = new BindingBuilder<TChildTarget, TSource>(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}
}
public class BindingSet<TTarget> : BindingSetBase where TTarget : class
{
	private TTarget target;

	public BindingSet(IBindingContext context, TTarget target)
		: base(context)
	{
		this.target = target;
	}

	public virtual BindingBuilder<TTarget> Bind()
	{
		BindingBuilder<TTarget> bindingBuilder = new BindingBuilder<TTarget>(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}

	public virtual BindingBuilder<TChildTarget> Bind<TChildTarget>(TChildTarget target) where TChildTarget : class
	{
		BindingBuilder<TChildTarget> bindingBuilder = new BindingBuilder<TChildTarget>(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}
}
public class BindingSet : BindingSetBase
{
	private object target;

	public BindingSet(IBindingContext context, object target)
		: base(context)
	{
		this.target = target;
	}

	public virtual BindingBuilder Bind()
	{
		BindingBuilder bindingBuilder = new BindingBuilder(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}

	public virtual BindingBuilder Bind(object target)
	{
		BindingBuilder bindingBuilder = new BindingBuilder(context, target);
		builders.Add(bindingBuilder);
		return bindingBuilder;
	}
}
