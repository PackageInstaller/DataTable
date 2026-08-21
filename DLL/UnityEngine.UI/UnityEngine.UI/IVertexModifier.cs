using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace UnityEngine.UI;

[Obsolete("Use IMeshModifier instead", true)]
[EditorBrowsable(EditorBrowsableState.Never)]
public interface IVertexModifier
{
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("use IMeshModifier.ModifyMesh (VertexHelper verts)  instead", true)]
	void ModifyVertices(List<UIVertex> verts);
}
