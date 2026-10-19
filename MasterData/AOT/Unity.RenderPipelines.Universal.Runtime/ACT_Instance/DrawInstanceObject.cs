using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT_Instance;

public class DrawInstanceObject
{
	[Serializable]
	public class InstanceObject
	{
		public Mesh mesh;

		public Material mat;

		public List<InstanceData> instanceData = new List<InstanceData>();

		public Bounds bounds;

		public Bounds LocalBounds;

		public bool renderShadow;

		public RenderType renderType;

		public Matrix4x4 TransformMatrix;
	}

	public enum RenderType
	{
		GBuffer,
		Forward
	}

	[Serializable]
	public struct InstanceData
	{
		public Matrix4x4 LocalTransformMatrixs;

		public Vector4 color;

		public Vector4 customData1;

		public Vector4 customData2;

		public Vector4 cullingBounds;
	}

	private struct BufferGroup
	{
		public ComputeBuffer data;
	}

	private ComputeBuffer ArgsBuffer;

	private ComputeBuffer InstanceDataBuffer1;

	private ComputeBuffer InstanceDataBuffer2;

	private ComputeBuffer InstanceDataBuffer3;

	private ComputeBuffer SystemBuffer;

	public bool isVisiable;

	private BufferGroup[] BufferStack;

	private BufferGroup BufferToDraw;

	public InstanceObject objectToDraw;

	private ComputeShader cullingCS;

	private int VisibilityCullingKernelID;

	private int OcclusionCullingKernelID;

	private int ShadowCullingKernelID;

	private static int SouceBufferTagID = Shader.PropertyToID("_InstanceDataBuffer");

	private static int TargetBufferTagID = Shader.PropertyToID("_InstanceDataBufferTarget");

	private static int SystemBufferTagID = Shader.PropertyToID("_SystemBufferTarget");

	private static int ShadowBoundminTagID = Shader.PropertyToID("_ShadowBoundMin");

	private static int ShadowBoundmaxTagID = Shader.PropertyToID("_ShadowBoundMax");

	private static int ParentMatrixTagID = Shader.PropertyToID("_ACT_ParentMatrix");

	private static int InstanceDataTagID = Shader.PropertyToID("_ACT_Instance_Data");

	private bool needCameraCull;

	private bool needVisiableCull;

	private ComputeBuffer currentBuffer;

	public static InstanceData GetInstanceData(Matrix4x4 ObjectMatrix, Vector4 color, Vector4 customData, Vector4 customdata2, Bounds bounds)
	{
		return new InstanceData
		{
			color = color,
			LocalTransformMatrixs = ObjectMatrix,
			customData1 = customData,
			customData2 = customdata2,
			cullingBounds = new Vector4(bounds.center.x, bounds.center.y, bounds.center.z, (bounds.max - bounds.center).magnitude)
		};
	}

	private void SwaPBuffer(ref BufferGroup[] group)
	{
		ref BufferGroup reference = ref group[0];
		ref BufferGroup reference2 = ref group[1];
		BufferGroup bufferGroup = group[1];
		BufferGroup bufferGroup2 = group[0];
		reference = bufferGroup;
		reference2 = bufferGroup2;
	}

	public DrawInstanceObject(InstanceObject _instanceObject, bool cameraCull, bool VisiableCull)
	{
		needCameraCull = cameraCull;
		needVisiableCull = VisiableCull;
		objectToDraw = _instanceObject;
		InstanceDataBuffer1 = new ComputeBuffer(objectToDraw.instanceData.Count, 128, ComputeBufferType.Append);
		InstanceDataBuffer1.SetData(objectToDraw.instanceData);
		if (needCameraCull)
		{
			InstanceDataBuffer2 = new ComputeBuffer(objectToDraw.instanceData.Count, 128, ComputeBufferType.Append);
			if (needVisiableCull)
			{
				InstanceDataBuffer3 = new ComputeBuffer(objectToDraw.instanceData.Count, 128, ComputeBufferType.Append);
			}
		}
		ArgsBuffer = new ComputeBuffer(5, 4, ComputeBufferType.DrawIndirect);
		SystemBuffer = new ComputeBuffer(1, 4, ComputeBufferType.DrawIndirect);
		uint[] data = new uint[5]
		{
			objectToDraw.mesh.GetIndexCount(0),
			(uint)objectToDraw.instanceData.Count,
			objectToDraw.mesh.GetIndexStart(0),
			objectToDraw.mesh.GetBaseVertex(0),
			0u
		};
		ArgsBuffer.SetData(data);
		BufferGroup bufferGroup = (BufferToDraw = new BufferGroup
		{
			data = InstanceDataBuffer2
		});
		BufferGroup bufferGroup2 = new BufferGroup
		{
			data = InstanceDataBuffer3
		};
		BufferStack = new BufferGroup[2] { bufferGroup, bufferGroup2 };
		UniversalRendererData universalRendererData = UniversalRenderPipeline.asset.scriptableRendererData as UniversalRendererData;
		cullingCS = UnityEngine.Object.Instantiate(universalRendererData.shaders.CullingCS);
		VisibilityCullingKernelID = cullingCS.FindKernel("CameraViewCulling");
		ShadowCullingKernelID = cullingCS.FindKernel("ShadowCulling");
		cullingCS.SetInt("_ObjectCount", objectToDraw.instanceData.Count);
	}

