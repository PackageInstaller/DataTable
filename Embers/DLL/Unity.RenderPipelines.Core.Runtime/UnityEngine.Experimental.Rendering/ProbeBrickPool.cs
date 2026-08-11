using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

internal class ProbeBrickPool
{
	[DebuggerDisplay("Chunk ({x}, {y}, {z})")]
	public struct BrickChunkAlloc
	{
		public int x;

		public int y;

		public int z;

		internal int flattenIndex(int sx, int sy)
		{
			return z * (sx * sy) + y * sx + x;
		}
	}

	public struct DataLocation
	{
		internal Texture3D TexL0_L1rx;

		internal Texture3D TexL1_G_ry;

		internal Texture3D TexL1_B_rz;

		internal Texture3D TexL2_0;

		internal Texture3D TexL2_1;

		internal Texture3D TexL2_2;

		internal Texture3D TexL2_3;

		internal int width;

		internal int height;

		internal int depth;

		internal void Cleanup()
		{
			CoreUtils.Destroy(TexL0_L1rx);
			CoreUtils.Destroy(TexL1_G_ry);
			CoreUtils.Destroy(TexL1_B_rz);
			CoreUtils.Destroy(TexL2_0);
			CoreUtils.Destroy(TexL2_1);
			CoreUtils.Destroy(TexL2_2);
			CoreUtils.Destroy(TexL2_3);
			TexL0_L1rx = null;
			TexL1_G_ry = null;
			TexL1_B_rz = null;
			TexL2_0 = null;
			TexL2_1 = null;
			TexL2_2 = null;
			TexL2_3 = null;
		}
	}

	internal const int kBrickCellCount = 3;

	internal const int kBrickProbeCountPerDim = 4;

	internal const int kBrickProbeCountTotal = 64;

	private const int kMaxPoolWidth = 2048;

	private int m_AllocationSize;

	private ProbeVolumeTextureMemoryBudget m_MemoryBudget;

	private DataLocation m_Pool;

	private BrickChunkAlloc m_NextFreeChunk;

	private Stack<BrickChunkAlloc> m_FreeList;

	private ProbeVolumeSHBands m_SHBands;

	internal int estimatedVMemCost { get; private set; }

	internal ProbeBrickPool(int allocationSize, ProbeVolumeTextureMemoryBudget memoryBudget, ProbeVolumeSHBands shBands)
	{
		m_NextFreeChunk.x = (m_NextFreeChunk.y = (m_NextFreeChunk.z = 0));
		m_AllocationSize = allocationSize;
		m_MemoryBudget = memoryBudget;
		m_SHBands = shBands;
		m_FreeList = new Stack<BrickChunkAlloc>(256);
		DerivePoolSizeFromBudget(allocationSize, memoryBudget, out var width, out var height, out var depth);
		int allocatedBytes = 0;
		m_Pool = CreateDataLocation(width * height * depth, compressed: false, shBands, out allocatedBytes);
		estimatedVMemCost = allocatedBytes;
	}

	internal void EnsureTextureValidity()
	{
		if (m_Pool.TexL0_L1rx == null)
		{
			m_Pool.Cleanup();
			int allocatedBytes = 0;
			m_Pool = CreateDataLocation(m_Pool.width * m_Pool.height * m_Pool.depth, compressed: false, m_SHBands, out allocatedBytes);
			estimatedVMemCost = allocatedBytes;
		}
	}

	internal int GetChunkSize()
	{
		return m_AllocationSize;
	}

	internal int GetChunkSizeInProbeCount()
	{
		return m_AllocationSize * 64;
	}

	internal int GetPoolWidth()
	{
		return m_Pool.width;
	}

	internal int GetPoolHeight()
	{
		return m_Pool.height;
	}

	internal Vector3Int GetPoolDimensions()
	{
		return new Vector3Int(m_Pool.width, m_Pool.height, m_Pool.depth);
	}

	internal void GetRuntimeResources(ref ProbeReferenceVolume.RuntimeResources rr)
	{
		rr.L0_L1rx = m_Pool.TexL0_L1rx;
		rr.L1_G_ry = m_Pool.TexL1_G_ry;
		rr.L1_B_rz = m_Pool.TexL1_B_rz;
		rr.L2_0 = m_Pool.TexL2_0;
		rr.L2_1 = m_Pool.TexL2_1;
		rr.L2_2 = m_Pool.TexL2_2;
		rr.L2_3 = m_Pool.TexL2_3;
	}

	internal void Clear()
	{
		m_FreeList.Clear();
		m_NextFreeChunk.x = (m_NextFreeChunk.y = (m_NextFreeChunk.z = 0));
	}

