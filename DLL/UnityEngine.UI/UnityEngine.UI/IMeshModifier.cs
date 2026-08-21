using System;

namespace UnityEngine.UI;

public interface IMeshModifier
{
	[Obsolete("use IMeshModifier.ModifyMesh (VertexHelper verts) instead", false)]
	void ModifyMesh(Mesh mesh);

	void ModifyMesh(VertexHelper verts);
}
