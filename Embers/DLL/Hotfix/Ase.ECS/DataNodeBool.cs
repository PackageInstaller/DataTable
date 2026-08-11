using System;

namespace Ase.ECS;

public class DataNodeBool : DataNodeBase<bool>
{
	public override Type ValueType => typeof(bool);
}
