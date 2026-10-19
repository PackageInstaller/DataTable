using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Code.StructAsset")]
[CreateAssetMenu(menuName = "Visual Scripting/Community/Code/Struct")]
public class StructAsset : MemberTypeAsset<StructFieldDeclaration, StructMethodDeclaration, StructConstructorDeclaration>
{
}
