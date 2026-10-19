using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.CSharp;
using Unity.VisualScripting.Community.Utility;

namespace Unity.VisualScripting.Community;

[Serializable]
[Inspectable]
[RenamedFrom("Bolt.Addons.Community.Code.ConstructorDeclaration")]
public abstract class ConstructorDeclaration : Macro<FlowGraph>
{
	public AccessModifier scope;

	public ConstructorModifier modifier;

	[Inspectable]
	public ClassAsset classAsset;

	[Inspectable]
	public StructAsset structAsset;

	[InspectorWide]
	[Serialize]
	public List<TypeParam> parameters = new List<TypeParam>();
}
