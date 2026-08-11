using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine.U2D;

[NativeHeader("Runtime/Graphics/SpriteFrame.h")]
[NativeHeader("Runtime/2D/Common/SpriteDataAccess.h")]
public static class SpriteDataAccessExtensions
{
	private static void CheckAttributeTypeMatchesAndThrow<T>(VertexAttribute channel)
	{
		bool flag = false;
		switch (channel)
		{
		case VertexAttribute.Position:
		case VertexAttribute.Normal:
			flag = (object)typeof(T) == typeof(Vector3);
			break;
		case VertexAttribute.Tangent:
			flag = (object)typeof(T) == typeof(Vector4);
			break;
		case VertexAttribute.Color:
			flag = (object)typeof(T) == typeof(Color32);
			break;
		case VertexAttribute.TexCoord0:
		case VertexAttribute.TexCoord1:
		case VertexAttribute.TexCoord2:
		case VertexAttribute.TexCoord3:
		case VertexAttribute.TexCoord4:
		case VertexAttribute.TexCoord5:
		case VertexAttribute.TexCoord6:
		case VertexAttribute.TexCoord7:
			flag = (object)typeof(T) == typeof(Vector2);
			break;
		case VertexAttribute.BlendWeight:
			flag = (object)typeof(T) == typeof(BoneWeight);
			break;
		default:
			throw new InvalidOperationException($"The requested channel '{channel}' is unknown.");
		}
		if (!flag)
		{
			throw new InvalidOperationException($"The requested channel '{channel}' does not match the return type {typeof(T).Name}.");
		}
	}

	public unsafe static NativeSlice<T> GetVertexAttribute<T>(this Sprite sprite, VertexAttribute channel) where T : struct
	{
		CheckAttributeTypeMatchesAndThrow<T>(channel);
		SpriteChannelInfo channelInfo = GetChannelInfo(sprite, channel);
		byte* dataPointer = (byte*)channelInfo.buffer + channelInfo.offset;
		return NativeSliceUnsafeUtility.ConvertExistingDataToNativeSlice<T>(dataPointer, channelInfo.stride, channelInfo.count);
	}

	public unsafe static NativeArray<ushort> GetIndices(this Sprite sprite)
	{
		SpriteChannelInfo indicesInfo = GetIndicesInfo(sprite);
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<ushort>(indicesInfo.buffer, indicesInfo.count, Allocator.Invalid);
	}

	private static SpriteChannelInfo GetIndicesInfo([NotNull("ArgumentNullException")] Sprite sprite)
	{
		GetIndicesInfo_Injected(sprite, out var ret);
		return ret;
	}

	private static SpriteChannelInfo GetChannelInfo([NotNull("ArgumentNullException")] Sprite sprite, VertexAttribute channel)
	{
		GetChannelInfo_Injected(sprite, channel, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetIndicesInfo_Injected(Sprite sprite, out SpriteChannelInfo ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetChannelInfo_Injected(Sprite sprite, VertexAttribute channel, out SpriteChannelInfo ret);
}
