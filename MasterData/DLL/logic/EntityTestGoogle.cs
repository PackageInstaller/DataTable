using System.Collections.Generic;
using Entitas;
using Google.Protobuf;

[Sim]
public class EntityTestGoogle : IComponent
{
	public Queue<IMessage> mRecvCache;
}