	internal void Allocate(int numberOfBrickChunks, List<BrickChunkAlloc> outAllocations)
	{
		while (m_FreeList.Count > 0 && numberOfBrickChunks > 0)
		{
			outAllocations.Add(m_FreeList.Pop());
			numberOfBrickChunks--;
		}
		for (uint num = 0u; num < numberOfBrickChunks; num++)
		{
			if (m_NextFreeChunk.z >= m_Pool.depth)
			{
				break;
			}
			outAllocations.Add(m_NextFreeChunk);
			m_NextFreeChunk.x += m_AllocationSize * 4;
			if (m_NextFreeChunk.x >= m_Pool.width)
			{
				m_NextFreeChunk.x = 0;
				m_NextFreeChunk.y += 4;
				if (m_NextFreeChunk.y >= m_Pool.height)
				{
					m_NextFreeChunk.y = 0;
					m_NextFreeChunk.z += 4;
				}
			}
		}
	}

	internal void Deallocate(List<BrickChunkAlloc> allocations)
	{
		foreach (BrickChunkAlloc allocation in allocations)
		{
			m_FreeList.Push(allocation);
		}
	}

	internal void Update(DataLocation source, List<BrickChunkAlloc> srcLocations, List<BrickChunkAlloc> dstLocations, ProbeVolumeSHBands bands)
	{
		for (int i = 0; i < srcLocations.Count; i++)
		{
			BrickChunkAlloc brickChunkAlloc = srcLocations[i];
			BrickChunkAlloc brickChunkAlloc2 = dstLocations[i];
			for (int j = 0; j < 4; j++)
			{
				int srcWidth = Mathf.Min(m_AllocationSize * 4, source.width - brickChunkAlloc.x);
				Graphics.CopyTexture(source.TexL0_L1rx, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL0_L1rx, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
				Graphics.CopyTexture(source.TexL1_G_ry, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL1_G_ry, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
				Graphics.CopyTexture(source.TexL1_B_rz, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL1_B_rz, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
				if (bands == ProbeVolumeSHBands.SphericalHarmonicsL2)
				{
					Graphics.CopyTexture(source.TexL2_0, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL2_0, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
					Graphics.CopyTexture(source.TexL2_1, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL2_1, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
					Graphics.CopyTexture(source.TexL2_2, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL2_2, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
					Graphics.CopyTexture(source.TexL2_3, brickChunkAlloc.z + j, 0, brickChunkAlloc.x, brickChunkAlloc.y, srcWidth, 4, m_Pool.TexL2_3, brickChunkAlloc2.z + j, 0, brickChunkAlloc2.x, brickChunkAlloc2.y);
				}
			}
		}
	}

	private static Vector3Int ProbeCountToDataLocSize(int numProbes)
	{
		int num = numProbes / 64;
		int num2 = 512;
		int num3 = (num + num2 * num2 - 1) / (num2 * num2);
		int num4;
		int num5;
		if (num3 > 1)
		{
			num4 = (num5 = num2);
		}
		else
		{
			num5 = (num + num2 - 1) / num2;
			num4 = ((num5 <= 1) ? num : num2);
		}
		num4 *= 4;
		num5 *= 4;
		num3 *= 4;
		return new Vector3Int(num4, num5, num3);
	}

	public static DataLocation CreateDataLocation(int numProbes, bool compressed, ProbeVolumeSHBands bands, out int allocatedBytes)
	{
		Vector3Int vector3Int = ProbeCountToDataLocSize(numProbes);
		int x = vector3Int.x;
		int y = vector3Int.y;
		int z = vector3Int.z;
		int num = x * y * z;
		allocatedBytes = 0;
		DataLocation result = default(DataLocation);
		result.TexL0_L1rx = new Texture3D(x, y, z, GraphicsFormat.R16G16B16A16_SFloat, TextureCreationFlags.None, 1);
		allocatedBytes += num * 8;
		result.TexL1_G_ry = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
		allocatedBytes += num * (compressed ? 1 : 4);
		result.TexL1_B_rz = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
		allocatedBytes += num * (compressed ? 1 : 4);
		if (bands == ProbeVolumeSHBands.SphericalHarmonicsL2)
		{
			result.TexL2_0 = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
			allocatedBytes += num * (compressed ? 1 : 4);
			result.TexL2_1 = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
			allocatedBytes += num * (compressed ? 1 : 4);
			result.TexL2_2 = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
			allocatedBytes += num * (compressed ? 1 : 4);
			result.TexL2_3 = new Texture3D(x, y, z, compressed ? GraphicsFormat.RGBA_BC7_UNorm : GraphicsFormat.R8G8B8A8_UNorm, TextureCreationFlags.None, 1);
			allocatedBytes += num * (compressed ? 1 : 4);
		}
		else
		{
			result.TexL2_0 = null;
			result.TexL2_1 = null;
			result.TexL2_2 = null;
			result.TexL2_3 = null;
		}
		result.width = x;
		result.height = y;
		result.depth = z;
		return result;
	}

	private static void SetPixel(ref Color[] data, int x, int y, int z, int dataLocWidth, int dataLocHeight, Color value)
	{
		int num = x + dataLocWidth * (y + dataLocHeight * z);
		data[num] = value;
	}

	public static void FillDataLocation(ref DataLocation loc, SphericalHarmonicsL2[] shl2, ProbeVolumeSHBands bands)
	{
		_ = shl2.Length / 64;
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		Color value = default(Color);
		Color[] data = new Color[loc.width * loc.height * loc.depth * 2];
		Color[] data2 = new Color[loc.width * loc.height * loc.depth * 2];
		Color[] data3 = new Color[loc.width * loc.height * loc.depth * 2];
		Color[] data4 = null;
		Color[] data5 = null;
		Color[] data6 = null;
		Color[] data7 = null;
		if (bands == ProbeVolumeSHBands.SphericalHarmonicsL2)
		{
			data4 = new Color[loc.width * loc.height * loc.depth];
			data5 = new Color[loc.width * loc.height * loc.depth];
			data6 = new Color[loc.width * loc.height * loc.depth];
			data7 = new Color[loc.width * loc.height * loc.depth];
		}
		for (int i = 0; i < shl2.Length; i += 64)
		{
			for (int j = 0; j < 4; j++)
			{
				for (int k = 0; k < 4; k++)
				{
					for (int l = 0; l < 4; l++)
					{
						int x = num2 + l;
						int y = num3 + k;
						int z = num4 + j;
						value.r = shl2[num][0, 0];
						value.g = shl2[num][1, 0];
						value.b = shl2[num][2, 0];
						value.a = shl2[num][0, 1];
						SetPixel(ref data, x, y, z, loc.width, loc.height, value);
						value.r = shl2[num][1, 1];
						value.g = shl2[num][1, 2];
						value.b = shl2[num][1, 3];
						value.a = shl2[num][0, 2];
						SetPixel(ref data2, x, y, z, loc.width, loc.height, value);
						value.r = shl2[num][2, 1];
						value.g = shl2[num][2, 2];
						value.b = shl2[num][2, 3];
						value.a = shl2[num][0, 3];
						SetPixel(ref data3, x, y, z, loc.width, loc.height, value);
						if (bands == ProbeVolumeSHBands.SphericalHarmonicsL2)
						{
							value.r = shl2[num][0, 4];
							value.g = shl2[num][0, 5];
							value.b = shl2[num][0, 6];
							value.a = shl2[num][0, 7];
							SetPixel(ref data4, x, y, z, loc.width, loc.height, value);
							value.r = shl2[num][1, 4];
							value.g = shl2[num][1, 5];
							value.b = shl2[num][1, 6];
							value.a = shl2[num][1, 7];
							SetPixel(ref data5, x, y, z, loc.width, loc.height, value);
							value.r = shl2[num][2, 4];
							value.g = shl2[num][2, 5];
							value.b = shl2[num][2, 6];
							value.a = shl2[num][2, 7];
							SetPixel(ref data6, x, y, z, loc.width, loc.height, value);
							value.r = shl2[num][0, 8];
							value.g = shl2[num][1, 8];
							value.b = shl2[num][2, 8];
							value.a = 1f;
							SetPixel(ref data7, x, y, z, loc.width, loc.height, value);
						}
						num++;
					}
				}
			}
			num2 += 4;
			if (num2 >= loc.width)
			{
				num2 = 0;
				num3 += 4;
				if (num3 >= loc.height)
				{
					num3 = 0;
					num4 += 4;
				}
			}
		}
		loc.TexL0_L1rx.SetPixels(data);
		loc.TexL0_L1rx.Apply(updateMipmaps: false);
		loc.TexL1_G_ry.SetPixels(data2);
		loc.TexL1_G_ry.Apply(updateMipmaps: false);
		loc.TexL1_B_rz.SetPixels(data3);
		loc.TexL1_B_rz.Apply(updateMipmaps: false);
		if (bands == ProbeVolumeSHBands.SphericalHarmonicsL2)
		{
			loc.TexL2_0.SetPixels(data4);
			loc.TexL2_0.Apply(updateMipmaps: false);
			loc.TexL2_1.SetPixels(data5);
			loc.TexL2_1.Apply(updateMipmaps: false);
			loc.TexL2_2.SetPixels(data6);
			loc.TexL2_2.Apply(updateMipmaps: false);
			loc.TexL2_3.SetPixels(data7);
			loc.TexL2_3.Apply(updateMipmaps: false);
		}
	}

	private void DerivePoolSizeFromBudget(int allocationSize, ProbeVolumeTextureMemoryBudget memoryBudget, out int width, out int height, out int depth)
	{
		width = (int)memoryBudget;
		height = (int)memoryBudget;
		depth = 4;
	}

	internal void Cleanup()
	{
		m_Pool.Cleanup();
	}
}
