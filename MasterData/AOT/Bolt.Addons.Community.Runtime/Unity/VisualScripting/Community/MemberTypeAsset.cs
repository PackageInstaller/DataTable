using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.MemberTypeAsset")]
[Inspectable]
public abstract class MemberTypeAsset<TFieldDeclaration, TMethodDeclaration, TConstructorDeclaration> : CodeAsset where TFieldDeclaration : FieldDeclaration where TMethodDeclaration : MethodDeclaration where TConstructorDeclaration : ConstructorDeclaration
{
	[Inspectable]
	[InspectorWide]
	[SerializeField]
	public List<TConstructorDeclaration> constructors = new List<TConstructorDeclaration>();

	[Inspectable]
	[InspectorWide]
	[SerializeField]
	public List<TFieldDeclaration> variables = new List<TFieldDeclaration>();

	[Inspectable]
	[InspectorWide]
	[SerializeField]
	public List<TMethodDeclaration> methods = new List<TMethodDeclaration>();

	[SerializeField]
	public List<AttributeDeclaration> attributes = new List<AttributeDeclaration>();

	[Inspectable]
	public bool inspectable = true;

	[Inspectable]
	public bool serialized = true;

	[Inspectable]
	public bool includeInSettings = true;

	[Inspectable]
	public bool definedEvent;

	[Inspectable]
	public int order;
}
