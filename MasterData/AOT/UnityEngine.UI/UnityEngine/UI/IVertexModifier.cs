using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace UnityEngine.UI;

[EditorBrowsable(EditorBrowsableState.Never)]
[Obsolete("Use IMeshModifier instead", true)]
public interface IVertexModifier
{
	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("use IMeshModifier.ModifyMesh (VertexHelper verts)  instead", true)]
	void ModifyVertices(List<UIVertex> verts);
}
