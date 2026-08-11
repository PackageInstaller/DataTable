namespace GameFramework.Runtime;

public class BindingServiceBundle : AbstractServiceBundle
{
	public BindingServiceBundle(IServiceContainer container)
		: base(container)
	{
	}

	protected override void OnStart(IServiceContainer container)
	{
		PathParser target = new PathParser();
		ExpressionPathFinder expressionPathFinder = new ExpressionPathFinder();
		ConverterRegistry target2 = new ConverterRegistry();
		ObjectSourceProxyFactory objectSourceProxyFactory = new ObjectSourceProxyFactory();
		objectSourceProxyFactory.Register(new UniversalNodeProxyFactory(), 0);
		SourceProxyFactory sourceProxyFactory = new SourceProxyFactory();
		sourceProxyFactory.Register(new LiteralSourceProxyFactory(), 0);
		sourceProxyFactory.Register(new ExpressionSourceProxyFactory(sourceProxyFactory, expressionPathFinder), 1);
		sourceProxyFactory.Register(objectSourceProxyFactory, 2);
		TargetProxyFactory targetProxyFactory = new TargetProxyFactory();
		targetProxyFactory.Register(new UniversalTargetProxyFactory(), 0);
		targetProxyFactory.Register(new UnityTargetProxyFactory(), 10);
		targetProxyFactory.Register(new VisualElementProxyFactory(), 30);
		BindingFactory bindingFactory = new BindingFactory(sourceProxyFactory, targetProxyFactory);
		StandardBinder target3 = new StandardBinder(bindingFactory);
		container.Register((IBinder)target3);
		container.Register((IBindingFactory)bindingFactory);
		container.Register((IConverterRegistry)target2);
		container.Register((IExpressionPathFinder)expressionPathFinder);
		container.Register((IPathParser)target);
		container.Register((INodeProxyFactory)objectSourceProxyFactory);
		container.Register((INodeProxyFactoryRegister)objectSourceProxyFactory);
		container.Register((ISourceProxyFactory)sourceProxyFactory);
		container.Register((ISourceProxyFactoryRegistry)sourceProxyFactory);
		container.Register((ITargetProxyFactory)targetProxyFactory);
		container.Register((ITargetProxyFactoryRegister)targetProxyFactory);
	}

	protected override void OnStop(IServiceContainer container)
	{
		container.Unregister<IBinder>();
		container.Unregister<IBindingFactory>();
		container.Unregister<IConverterRegistry>();
		container.Unregister<IExpressionPathFinder>();
		container.Unregister<IPathParser>();
		container.Unregister<INodeProxyFactory>();
		container.Unregister<INodeProxyFactoryRegister>();
		container.Unregister<ISourceProxyFactory>();
		container.Unregister<ISourceProxyFactoryRegistry>();
		container.Unregister<ITargetProxyFactory>();
		container.Unregister<ITargetProxyFactoryRegister>();
	}
}
