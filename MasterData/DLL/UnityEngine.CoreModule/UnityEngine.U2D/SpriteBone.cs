using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.U2D;

[Serializable]
[NativeHeader("Runtime/2D/Common/SpriteDataMarshalling.h")]
[RequiredByNativeCode]
[MovedFrom("UnityEngine.Experimental.U2D")]
[NativeHeader("Runtime/2D/Common/SpriteDataAccess.h")]
[NativeType(CodegenOptions.Custom, "ScriptingSpriteBone")]
public struct SpriteBone
{
	[NativeName("name")]
	[SerializeField]
	private string m_Name;

	[NativeName("guid")]
	[SerializeField]
	private string m_Guid;

	[NativeName("position")]
	[SerializeField]
	private Vector3 m_Position;

	[SerializeField]
	[NativeName("rotation")]
	private Quaternion m_Rotation;

	[SerializeField]
	[NativeName("length")]
	private float m_Length;

	[NativeName("parentId")]
	[SerializeField]
	private int m_ParentId;

	[SerializeField]
	[NativeName("color")]
	private Color32 m_Color;
}
