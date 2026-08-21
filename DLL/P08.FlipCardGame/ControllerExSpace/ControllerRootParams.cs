using System;
using System.Collections.Generic;
using UnityEngine;

namespace ControllerExSpace;

[Serializable]
public struct ControllerRootParams
{
	[SerializeField]
	public List<ControllerParams> param;

	[SerializeField]
	public int propertyIndex;
}
