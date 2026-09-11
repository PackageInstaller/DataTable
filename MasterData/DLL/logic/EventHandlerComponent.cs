using System;
using System.Collections.Generic;
using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public class EventHandlerComponent : IComponent
{
	public Dictionary<Type, EventPosterBase> mHandlers = new Dictionary<Type, EventPosterBase>(200);
}
