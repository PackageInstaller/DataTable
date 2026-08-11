using System.Collections.Generic;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.Rendering;

public class ConstantBuffer
{
	private static List<ConstantBufferBase> m_RegisteredConstantBuffers = new List<ConstantBufferBase>();

	public static void PushGlobal<CBType>(CommandBuffer cmd, in CBType data, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(cmd, in data);
		instance.SetGlobal(cmd, shaderId);
	}

	public static void PushGlobal<CBType>(in CBType data, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(in data);
		instance.SetGlobal(shaderId);
	}

	public static void Push<CBType>(CommandBuffer cmd, in CBType data, ComputeShader cs, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(cmd, in data);
		instance.Set(cmd, cs, shaderId);
	}

	public static void Push<CBType>(in CBType data, ComputeShader cs, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(in data);
		instance.Set(cs, shaderId);
	}

	public static void Push<CBType>(CommandBuffer cmd, in CBType data, Material mat, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(cmd, in data);
		instance.Set(mat, shaderId);
	}

	public static void Push<CBType>(in CBType data, Material mat, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType> instance = ConstantBufferSingleton<CBType>.instance;
		instance.UpdateData(in data);
		instance.Set(mat, shaderId);
	}

	public static void UpdateData<CBType>(CommandBuffer cmd, in CBType data) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.UpdateData(cmd, in data);
	}

	public static void UpdateData<CBType>(in CBType data) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.UpdateData(in data);
	}

	public static void SetGlobal<CBType>(CommandBuffer cmd, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.SetGlobal(cmd, shaderId);
	}

	public static void SetGlobal<CBType>(int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.SetGlobal(shaderId);
	}

	public static void Set<CBType>(CommandBuffer cmd, ComputeShader cs, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.Set(cmd, cs, shaderId);
	}

	public static void Set<CBType>(ComputeShader cs, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.Set(cs, shaderId);
	}

	public static void Set<CBType>(Material mat, int shaderId) where CBType : struct
	{
		ConstantBufferSingleton<CBType>.instance.Set(mat, shaderId);
	}

	public static void ReleaseAll()
	{
		foreach (ConstantBufferBase registeredConstantBuffer in m_RegisteredConstantBuffers)
		{
			registeredConstantBuffer.Release();
		}
		m_RegisteredConstantBuffers.Clear();
	}

	internal static void Register(ConstantBufferBase cb)
	{
		m_RegisteredConstantBuffers.Add(cb);
	}
}
public class ConstantBuffer<CBType> : ConstantBufferBase where CBType : struct
{
	private HashSet<int> m_GlobalBindings = new HashSet<int>();

	private CBType[] m_Data = new CBType[1];

	private ComputeBuffer m_GPUConstantBuffer;

	public ConstantBuffer()
	{
		m_GPUConstantBuffer = new ComputeBuffer(1, UnsafeUtility.SizeOf<CBType>(), ComputeBufferType.Constant);
	}

	public void UpdateData(CommandBuffer cmd, in CBType data)
	{
		m_Data[0] = data;
		cmd.SetBufferData(m_GPUConstantBuffer, m_Data);
	}

	public void UpdateData(in CBType data)
	{
		m_Data[0] = data;
		m_GPUConstantBuffer.SetData(m_Data);
	}

	public void SetGlobal(CommandBuffer cmd, int shaderId)
	{
		m_GlobalBindings.Add(shaderId);
		cmd.SetGlobalConstantBuffer(m_GPUConstantBuffer, shaderId, 0, m_GPUConstantBuffer.stride);
	}

	public void SetGlobal(int shaderId)
	{
		m_GlobalBindings.Add(shaderId);
		Shader.SetGlobalConstantBuffer(shaderId, m_GPUConstantBuffer, 0, m_GPUConstantBuffer.stride);
	}

	public void Set(CommandBuffer cmd, ComputeShader cs, int shaderId)
	{
		cmd.SetComputeConstantBufferParam(cs, shaderId, m_GPUConstantBuffer, 0, m_GPUConstantBuffer.stride);
	}

	public void Set(ComputeShader cs, int shaderId)
	{
		cs.SetConstantBuffer(shaderId, m_GPUConstantBuffer, 0, m_GPUConstantBuffer.stride);
	}

	public void Set(Material mat, int shaderId)
	{
		mat.SetConstantBuffer(shaderId, m_GPUConstantBuffer, 0, m_GPUConstantBuffer.stride);
	}

	public void PushGlobal(CommandBuffer cmd, in CBType data, int shaderId)
	{
		UpdateData(cmd, in data);
		SetGlobal(cmd, shaderId);
	}

	public void PushGlobal(in CBType data, int shaderId)
	{
		UpdateData(in data);
		SetGlobal(shaderId);
	}

	public override void Release()
	{
		foreach (int globalBinding in m_GlobalBindings)
		{
			Shader.SetGlobalConstantBuffer(globalBinding, (ComputeBuffer)null, 0, 0);
		}
		m_GlobalBindings.Clear();
		CoreUtils.SafeRelease(m_GPUConstantBuffer);
	}
}
