using System;

namespace Ase.ECS;

public class DataNodeFloat : DataNodeBase<float>
{
	public override Type ValueType => typeof(float);
}
