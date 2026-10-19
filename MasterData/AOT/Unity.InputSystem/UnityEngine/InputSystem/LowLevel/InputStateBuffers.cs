using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

internal struct InputStateBuffers
{
	[Serializable]
	internal struct DoubleBuffers
	{
		public unsafe void** deviceToBufferMapping;

		public int deviceCount;

		public unsafe bool valid => deviceToBufferMapping != null;

		public unsafe void SetFrontBuffer(int deviceIndex, void* ptr)
		{
			if (deviceIndex < deviceCount)
			{
				deviceToBufferMapping[deviceIndex * 2] = ptr;
			}
		}

		public unsafe void SetBackBuffer(int deviceIndex, void* ptr)
		{
			if (deviceIndex < deviceCount)
			{
				deviceToBufferMapping[deviceIndex * 2 + 1] = ptr;
			}
		}

		public unsafe void* GetFrontBuffer(int deviceIndex)
		{
			if (deviceIndex < deviceCount)
			{
				return deviceToBufferMapping[deviceIndex * 2];
			}
			return null;
		}

		public unsafe void* GetBackBuffer(int deviceIndex)
		{
			if (deviceIndex < deviceCount)
			{
				return deviceToBufferMapping[deviceIndex * 2 + 1];
			}
			return null;
		}

		public unsafe void SwapBuffers(int deviceIndex)
		{
			if (valid)
			{
				void* frontBuffer = GetFrontBuffer(deviceIndex);
				void* backBuffer = GetBackBuffer(deviceIndex);
				SetFrontBuffer(deviceIndex, backBuffer);
				SetBackBuffer(deviceIndex, frontBuffer);
			}
		}
	}

	public uint sizePerBuffer;

	public uint totalSize;

	public unsafe void* defaultStateBuffer;

	public unsafe void* noiseMaskBuffer;

	public unsafe void* resetMaskBuffer;

	private unsafe void* m_AllBuffers;

	internal DoubleBuffers m_PlayerStateBuffers;

	internal unsafe static void* s_DefaultStateBuffer;

	internal unsafe static void* s_NoiseMaskBuffer;

	internal unsafe static void* s_ResetMaskBuffer;

	internal static DoubleBuffers s_CurrentBuffers;

	public DoubleBuffers GetDoubleBuffersFor(InputUpdateType updateType)
	{
		if ((uint)(updateType - 1) <= 1u || updateType == InputUpdateType.BeforeRender || updateType == InputUpdateType.Manual)
		{
			return m_PlayerStateBuffers;
		}
		throw new ArgumentException("Unrecognized InputUpdateType: " + updateType, "updateType");
	}

	public unsafe static void* GetFrontBufferForDevice(int deviceIndex)
	{
		return s_CurrentBuffers.GetFrontBuffer(deviceIndex);
	}

	public unsafe static void* GetBackBufferForDevice(int deviceIndex)
	{
		return s_CurrentBuffers.GetBackBuffer(deviceIndex);
	}

	public static void SwitchTo(InputStateBuffers buffers, InputUpdateType update)
	{
		s_CurrentBuffers = buffers.GetDoubleBuffersFor(update);
	}

	public unsafe void AllocateAll(InputDevice[] devices, int deviceCount)
	{
		sizePerBuffer = ComputeSizeOfSingleStateBuffer(devices, deviceCount);
		if (sizePerBuffer != 0)
		{
			sizePerBuffer = sizePerBuffer.AlignToMultipleOf(4u);
			uint num = (uint)(deviceCount * sizeof(void*) * 2);
			totalSize = 0u;
			totalSize += sizePerBuffer * 2;
			totalSize += num;
			totalSize += sizePerBuffer * 3;
			m_AllBuffers = UnsafeUtility.Malloc(totalSize, 4, Allocator.Persistent);
			UnsafeUtility.MemClear(m_AllBuffers, totalSize);
			byte* bufferPtr = (byte*)m_AllBuffers;
			m_PlayerStateBuffers = SetUpDeviceToBufferMappings(deviceCount, ref bufferPtr, sizePerBuffer, num);
			defaultStateBuffer = bufferPtr;
			noiseMaskBuffer = bufferPtr + sizePerBuffer;
			resetMaskBuffer = bufferPtr + sizePerBuffer * 2;
		}
	}

	private unsafe static DoubleBuffers SetUpDeviceToBufferMappings(int deviceCount, ref byte* bufferPtr, uint sizePerBuffer, uint mappingTableSizePerBuffer)
	{
		byte* ptr = bufferPtr;
		byte* ptr2 = bufferPtr + sizePerBuffer;
		void** deviceToBufferMapping = (void**)(bufferPtr + sizePerBuffer * 2);
		bufferPtr += sizePerBuffer * 2 + mappingTableSizePerBuffer;
		DoubleBuffers result = new DoubleBuffers
		{
			deviceToBufferMapping = deviceToBufferMapping,
			deviceCount = deviceCount
		};
		for (int i = 0; i < deviceCount; i++)
		{
			int deviceIndex = i;
			result.SetFrontBuffer(deviceIndex, ptr);
			result.SetBackBuffer(deviceIndex, ptr2);
		}
		return result;
	}

