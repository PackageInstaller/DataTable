using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Events;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeType("Runtime/Graphics/Mesh/SpriteRenderer.h")]
[RequireComponent(typeof(Transform))]
public sealed class SpriteRenderer : Renderer
{
	private UnityEvent<SpriteRenderer> m_SpriteChangeEvent;

	internal extern bool shouldSupportTiling
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("ShouldSupportTiling")]
		get;
	}

	internal extern bool hasSpriteChangeEvents
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Sprite sprite
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern SpriteDrawMode drawMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector2 size
	{
		get
		{
			get_size_Injected(out var ret);
			return ret;
		}
		set
		{
			set_size_Injected(ref value);
		}
	}

	public extern float adaptiveModeThreshold
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern SpriteTileMode tileMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Color color
	{
		get
		{
			get_color_Injected(out var ret);
			return ret;
		}
		set
		{
			set_color_Injected(ref value);
		}
	}

	public extern SpriteMaskInteraction maskInteraction
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool flipX
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool flipY
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern SpriteSortPoint spriteSortPoint
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public void RegisterSpriteChangeCallback(UnityAction<SpriteRenderer> callback)
	{
		if (m_SpriteChangeEvent == null)
		{
			m_SpriteChangeEvent = new UnityEvent<SpriteRenderer>();
		}
		m_SpriteChangeEvent.AddListener(callback);
		hasSpriteChangeEvents = true;
	}

	public void UnregisterSpriteChangeCallback(UnityAction<SpriteRenderer> callback)
	{
		if (m_SpriteChangeEvent != null)
		{
			m_SpriteChangeEvent.RemoveListener(callback);
			if (m_SpriteChangeEvent.GetCallsCount() == 0)
			{
				hasSpriteChangeEvents = false;
			}
		}
	}

	[RequiredByNativeCode]
	private void InvokeSpriteChanged()
	{
		try
		{
			m_SpriteChangeEvent?.Invoke(this);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception, this);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetCurrentMeshDataPtr();

	internal unsafe Mesh.MeshDataArray GetCurrentMeshData()
	{
		IntPtr currentMeshDataPtr = GetCurrentMeshDataPtr();
		if (currentMeshDataPtr == IntPtr.Zero)
		{
			return new Mesh.MeshDataArray(0);
		}
		Mesh.MeshDataArray result = new Mesh.MeshDataArray(1);
		*result.m_Ptrs = currentMeshDataPtr;
		return result;
	}

	[NativeMethod(Name = "GetSpriteBounds")]
	internal Bounds Internal_GetSpriteBounds(SpriteDrawMode mode)
	{
		Internal_GetSpriteBounds_Injected(mode, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern void GetSecondaryTextureProperties([NotNull("ArgumentNullException")] MaterialPropertyBlock mbp);

	internal Bounds GetSpriteBounds()
	{
		return Internal_GetSpriteBounds(drawMode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_size_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_size_Injected(ref Vector2 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_color_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_color_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_GetSpriteBounds_Injected(SpriteDrawMode mode, out Bounds ret);
}
