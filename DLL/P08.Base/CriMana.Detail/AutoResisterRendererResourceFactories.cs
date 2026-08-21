using System;
using System.Reflection;
using UnityEngine;
using UnityEngine.Scripting;

namespace CriMana.Detail;

public static class AutoResisterRendererResourceFactories
{
	[Preserve]
	[RendererResourceFactoryPriority(7050)]
	public class RendererResourceFactoryH264Yuv : RendererResourceFactory
	{
		public override RendererResource CreateRendererResource(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
		{
			if (movieInfo.codecType != CodecType.H264)
			{
				return null;
			}
			return new RendererResourceH264Yuv(playerId, movieInfo, additive, userShader);
		}

		protected override void OnDisposeManaged()
		{
		}

		protected override void OnDisposeUnmanaged()
		{
		}
	}

	[Preserve]
	[RendererResourceFactoryPriority(10000)]
	public class RendererResourceFactorySofdecPrimeYuvRawData : RendererResourceFactory
	{
		public override RendererResource CreateRendererResource(int playerId, MovieInfo movieInfo, bool additive, Shader userShader)
		{
			if (!((movieInfo.codecType == CodecType.SofdecPrime) | (movieInfo.codecType == CodecType.VP9 || movieInfo.codecType == CodecType.AV1)))
			{
				return null;
			}
			return new RendererResourceSofdecPrimeYuvRawData(playerId, movieInfo, additive, userShader);
		}

		protected override void OnDisposeManaged()
		{
		}

		protected override void OnDisposeUnmanaged()
		{
		}
	}

	public static void InvokeAutoRegister()
	{
		Type[] nestedTypes = typeof(AutoResisterRendererResourceFactories).GetNestedTypes(BindingFlags.Public);
		foreach (Type type in nestedTypes)
		{
			if (!type.IsSubclassOf(typeof(RendererResourceFactory)))
			{
				Debug.LogError("[CRIWARE] internal logic error. " + type.Name + " is required to be a subclass of RendererResourceFactory.");
				continue;
			}
			RendererResourceFactoryPriorityAttribute rendererResourceFactoryPriorityAttribute = (RendererResourceFactoryPriorityAttribute)Attribute.GetCustomAttribute(type, typeof(RendererResourceFactoryPriorityAttribute));
			if (rendererResourceFactoryPriorityAttribute == null)
			{
				Debug.LogError("[CRIWARE] internal logic error. need priority attribute. (" + type.Name + ")");
			}
			else
			{
				RendererResourceFactory.RegisterFactory((RendererResourceFactory)Activator.CreateInstance(type), rendererResourceFactoryPriorityAttribute.priority);
			}
		}
	}
}
