using UnityEngine;

namespace Unity.VisualScripting.Community;

[CreateAssetMenu(menuName = "Visual Scripting/Community/Code/Class")]
[RenamedFrom("Bolt.Addons.Community.Code.ClassAsset")]
public class ClassAsset : MemberTypeAsset<ClassFieldDeclaration, ClassMethodDeclaration, ClassConstructorDeclaration>
{
	[Inspectable]
	public bool scriptableObject;

	[Inspectable]
	public string fileName;

	[Inspectable]
	public string menuName;
}
