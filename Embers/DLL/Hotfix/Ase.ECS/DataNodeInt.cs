using System;

namespace Ase.ECS;

public class DataNodeInt : DataNodeBase<int>
{
	public override Type ValueType => typeof(int);
}
