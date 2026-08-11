using System;
using UnityEngine;

namespace Ase.ECS;

public class DataNodeVector3 : DataNodeBase<Vector3>
{
	public override Type ValueType => typeof(Vector3);
}
