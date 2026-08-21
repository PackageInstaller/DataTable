using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace UnityEngine.UI;

[Obsolete("Use BaseMeshEffect instead", true)]
public abstract class BaseVertexEffect
{
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use BaseMeshEffect.ModifyMeshes instead", true)]
	public abstract void ModifyVertices(List<UIVertex> vertices);
}