	public void DoCulling(CommandBuffer cmd)
	{
		currentBuffer = InstanceDataBuffer1;
		if (needCameraCull)
		{
			cmd.SetComputeBufferParam(cullingCS, VisibilityCullingKernelID, SouceBufferTagID, InstanceDataBuffer1);
			cmd.SetComputeBufferParam(cullingCS, VisibilityCullingKernelID, TargetBufferTagID, BufferStack[0].data);
			cmd.SetComputeBufferParam(cullingCS, VisibilityCullingKernelID, SystemBufferTagID, SystemBuffer);
			cmd.SetBufferCounterValue(BufferStack[0].data, 0u);
			cmd.DispatchCompute(cullingCS, VisibilityCullingKernelID, Mathf.CeilToInt((float)objectToDraw.instanceData.Count / 64f), 1, 1);
			currentBuffer = BufferStack[0].data;
			if (needVisiableCull)
			{
				cmd.CopyCounterValue(BufferStack[0].data, SystemBuffer, 0u);
				cmd.SetComputeBufferParam(cullingCS, OcclusionCullingKernelID, SouceBufferTagID, BufferStack[0].data);
				cmd.SetComputeBufferParam(cullingCS, OcclusionCullingKernelID, TargetBufferTagID, BufferStack[1].data);
				cmd.SetComputeBufferParam(cullingCS, VisibilityCullingKernelID, SystemBufferTagID, SystemBuffer);
				cmd.SetBufferCounterValue(BufferStack[1].data, 0u);
				cmd.DispatchCompute(cullingCS, OcclusionCullingKernelID, Mathf.CeilToInt((float)objectToDraw.instanceData.Count / 64f), 1, 1);
				cmd.CopyCounterValue(BufferStack[1].data, SystemBuffer, 0u);
				SwaPBuffer(ref BufferStack);
				currentBuffer = BufferStack[1].data;
			}
			cmd.CopyCounterValue(currentBuffer, ArgsBuffer, 4u);
		}
	}

	public void DrawInstance(CommandBuffer cmd, bool Culling, int shaderPass)
	{
		cmd.SetGlobalMatrix(ParentMatrixTagID, objectToDraw.TransformMatrix);
		if (Culling)
		{
			DoCulling(cmd);
		}
		cmd.SetGlobalBuffer(InstanceDataTagID, currentBuffer);
		cmd.DrawMeshInstancedIndirect(objectToDraw.mesh, 0, objectToDraw.mat, shaderPass, ArgsBuffer);
	}

	public void DoShadowCulling(CommandBuffer cmd, Bounds shadowBound)
	{
		currentBuffer = InstanceDataBuffer1;
		cmd.SetGlobalMatrix(ParentMatrixTagID, objectToDraw.TransformMatrix);
		cmd.SetComputeVectorParam(cullingCS, ShadowBoundminTagID, new Vector4(shadowBound.min.x, shadowBound.min.y, shadowBound.min.z, 0f));
		cmd.SetComputeVectorParam(cullingCS, ShadowBoundmaxTagID, new Vector4(shadowBound.max.x, shadowBound.max.y, shadowBound.max.z, 0f));
		cmd.SetComputeBufferParam(cullingCS, ShadowCullingKernelID, SouceBufferTagID, InstanceDataBuffer1);
		cmd.SetComputeBufferParam(cullingCS, ShadowCullingKernelID, TargetBufferTagID, BufferStack[0].data);
		cmd.SetBufferCounterValue(BufferStack[0].data, 0u);
		cmd.DispatchCompute(cullingCS, ShadowCullingKernelID, Mathf.CeilToInt((float)objectToDraw.instanceData.Count / 64f), 1, 1);
		currentBuffer = BufferStack[0].data;
		cmd.CopyCounterValue(currentBuffer, ArgsBuffer, 4u);
	}

	public void DrawShadowInstance(CommandBuffer cmd, int shaderPass)
	{
		cmd.SetGlobalMatrix(ParentMatrixTagID, objectToDraw.TransformMatrix);
		cmd.SetGlobalBuffer(InstanceDataTagID, currentBuffer);
		cmd.DrawMeshInstancedIndirect(objectToDraw.mesh, 0, objectToDraw.mat, shaderPass, ArgsBuffer);
	}

	public void AddToRenderer()
	{
		DrawInstanceObjectRendering.ObjectList.Add(this);
	}

	public void RemoveFromRenderer()
	{
		DrawInstanceObjectRendering.ObjectList.Remove(this);
	}

	public void release()
	{
		ArgsBuffer.Release();
		InstanceDataBuffer1.Release();
		SystemBuffer.Release();
		if (needCameraCull)
		{
			InstanceDataBuffer2.Release();
			if (needVisiableCull)
			{
				InstanceDataBuffer3.Release();
			}
		}
		UnityEngine.Object.DestroyImmediate(cullingCS);
	}
}
