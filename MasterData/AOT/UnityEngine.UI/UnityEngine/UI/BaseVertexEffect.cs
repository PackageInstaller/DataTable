using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace UnityEngine.UI;

[Obsolete("Use BaseMeshEffect instead", true)]
public abstract class BaseVertexEffect
{
	[Obsolete("Use BaseMeshEffect.ModifyMeshes instead", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public abstract void ModifyVertices(List<UIVertex> vertices);
}
