using System;
using UnityEngine;

namespace Sirenix.Serialization;

public static class ArchitectureInfo
{
	public static bool Architecture_Supports_Unaligned_Float32_Reads;

	public static bool Architecture_Supports_All_Unaligned_ReadWrites;

	static ArchitectureInfo()
	{
		Architecture_Supports_Unaligned_Float32_Reads = false;
		Architecture_Supports_All_Unaligned_ReadWrites = false;
		Debug.Log("Odin Serializer ArchitectureInfo initialization with defaults (all unaligned read/writes disabled).");
	}

	internal unsafe static void SetRuntimePlatform(RuntimePlatform platform)
	{
		switch (platform)
		{
		case RuntimePlatform.OSXPlayer:
		case RuntimePlatform.WindowsPlayer:
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
		case RuntimePlatform.LinuxPlayer:
		case RuntimePlatform.WebGLPlayer:
		case RuntimePlatform.MetroPlayerX86:
		case RuntimePlatform.MetroPlayerX64:
		case RuntimePlatform.PS4:
		case RuntimePlatform.XboxOne:
		case RuntimePlatform.WiiU:
			try
			{
				byte[] array = new byte[8];
				fixed (byte* ptr = array)
				{
					for (int i = 0; i < 4; i++)
					{
						float num = *(float*)(ptr + i);
					}
					Architecture_Supports_Unaligned_Float32_Reads = true;
				}
			}
			catch (NullReferenceException)
			{
				Architecture_Supports_Unaligned_Float32_Reads = false;
			}
			if (Architecture_Supports_Unaligned_Float32_Reads)
			{
				Debug.Log("Odin Serializer detected whitelisted runtime platform " + platform.ToString() + " and memory read test succeeded; enabling all unaligned memory read/writes.");
				Architecture_Supports_All_Unaligned_ReadWrites = true;
			}
			else
			{
				Debug.Log("Odin Serializer detected whitelisted runtime platform " + platform.ToString() + " and memory read test failed; disabling all unaligned memory read/writes.");
			}
			break;
		default:
			Architecture_Supports_Unaligned_Float32_Reads = false;
			Architecture_Supports_All_Unaligned_ReadWrites = false;
			Debug.Log("Odin Serializer detected non-white-listed runtime platform " + platform.ToString() + "; disabling all unaligned memory read/writes.");
			break;
		}
	}
}
