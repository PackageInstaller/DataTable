using System;
using UnityEngine;

namespace Ase.ECS;

public class DataNodeVector2 : DataNodeBase<Vector2>
{
	public override Type ValueType => typeof(Vector2);
}
