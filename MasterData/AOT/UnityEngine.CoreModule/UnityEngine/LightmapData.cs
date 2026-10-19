using System;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeHeader("Runtime/Graphics/LightmapData.h")]
[UsedByNativeCode]
public sealed class LightmapData
{
	internal Texture2D m_Light;

	internal Texture2D m_Dir;

	internal Texture2D m_ShadowMask;

	[Obsolete("Use lightmapColor property (UnityUpgradable) -> lightmapColor", false)]
	public Texture2D lightmapLight
	{
		get
		{
			return m_Light;
		}
		set
		{
			m_Light = value;
		}
	}

	public Texture2D lightmapColor
	{
		get
		{
			return m_Light;
		}
		set
		{
			m_Light = value;
		}
	}

	public Texture2D lightmapDir
	{
		get
		{
			return m_Dir;
		}
		set
		{
			m_Dir = value;
		}
	}

	public Texture2D shadowMask
	{
		get
		{
			return m_ShadowMask;
		}
		set
		{
			m_ShadowMask = value;
		}
	}
}
