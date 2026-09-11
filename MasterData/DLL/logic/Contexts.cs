using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Entitas;
using Entitas.CodeGeneration.Attributes;

public class Contexts : IContexts
{
	private static Contexts _sharedInstance;

	public const string EntityID = "EntityID";

	public static Contexts sharedInstance
	{
		get
		{
			if (_sharedInstance == null)
			{
				_sharedInstance = new Contexts();
			}
			return _sharedInstance;
		}
		set
		{
			_sharedInstance = value;
		}
	}

	public SimContext sim { get; set; }

	public IContext[] allContexts => new IContext[1] { sim };

	public Contexts()
	{
		sim = new SimContext();
		IEnumerable<MethodInfo> enumerable = from method in GetType().GetMethods()
			where Attribute.IsDefined(method, typeof(PostConstructorAttribute))
			select method;
		foreach (MethodInfo item in enumerable)
		{
			item.Invoke(this, null);
		}
	}

	public void Reset()
	{
		IContext[] array = allContexts;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].Reset();
		}
	}

	[PostConstructor]
	public void InitializeEntityIndices()
	{
		sim.AddEntityIndex(new PrimaryEntityIndex<SimEntity, int>("EntityID", sim.GetGroup(SimMatcher.EntityID), (SimEntity e, IComponent c) => ((EntityID)c).mID));
	}
}
