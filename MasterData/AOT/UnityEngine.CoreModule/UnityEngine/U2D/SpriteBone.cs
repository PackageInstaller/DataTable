using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.U2D;

[Serializable]
[NativeType(CodegenOptions.Custom, "ScriptingSpriteBone")]
[RequiredByNativeCode]
[NativeHeader("Runtime/2D/Common/SpriteDataAccess.h")]
[NativeHeader("Runtime/2D/Common/SpriteDataMarshalling.h")]
[MovedFrom("UnityEngine.Experimental.U2D")]
public struct SpriteBone
{
	[NativeName("name")]
	[SerializeField]
	private string m_Name;

	[SerializeField]
	[NativeName("guid")]
	private string m_Guid;

	[SerializeField]
	[NativeName("position")]
	private Vector3 m_Position;

	[NativeName("rotation")]
	[SerializeField]
	private Quaternion m_Rotation;

	[NativeName("length")]
	[SerializeField]
	private float m_Length;

	[SerializeField]
	[NativeName("parentId")]
	private int m_ParentId;

	[SerializeField]
	[NativeName("color")]
	private Color32 m_Color;
}