	public unsafe void FreeAll()
	{
		if (m_AllBuffers != null)
		{
			UnsafeUtility.Free(m_AllBuffers, Allocator.Persistent);
			m_AllBuffers = null;
		}
		m_PlayerStateBuffers = default;
		s_CurrentBuffers = default;
		if (s_DefaultStateBuffer == defaultStateBuffer)
		{
			s_DefaultStateBuffer = null;
		}
		defaultStateBuffer = null;
		if (s_NoiseMaskBuffer == noiseMaskBuffer)
		{
			s_NoiseMaskBuffer = null;
		}
		if (s_ResetMaskBuffer == resetMaskBuffer)
		{
			s_ResetMaskBuffer = null;
		}
		noiseMaskBuffer = null;
		resetMaskBuffer = null;
		totalSize = 0u;
		sizePerBuffer = 0u;
	}

	public unsafe void MigrateAll(InputDevice[] devices, int deviceCount, InputStateBuffers oldBuffers)
	{
		if (oldBuffers.totalSize != 0)
		{
			MigrateDoubleBuffer(m_PlayerStateBuffers, devices, deviceCount, oldBuffers.m_PlayerStateBuffers);
			MigrateSingleBuffer(defaultStateBuffer, devices, deviceCount, oldBuffers.defaultStateBuffer);
			MigrateSingleBuffer(noiseMaskBuffer, devices, deviceCount, oldBuffers.noiseMaskBuffer);
			MigrateSingleBuffer(resetMaskBuffer, devices, deviceCount, oldBuffers.resetMaskBuffer);
		}
		uint num = 0u;
		for (int i = 0; i < deviceCount; i++)
		{
			InputDevice inputDevice = devices[i];
			uint byteOffset = inputDevice.m_StateBlock.byteOffset;
			if (byteOffset == uint.MaxValue)
			{
				inputDevice.m_StateBlock.byteOffset = 0u;
				if (num != 0)
				{
					inputDevice.BakeOffsetIntoStateBlockRecursive(num);
				}
			}
			else
			{
				uint num2 = num - byteOffset;
				if (num2 != 0)
				{
					inputDevice.BakeOffsetIntoStateBlockRecursive(num2);
				}
			}
			num = NextDeviceOffset(num, inputDevice);
		}
	}

	private unsafe static void MigrateDoubleBuffer(DoubleBuffers newBuffer, InputDevice[] devices, int deviceCount, DoubleBuffers oldBuffer)
	{
		if (!newBuffer.valid || !oldBuffer.valid)
		{
			return;
		}
		uint num = 0u;
		for (int i = 0; i < deviceCount; i++)
		{
			InputDevice inputDevice = devices[i];
			if (inputDevice.m_StateBlock.byteOffset != uint.MaxValue)
			{
				int deviceIndex = inputDevice.m_DeviceIndex;
				int deviceIndex2 = i;
				uint alignedSizeInBytes = inputDevice.m_StateBlock.alignedSizeInBytes;
				byte* source = (byte*)oldBuffer.GetFrontBuffer(deviceIndex) + (int)inputDevice.m_StateBlock.byteOffset;
				byte* source2 = (byte*)oldBuffer.GetBackBuffer(deviceIndex) + (int)inputDevice.m_StateBlock.byteOffset;
				byte* destination = (byte*)newBuffer.GetFrontBuffer(deviceIndex2) + (int)num;
				byte* destination2 = (byte*)newBuffer.GetBackBuffer(deviceIndex2) + (int)num;
				UnsafeUtility.MemCpy(destination, source, alignedSizeInBytes);
				UnsafeUtility.MemCpy(destination2, source2, alignedSizeInBytes);
				num = NextDeviceOffset(num, inputDevice);
				continue;
			}
			break;
		}
	}

	private unsafe static void MigrateSingleBuffer(void* newBuffer, InputDevice[] devices, int deviceCount, void* oldBuffer)
	{
		uint num = 0u;
		for (int i = 0; i < deviceCount; i++)
		{
			InputDevice inputDevice = devices[i];
			if (inputDevice.m_StateBlock.byteOffset != uint.MaxValue)
			{
				uint alignedSizeInBytes = inputDevice.m_StateBlock.alignedSizeInBytes;
				byte* source = (byte*)oldBuffer + (int)inputDevice.m_StateBlock.byteOffset;
				UnsafeUtility.MemCpy((byte*)newBuffer + (int)num, source, alignedSizeInBytes);
				num = NextDeviceOffset(num, inputDevice);
				continue;
			}
			break;
		}
	}

	private static uint ComputeSizeOfSingleStateBuffer(InputDevice[] devices, int deviceCount)
	{
		uint num = 0u;
		for (int i = 0; i < deviceCount; i++)
		{
			num = NextDeviceOffset(num, devices[i]);
		}
		return num;
	}

	private static uint NextDeviceOffset(uint currentOffset, InputDevice device)
	{
		uint alignedSizeInBytes = device.m_StateBlock.alignedSizeInBytes;
		if (alignedSizeInBytes == 0)
		{
			throw new ArgumentException($"Device '{device}' has a zero-size state buffer", "device");
		}
		return currentOffset + alignedSizeInBytes.AlignToMultipleOf(4u);
	}
}
