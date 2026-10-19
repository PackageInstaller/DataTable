using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Gizmos/Gizmos.bindings.h")]
[StaticAccessor("GizmoBindings", StaticAccessorType.DoubleColon)]
public sealed class Gizmos
{
	public static Color color
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

	public static Matrix4x4 matrix
	{
		get
		{
			get_matrix_Injected(out var ret);
			return ret;
		}
		set
		{
			set_matrix_Injected(ref value);
		}
	}

	public static extern Texture exposure
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float probeSize
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeThrows]
	public static void DrawLine(Vector3 from, Vector3 to)
	{
		DrawLine_Injected(ref from, ref to);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	internal unsafe static extern void DrawLineStrip([Span("count", true)] Vector3* points, int count, bool looped);

	public unsafe static void DrawLineStrip(ReadOnlySpan<Vector3> points, bool looped)
	{
		fixed (Vector3* points2 = points)
		{
			DrawLineStrip(points2, points.Length, looped);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	internal unsafe static extern void DrawLineList([Span("count", true)] Vector3* points, int count);

	public unsafe static void DrawLineList(ReadOnlySpan<Vector3> points)
	{
		if ((points.Length & 1) != 0)
		{
			throw new UnityException("You cannot draw a line list from an odd number of points, with two points per line the number of points must be even");
		}
		fixed (Vector3* points2 = points)
		{
			DrawLineList(points2, points.Length);
		}
	}

	[NativeThrows]
	public static void DrawWireSphere(Vector3 center, float radius)
	{
		DrawWireSphere_Injected(ref center, radius);
	}

	[NativeThrows]
	public static void DrawSphere(Vector3 center, float radius)
	{
		DrawSphere_Injected(ref center, radius);
	}

	[NativeThrows]
	public static void DrawWireCube(Vector3 center, Vector3 size)
	{
		DrawWireCube_Injected(ref center, ref size);
	}

	[NativeThrows]
	public static void DrawCube(Vector3 center, Vector3 size)
	{
		DrawCube_Injected(ref center, ref size);
	}

	[NativeThrows]
	public static void DrawMesh(Mesh mesh, int submeshIndex, [DefaultValue("Vector3.zero")] Vector3 position, [DefaultValue("Quaternion.identity")] Quaternion rotation, [DefaultValue("Vector3.one")] Vector3 scale)
	{
		DrawMesh_Injected(mesh, submeshIndex, ref position, ref rotation, ref scale);
	}

	[NativeThrows]
	public static void DrawWireMesh(Mesh mesh, int submeshIndex, [DefaultValue("Vector3.zero")] Vector3 position, [DefaultValue("Quaternion.identity")] Quaternion rotation, [DefaultValue("Vector3.one")] Vector3 scale)
	{
		DrawWireMesh_Injected(mesh, submeshIndex, ref position, ref rotation, ref scale);
	}

	[NativeThrows]
	public static void DrawIcon(Vector3 center, string name, [DefaultValue("true")] bool allowScaling)
	{
		DrawIcon(center, name, allowScaling, Color.white);
	}

	[NativeThrows]
	public static void DrawIcon(Vector3 center, string name, [DefaultValue("true")] bool allowScaling, [DefaultValue("Color(255,255,255,255)")] Color tint)
	{
		DrawIcon_Injected(ref center, name, allowScaling, ref tint);
	}

	[NativeThrows]
	public static void DrawGUITexture(Rect screenRect, Texture texture, int leftBorder, int rightBorder, int topBorder, int bottomBorder, [DefaultValue("null")] Material mat)
	{
		DrawGUITexture_Injected(ref screenRect, texture, leftBorder, rightBorder, topBorder, bottomBorder, mat);
	}

	public static void DrawFrustum(Vector3 center, float fov, float maxRange, float minRange, float aspect)
	{
		DrawFrustum_Injected(ref center, fov, maxRange, minRange, aspect);
	}

	public static void DrawRay(Ray r)
	{
		DrawLine(r.origin, r.origin + r.direction);
	}

	public static void DrawRay(Vector3 from, Vector3 direction)
	{
		DrawLine(from, from + direction);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh, Vector3 position, Quaternion rotation)
	{
		Vector3 one = Vector3.one;
		DrawMesh(mesh, position, rotation, one);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh, Vector3 position)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		DrawMesh(mesh, position, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		Vector3 zero = Vector3.zero;
		DrawMesh(mesh, zero, identity, one);
	}

	public static void DrawMesh(Mesh mesh, [DefaultValue("Vector3.zero")] Vector3 position, [DefaultValue("Quaternion.identity")] Quaternion rotation, [DefaultValue("Vector3.one")] Vector3 scale)
	{
		DrawMesh(mesh, -1, position, rotation, scale);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh, int submeshIndex, Vector3 position, Quaternion rotation)
	{
		Vector3 one = Vector3.one;
		DrawMesh(mesh, submeshIndex, position, rotation, one);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh, int submeshIndex, Vector3 position)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		DrawMesh(mesh, submeshIndex, position, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawMesh(Mesh mesh, int submeshIndex)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		Vector3 zero = Vector3.zero;
		DrawMesh(mesh, submeshIndex, zero, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh, Vector3 position, Quaternion rotation)
	{
		Vector3 one = Vector3.one;
		DrawWireMesh(mesh, position, rotation, one);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh, Vector3 position)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		DrawWireMesh(mesh, position, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		Vector3 zero = Vector3.zero;
		DrawWireMesh(mesh, zero, identity, one);
	}

	public static void DrawWireMesh(Mesh mesh, [DefaultValue("Vector3.zero")] Vector3 position, [DefaultValue("Quaternion.identity")] Quaternion rotation, [DefaultValue("Vector3.one")] Vector3 scale)
	{
		DrawWireMesh(mesh, -1, position, rotation, scale);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh, int submeshIndex, Vector3 position, Quaternion rotation)
	{
		Vector3 one = Vector3.one;
		DrawWireMesh(mesh, submeshIndex, position, rotation, one);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh, int submeshIndex, Vector3 position)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		DrawWireMesh(mesh, submeshIndex, position, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawWireMesh(Mesh mesh, int submeshIndex)
	{
		Vector3 one = Vector3.one;
		Quaternion identity = Quaternion.identity;
		Vector3 zero = Vector3.zero;
		DrawWireMesh(mesh, submeshIndex, zero, identity, one);
	}

	[ExcludeFromDocs]
	public static void DrawIcon(Vector3 center, string name)
	{
		bool allowScaling = true;
		DrawIcon(center, name, allowScaling);
	}

	[ExcludeFromDocs]
	public static void DrawGUITexture(Rect screenRect, Texture texture)
	{
		Material mat = null;
		DrawGUITexture(screenRect, texture, mat);
	}

	public static void DrawGUITexture(Rect screenRect, Texture texture, [DefaultValue("null")] Material mat)
	{
		DrawGUITexture(screenRect, texture, 0, 0, 0, 0, mat);
	}

	[ExcludeFromDocs]
	public static void DrawGUITexture(Rect screenRect, Texture texture, int leftBorder, int rightBorder, int topBorder, int bottomBorder)
	{
		Material mat = null;
		DrawGUITexture(screenRect, texture, leftBorder, rightBorder, topBorder, bottomBorder, mat);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawLine_Injected(ref Vector3 from, ref Vector3 to);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawWireSphere_Injected(ref Vector3 center, float radius);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawSphere_Injected(ref Vector3 center, float radius);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawWireCube_Injected(ref Vector3 center, ref Vector3 size);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawCube_Injected(ref Vector3 center, ref Vector3 size);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawMesh_Injected(Mesh mesh, int submeshIndex, [DefaultValue("Vector3.zero")] ref Vector3 position, [DefaultValue("Quaternion.identity")] ref Quaternion rotation, [DefaultValue("Vector3.one")] ref Vector3 scale);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawWireMesh_Injected(Mesh mesh, int submeshIndex, [DefaultValue("Vector3.zero")] ref Vector3 position, [DefaultValue("Quaternion.identity")] ref Quaternion rotation, [DefaultValue("Vector3.one")] ref Vector3 scale);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawIcon_Injected(ref Vector3 center, string name, [DefaultValue("true")] bool allowScaling, [DefaultValue("Color(255,255,255,255)")] ref Color tint);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawGUITexture_Injected(ref Rect screenRect, Texture texture, int leftBorder, int rightBorder, int topBorder, int bottomBorder, [DefaultValue("null")] Material mat);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_color_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_color_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_matrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_matrix_Injected(ref Matrix4x4 value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DrawFrustum_Injected(ref Vector3 center, float fov, float maxRange, float minRange, float aspect);
}
