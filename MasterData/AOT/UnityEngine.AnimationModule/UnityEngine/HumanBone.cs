using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeType(CodegenOptions.Custom, "MonoHumanBone")]
[NativeHeader("Modules/Animation/HumanDescription.h")]
[RequiredByNativeCode]
public struct HumanBone
{
	private string m_BoneName;

	private string m_HumanName;

	[NativeName("m_Limit")]
	public HumanLimit limit;
}
