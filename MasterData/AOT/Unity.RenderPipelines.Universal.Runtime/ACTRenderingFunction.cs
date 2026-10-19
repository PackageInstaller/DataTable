using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using XPostProcessing;

public static class ACTRenderingFunction
{
	public struct ScreenBillBoardData
	{
		public Vector2 position;

		public Vector2 size;

		public float roatation;

		public Vector4 color;

		public Vector4 customData;
	}

	public static Mesh FullScreenMesh;

	public static Mesh BillboardMesh;

	public static int MainTexTag = Shader.PropertyToID("_Main1Tex");

	private static int BillBoardDataTag = Shader.PropertyToID("_ACTBillBoardData");

	private static int BillBoardRotationTag = Shader.PropertyToID("_ACTBillBoardRotation");

	private static int BillBoardColorTag = Shader.PropertyToID("_ACTBillBoardColor");

	private static int BillBoardCustomDataTag = Shader.PropertyToID("_ACTBillBoardCustomData");

	private static int BillBoardBufferTag = Shader.PropertyToID("_ACTBillBoardBuffer");

	private static Mesh CreateFullscreenMesh()
	{
		Vector3[] vertices = new Vector3[3]
		{
			new Vector3(-1f, 1f, 0f),
			new Vector3(-1f, -3f, 0f),
			new Vector3(3f, 1f, 0f)
		};
		int[] triangles = new int[3] { 0, 1, 2 };
		return new Mesh
		{
			indexFormat = IndexFormat.UInt16,
			vertices = vertices,
			triangles = triangles
		};
	}

	private static Mesh CreateBillboardMesh()
	{
		Vector3[] vertices = new Vector3[4]
		{
			new Vector3(-1f, 1f, 0f),
			new Vector3(-1f, -1f, 0f),
			new Vector3(1f, 1f, 0f),
			new Vector3(1f, -1f, 0f)
		};
		Vector2[] uv = new Vector2[4]
		{
			new Vector2(0f, 1f),
			new Vector2(0f, 0f),
			new Vector2(1f, 1f),
			new Vector2(1f, 0f)
		};
		int[] triangles = new int[6] { 0, 2, 1, 1, 2, 3 };
		return new Mesh
		{
			indexFormat = IndexFormat.UInt16,
			vertices = vertices,
			triangles = triangles,
			uv = uv
		};
	}

	public static void ReleaseResources()
	{
		CoreUtils.Destroy(FullScreenMesh);
		FullScreenMesh = null;
		CoreUtils.Destroy(BillboardMesh);
		BillboardMesh = null;
	}

	public static void ACT_DrawFullScreenMesh(CommandBuffer cmd, Material mat, int shaderPass, RenderTargetIdentifier src)
	{
		ACT_DrawFullScreenMesh(cmd, mat, shaderPass, src, MainTexTag);
	}

	public static void ACT_DrawFullScreenMesh(CommandBuffer cmd, Material mat, int shaderPass, RenderTargetIdentifier src, int sourceTextureId)
	{
		cmd.SetGlobalTexture(sourceTextureId, src);
		if (FullScreenMesh == null)
		{
			FullScreenMesh = CreateFullscreenMesh();
		}
		cmd.DrawMesh(FullScreenMesh, Matrix4x4.identity, mat, 0, shaderPass);
	}

	public static void ACT_DrawBoard(CommandBuffer cmd, Matrix4x4 O2WMatrix, Material mat, int shaderPass)
	{
		if (BillboardMesh == null)
		{
			BillboardMesh = CreateBillboardMesh();
		}
		cmd.DrawMesh(BillboardMesh, O2WMatrix, mat, 0, shaderPass);
	}

	public static void ACT_BlitWithOutLoad(CommandBuffer cmd, RenderTargetIdentifier src, RenderTargetIdentifier dst, Material mat, int passIndex)
	{
		cmd.SetRenderTarget(dst, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store);
		ACT_DrawFullScreenMesh(cmd, mat, passIndex, src);
	}

	public static void ACT_DrawBillBoardOnScreen(CommandBuffer cmd, Material mat, int passIndex, Vector2 screenPos, Vector2 scale, float rotation, Color color, Vector4 customData)
	{
		cmd.SetGlobalVector(BillBoardDataTag, new Vector4(screenPos.x, screenPos.y, scale.x, scale.y));
		cmd.SetGlobalVector(BillBoardRotationTag, new Vector4(rotation, 0f, 0f));
		cmd.SetGlobalVector(BillBoardColorTag, color);
		cmd.SetGlobalVector(BillBoardCustomDataTag, customData);
		if (BillboardMesh == null)
		{
			BillboardMesh = CreateBillboardMesh();
		}
		cmd.DrawMesh(BillboardMesh, Matrix4x4.identity, mat, 0, passIndex);
	}

	public static void ACT_DrawBillBoardOnScreen(CommandBuffer cmd, Material mat, int passIndex, Vector2 screenPos, Vector2 scale, float rotation, Color color)
	{
		ACT_DrawBillBoardOnScreen(cmd, mat, passIndex, screenPos, scale, rotation, color, Vector4.zero);
	}

	public static void ACT_DrawBillBoardOnScreen(CommandBuffer cmd, Material mat, int passIndex, Vector2 screenPos, Vector2 scale, float rotation)
	{
		ACT_DrawBillBoardOnScreen(cmd, mat, passIndex, screenPos, scale, rotation, Color.white);
	}

	public static void ACT_DrawBillBoardOnScreen(CommandBuffer cmd, Material mat, int passIndex, Vector2 screenPos, Vector2 scale)
	{
		ACT_DrawBillBoardOnScreen(cmd, mat, passIndex, screenPos, scale, 0f);
	}

	internal static void ACT_ShakeCamera(ref RenderingData renderingData, VolumeComponentCache volumeComponents)
	{
		Vector2 zero = Vector2.zero;
		CameraShake cameraShake = volumeComponents.CameraShake;
		if (cameraShake.IsActive())
		{
			zero += cameraShake.ShakeOffset.value;
		}
		if (zero != Vector2.zero)
		{
			Matrix4x4 projectionMatrix = renderingData.cameraData.GetProjectionMatrix();
			projectionMatrix.m02 -= zero.x;
			projectionMatrix.m12 -= zero.y;
			renderingData.cameraData.SetProjectionMatrix(projectionMatrix);
		}
	}
}
