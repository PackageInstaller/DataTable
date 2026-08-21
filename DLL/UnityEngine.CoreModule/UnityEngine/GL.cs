using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/Camera.h")]
[StaticAccessor("GetGfxDevice()", StaticAccessorType.Dot)]
[NativeHeader("Runtime/Camera/CameraUtil.h")]
[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
[NativeHeader("Runtime/GfxDevice/GfxDevice.h")]
public sealed class GL
{
	public const int TRIANGLES = 4;

	public const int TRIANGLE_STRIP = 5;

	public const int QUADS = 7;

	public const int LINES = 1;

	public const int LINE_STRIP = 2;

	public static extern bool wireframe
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool sRGBWrite
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("UserBackfaceMode")]
	public static extern bool invertCulling
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Matrix4x4 modelview
	{
		get
		{
			return GetWorldViewMatrix();
		}
		set
		{
			SetViewMatrix(value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ImmediateVertex")]
	public static extern void Vertex3(float x, float y, float z);

	public static void Vertex(Vector3 v)
	{
		Vertex3(v.x, v.y, v.z);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ImmediateVertices")]
	internal unsafe static extern void Vertices(Vector3* v, Vector3* coords, Vector4* colors, int length);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ImmediateTexCoordAll")]
	public static extern void TexCoord3(float x, float y, float z);

	public static void TexCoord(Vector3 v)
	{
		TexCoord3(v.x, v.y, v.z);
	}

	public static void TexCoord2(float x, float y)
	{
		TexCoord3(x, y, 0f);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ImmediateTexCoord")]
	public static extern void MultiTexCoord3(int unit, float x, float y, float z);

	public static void MultiTexCoord(int unit, Vector3 v)
	{
		MultiTexCoord3(unit, v.x, v.y, v.z);
	}

	public static void MultiTexCoord2(int unit, float x, float y)
	{
		MultiTexCoord3(unit, x, y, 0f);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ImmediateColor")]
	private static extern void ImmediateColor(float r, float g, float b, float a);

	public static void Color(Color c)
	{
		ImmediateColor(c.r, c.g, c.b, c.a);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void Flush();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void RenderTargetBarrier();

	private static Matrix4x4 GetWorldViewMatrix()
	{
		GetWorldViewMatrix_Injected(out var ret);
		return ret;
	}

	private static void SetViewMatrix(Matrix4x4 m)
	{
		SetViewMatrix_Injected(ref m);
	}

	[NativeName("SetWorldMatrix")]
	public static void MultMatrix(Matrix4x4 m)
	{
		MultMatrix_Injected(ref m);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[Obsolete("IssuePluginEvent(eventID) is deprecated. Use IssuePluginEvent(callback, eventID) instead.", false)]
	[NativeName("InsertCustomMarker")]
	public static extern void IssuePluginEvent(int eventID);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetUserBackfaceMode")]
	[Obsolete("SetRevertBackfacing(revertBackFaces) is deprecated. Use invertCulling property instead. (UnityUpgradable) -> invertCulling", false)]
	public static extern void SetRevertBackfacing(bool revertBackFaces);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLPushMatrixScript")]
	public static extern void PushMatrix();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLPopMatrixScript")]
	public static extern void PopMatrix();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLLoadIdentityScript")]
	public static extern void LoadIdentity();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLLoadOrthoScript")]
	public static extern void LoadOrtho();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLLoadPixelMatrixScript")]
	public static extern void LoadPixelMatrix();

	[FreeFunction("GLLoadProjectionMatrixScript")]
	public static void LoadProjectionMatrix(Matrix4x4 mat)
	{
		LoadProjectionMatrix_Injected(ref mat);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLInvalidateState")]
	public static extern void InvalidateState();

	[FreeFunction("GLGetGPUProjectionMatrix")]
	public static Matrix4x4 GetGPUProjectionMatrix(Matrix4x4 proj, bool renderIntoTexture)
	{
		GetGPUProjectionMatrix_Injected(ref proj, renderIntoTexture, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern void GLLoadPixelMatrixScript(float left, float right, float bottom, float top);

	public static void LoadPixelMatrix(float left, float right, float bottom, float top)
	{
		GLLoadPixelMatrixScript(left, right, bottom, top);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	private static extern void GLIssuePluginEvent(IntPtr callback, int eventID);

	public static void IssuePluginEvent(IntPtr callback, int eventID)
	{
		if (callback == IntPtr.Zero)
		{
			throw new ArgumentException("Null callback specified.", "callback");
		}
		GLIssuePluginEvent(callback, eventID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLBegin", ThrowsException = true)]
	public static extern void Begin(int mode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GLEnd")]
	public static extern void End();

	[FreeFunction]
	private static void GLClear(bool clearDepth, bool clearColor, Color backgroundColor, float depth)
	{
		GLClear_Injected(clearDepth, clearColor, ref backgroundColor, depth);
	}

	public static void Clear(bool clearDepth, bool clearColor, Color backgroundColor, [DefaultValue("1.0f")] float depth)
	{
		GLClear(clearDepth, clearColor, backgroundColor, depth);
	}

	public static void Clear(bool clearDepth, bool clearColor, Color backgroundColor)
	{
		GLClear(clearDepth, clearColor, backgroundColor, 1f);
	}

	[FreeFunction("SetGLViewport")]
	public static void Viewport(Rect pixelRect)
	{
		Viewport_Injected(ref pixelRect);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ClearWithSkybox")]
	public static extern void ClearWithSkybox(bool clearDepth, Camera camera);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetWorldViewMatrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetViewMatrix_Injected(ref Matrix4x4 m);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void MultMatrix_Injected(ref Matrix4x4 m);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void LoadProjectionMatrix_Injected(ref Matrix4x4 mat);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetGPUProjectionMatrix_Injected(ref Matrix4x4 proj, bool renderIntoTexture, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GLClear_Injected(bool clearDepth, bool clearColor, ref Color backgroundColor, float depth);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Viewport_Injected(ref Rect pixelRect);
}
