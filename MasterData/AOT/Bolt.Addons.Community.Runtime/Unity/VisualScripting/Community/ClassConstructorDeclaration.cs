using System;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.ClassConstructorDeclaration")]
public sealed class ClassConstructorDeclaration : ConstructorDeclaration
{
	public override FlowGraph DefaultGraph()
	{
		return new FlowGraph();
	}
}
