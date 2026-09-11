using System;
using Entitas;

public class ProjectileSystem : IExecuteSystem, ISystem, IInitializeSystem
{
	private Contexts mContexts;

	public ProjectileSystem(Contexts context)
	{
		mContexts = context;
	}

	public void Execute()
	{
		throw new NotImplementedException();
	}

	public void Initialize()
	{
		throw new NotImplementedException();
	}
}
