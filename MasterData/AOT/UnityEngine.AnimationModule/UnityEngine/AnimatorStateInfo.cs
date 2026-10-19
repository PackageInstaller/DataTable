using System;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[NativeHeader("Modules/Animation/AnimatorInfo.h")]
public struct AnimatorStateInfo
{
	private int m_Name;

	private int m_Path;

	private int m_FullPath;

	private float m_NormalizedTime;

	private float m_Length;

	private float m_Speed;

	private float m_SpeedMultiplier;

	private int m_Tag;

	private int m_Loop;

	public int fullPathHash => m_FullPath;

	[Obsolete("AnimatorStateInfo.nameHash has been deprecated. Use AnimatorStateInfo.fullPathHash instead.")]
	public int nameHash => m_Path;

	public int shortNameHash => m_Name;

	public float normalizedTime => m_NormalizedTime;

	public float length => m_Length;

	public float speed => m_Speed;

	public float speedMultiplier => m_SpeedMultiplier;

	public int tagHash => m_Tag;

	public bool loop => m_Loop != 0;

	public bool IsName(string name)
	{
		int num = Animator.StringToHash(name);
		return num == m_FullPath || num == m_Name || num == m_Path;
	}

	public bool IsTag(string tag)
	{
		return Animator.StringToHash(tag) == m_Tag;
	}
}
